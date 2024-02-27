use nexgencosysdbdev
	CREATE TABLE #CurrentLoan
	(
		--ID BIGINT IDENTITY(1,1) NOT NULL,
		LmtLoanIssueId bigint,
		LoanAccountNo nvarchar(max),
		RemainingPrinciple numeric(18,2),
		InterestReceivableTillDateOn date,
		PenaltyReceivableTillDateOn date,
		SchedulePrinciple numeric(18,2),
	)	
	
	INSERT INTO #CurrentLoan
	SELECT L.LmtLoanIssueId,
		   l.LoanAccountNo,
		   DBO.fn_GetLoanPrincipleBalance(L.LoanAccountNo),
		   L.InterestReceivableTillDateOn,
		   L.PenaltyReceivableTillDateOn,
		   (SELECT SUM(S.PrincipleAmount) FROM LmtLoanSchedule AS S WHERE S.LmtLoanIssueId=L.LmtLoanIssueId AND S.IsActive=1)
	FROM LmtLoanIssue AS L WHERE L.LmtLoanStatusId=1 AND L.TransStatus IN ('I','R') AND L.IsActive=1 AND L.IsVerified=1 AND L.LoanODorNormal='N' 

	DECLARE
			@LmtLoanIssueId bigint,
			@LoanAccountNo nvarchar(max),
			@RemainingPrinciple numeric(18,2),
			@InterestReceivableTillDateOn date,
			@PenaltyReceivableTillDateOn date,
			@SchedulePrinciple numeric(18,2)

					
	DECLARE c1 CURSOR FOR  
	SELECT  
			LmtLoanIssueId ,
			LoanAccountNo,
			RemainingPrinciple,
			InterestReceivableTillDateOn,		
			PenaltyReceivableTillDateOn,
			SchedulePrinciple
	FROM #CurrentLoan WHERE SchedulePrinciple != RemainingPrinciple

	
	OPEN c1   
	FETCH NEXT FROM c1 INTO
			@LmtLoanIssueId ,
			@LoanAccountNo,
			@RemainingPrinciple,
			@InterestReceivableTillDateOn,		
			@PenaltyReceivableTillDateOn,
			@SchedulePrinciple

	---------------------Loop For Loan----------------------------
	WHILE  @@FETCH_STATUS = 0  
		BEGIN			
			IF(@SchedulePrinciple>@RemainingPrinciple)
			BEGIN
				
				DECLARE
						@LmtLoanScheduleId bigint,
						@PrincipleAmount numeric(18,2)

				DECLARE c2 CURSOR FOR  
				SELECT  
						LmtLoanScheduleId ,
						PrincipleAmount
				FROM  LmtLoanSchedule as s where s.LmtLoanIssueId=@LmtLoanIssueId order by LmtLoanScheduleId asc
								
				OPEN c2   
				FETCH NEXT FROM c2 INTO
						@LmtLoanScheduleId ,
						@PrincipleAmount

				WHILE  @@FETCH_STATUS = 0  
				BEGIN
					
					DECLARE @DifferenceAmount NUMERIC(18,2)=@SchedulePrinciple-@RemainingPrinciple
					IF(@DifferenceAmount >0 AND @PrincipleAmount>@DifferenceAmount)
					BEGIN
						UPDATE LmtLoanSchedule SET PrincipleAmount=PrincipleAmount-@DifferenceAmount WHERE LmtLoanScheduleId=@LmtLoanScheduleId
						SET @SchedulePrinciple=@SchedulePrinciple-@DifferenceAmount
					END
					ELSE IF(@DifferenceAmount >0 )
					BEGIN
						UPDATE LmtLoanSchedule SET PrincipleAmount=0 WHERE LmtLoanScheduleId=@LmtLoanScheduleId
						SET @SchedulePrinciple=@SchedulePrinciple-@PrincipleAmount
					END
					 
					FETCH NEXT FROM c2 INTO
							@LmtLoanScheduleId ,
							@PrincipleAmount
				END
				
				CLOSE c2   
				DEALLOCATE c2

			END
			ELSE IF(@SchedulePrinciple<@RemainingPrinciple)
			BEGIN
				DECLARE @COUNT INT=0
				SELECT TOP 1 * INTO #TEMPSCHEDULE FROM LmtLoanSchedule WHERE LmtLoanIssueId=@LmtLoanIssueId AND ScheduleDateOn<GETDATE() ORDER BY LoanFrequency DESC
				SET @COUNT=(SELECT COUNT(*) FROM #TEMPSCHEDULE)
				IF(@COUNT>0)
				BEGIN
					DECLARE @LmtLoanScheduleIdCurr INT=0
					SET @LmtLoanScheduleIdCurr=(SELECT TOP 1 LmtLoanScheduleId FROM #TEMPSCHEDULE)
					
					UPDATE LmtLoanSchedule SET PrincipleAmount=PrincipleAmount+(@RemainingPrinciple-@SchedulePrinciple) WHERE LmtLoanScheduleId=@LmtLoanScheduleIdCurr
					UPDATE LmtLoanSchedule SET InstallmentAmount=PrincipleAmount+InterestAmount WHERE LmtLoanScheduleId=@LmtLoanScheduleIdCurr
					UPDATE LmtLoanSchedule SET IsPaid=0 WHERE LmtLoanScheduleId=@LmtLoanScheduleIdCurr
				END
				ELSE
				BEGIN
					SELECT TOP 1 * INTO #TEMPSCHEDULECURR FROM LmtLoanSchedule WHERE LmtLoanIssueId=@LmtLoanIssueId ORDER BY LoanFrequency ASC
					SET @COUNT=(SELECT COUNT(*) FROM #TEMPSCHEDULECURR)
					IF(@COUNT>0)
					BEGIN
						DECLARE @LmtLoanScheduleIdCurrNew INT=0
						SET @LmtLoanScheduleIdCurr=(SELECT TOP 1 LmtLoanScheduleId FROM #TEMPSCHEDULECURR)
					
						UPDATE LmtLoanSchedule SET PrincipleAmount=PrincipleAmount+(@RemainingPrinciple-@SchedulePrinciple) WHERE LmtLoanScheduleId=@LmtLoanScheduleIdCurrNew
						UPDATE LmtLoanSchedule SET InstallmentAmount=PrincipleAmount+InterestAmount WHERE LmtLoanScheduleId=@LmtLoanScheduleIdCurrNew
						UPDATE LmtLoanSchedule SET IsPaid=0 WHERE LmtLoanScheduleId=@LmtLoanScheduleIdCurrNew
					END
					
					DROP TABLE #TEMPSCHEDULECURR
				END
				DROP TABLE #TEMPSCHEDULE
			END
						
			UPDATE LmtLoanSchedule SET InterestAmount=0 WHERE ScheduleDateOn<=@InterestReceivableTillDateOn AND LmtLoanIssueId=@LmtLoanIssueId
			UPDATE LmtLoanSchedule SET InstallmentAmount=PrincipleAmount+InterestAmount WHERE LmtLoanIssueId=@LmtLoanIssueId
			UPDATE LmtLoanSchedule SET IsPaid=1 WHERE LmtLoanIssueId=@LmtLoanIssueId AND InstallmentAmount<=0
			UPDATE LmtLoanSchedule SET InstallmentPaidOn=CAST(GETDATE() AS DATE) WHERE LmtLoanIssueId=@LmtLoanIssueId AND InstallmentAmount<=0 AND InstallmentPaidOn IS NULL
			UPDATE LmtLoanSchedule SET InstallmentPaidOnBS=DBO.ConvertDateEnglishToNepali(CAST(GETDATE() AS DATE)) WHERE LmtLoanIssueId=@LmtLoanIssueId AND InstallmentAmount<=0 AND InstallmentPaidOn IS NULL


			FETCH NEXT FROM c1 INTO
					@LmtLoanIssueId ,
					@LoanAccountNo,
					@RemainingPrinciple,
					@InterestReceivableTillDateOn,		
					@PenaltyReceivableTillDateOn,
					@SchedulePrinciple
		END

			
    CLOSE c1   
	DEALLOCATE c1

	SELECT * FROM #CurrentLoan WHERE SchedulePrinciple!=RemainingPrinciple
	--DROP TABLE #CurrentLoan 
	

