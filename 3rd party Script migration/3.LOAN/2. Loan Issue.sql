USE NexGenCoSysDBDev

delete from lmtloanissue
dbcc checkident ('lmtloanissue',reseed,0)

INSERT INTO NexGenCoSysDBDev.[dbo].[LmtLoanIssue]
([MemMemberRegistrationId]
            ,[LoanAccountNo]
            ,[LmtLoanTypeMasterId]
            ,[LoanSanctionAmount]
            ,[LoanIssueAmount]
            ,[Period]
            ,[PeriodType]
            ,[LmtPaymentDurationTypeId]
            ,[InterestRate]
            ,[LmtLoanPaymentTypeId]
            ,[LoanIssueOn]
            ,[LoanIssueOnBs]
            ,[PrinciplePaidFrom]
            ,[PrinciplePaidAfterEach]
            ,[MaturityOn]
            ,[MaturityOnBs]
            ,[LmtLoanPaymentMethodId]
            ,[NetPaidAmount]
            ,[LmtLoanStatusId]
            ,[MamAccountOpeningId]
            ,[LoanODorNormal]
            ,[RevolvingSanctionAmount]
            ,[RevolvingSavingACId]
            ,[RevolvingBalanceAmount]
            ,[HurCollectorId]
            ,[UsmOfficeId]
            ,[TransStatus]
            ,[IsVerified]
            ,[VerifiedBy]
            ,[VerifiedOn]
            ,[CreatedBy]
            ,[CreatedOn]
            ,[LastModifiedBy]
            ,[LastModifiedOn]
            ,[IsActive]
            ,[Remarks]
            ,[LoanGuarantee]
            ,[IsEdited]
            ,[IsPosted]
            ,[InterestReceivableAmount]
            ,[InterestReceivableTillDateOnBs]
            ,[InterestReceivableTillDateOn]
            ,[PenaltyReceivableAmount]
            ,[PenaltyReceivableTillDateOnBs]           
            ,[PenaltyReceivableTillDateOn]
            ,[InstallamentAmount]
            ,[InstallmentType]
            ,[PenaltyPaymentMethod]
            ,[LoanPaymentMethod]
            ,[LoanCloseOn]
            ,[LoanCloseOnBs]
            ,[SycSmsCategoryId]
            ,[IsProcessed]           
           )     
SELECT
       (SELECT TOP 1 MemMemberRegistrationId FROM MemMemberRegistration WHERE CAST(Remarks AS NVARCHAR) = CAST(CusCidNo AS NVARCHAR))--MEMBERREGISTRATION
      ,AcctNo--ACCOUNT
      ,(SELECT TOP 1 LmtLoanTypeMasterId FROM LmtLoanTypeMaster WHERE LoanTypeCode = GlsubHead)--LOANTYPE
      ,LApproAmt--SANCTION
      ,(LPrincAMt) --ISSUE
      ,CASE WHEN LDuration='' THEN 0
	        WHEN LDuration IS NULL THEN 0 
			ELSE LDuration
			END--PERIOD
      ,'M'--TYPE
	  ,1
      ,LInterestRate--INTEREST
      ,1
      ,dbo.ConvertDateNepaliToEnglish(lnepagreedate)--OPEN DATE
      ,lnepagreedate
      ,0
      ,0
      ,CASE WHEN lnepmaturitydate='' THEN DBO.ConvertDateNepaliToEnglish(lnepagreedate) ELSE DBO.ConvertDateNepaliToEnglish(lnepmaturitydate) END--MATURITY ENGLISH
      ,CASE WHEN lnepmaturitydate=''THEN lnepagreedate ELSE lnepmaturitydate END--MATURITY NEPALI
	  ,1--EMI
	  ,(LPrincAMt) --NET PAYMENT AMOUNT
	  ,CASE WHEN LStatus = '50' THEN 3
			 WHEN LStatus = '01' THEN 1
			 ELSE 1 END --LOAN STATUS
	  ,NULL
	  ,'N'--OD OR NORMAL
	  ,0--REVOLVING SANSACTION AMOUNT
	  ,NULL  -- SAVING ACCOUNT
	  ,0 --REVOLVING BALANCE AMOUNT
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)
	  ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice)
	  ,'I'
	  ,1 -- IS VERIFIED
	  ,0 -- VERIFIED BY 
	  ,dbo.ConvertDateNepaliToEnglish(lnepagreedate) -- VERIFIED ON
	  ,0
	  ,GETDATE() -- CREATED ON
	  ,NULL
	  ,NULL
      ,1
      ,CAST(AcctNo AS NVARCHAR) -- REMARKS
      , 'Collateral' 
      ,0 -- IS EDITED
      ,1
      ,LAccurInterest --INTEREST RECEIVABLE AMOUNT     
      ,(LIntCalDate-1) --interestreceivabletilldateonbs
      ,null--interestreceivabletilldateon
      ,LAccurPenal -- PENALTY RECEIVABLE AMOUNT    
      ,(LIntCalDate-1)--penaltyreceivabletilldateonbs
      ,null--penaltyreceivabletilldateon
      ,0 -- INSTALLMENT AMOUNT
      ,'AOD' -- INSTALLMENT TYPE
      ,3 --PENALTY PAYMENT TYPE P+I
      ,1 -- LOAN PAYMENT TYPE
      ,CASE WHEN LStatus='50' THEN dbo.ConvertDateNepaliToEnglish( lnepmaturitydate) ELSE NULL END
      ,CASE WHEN LStatus='50' THEN lnepmaturitydate ELSE NULL END
      ,1 
      ,1--IS PROCESSED
 FROM Finact.dbo.Loan 
 go
 UPDATE lmtloanissue set InterestReceivableTillDateOnBs = (select DateNepali from Finact.dbo.DateNumber where InterestReceivableTillDateOnBs=dateNumber)
 GO
 UPDATE LMTLOANISSUE SET InterestReceivableTillDateOn=DBO.ConvertDateNepaliToEnglish(InterestReceivableTillDateOnBs)
 GO
 UPDATE LMTLOANISSUE SET PenaltyReceivableTillDateOnBs=(select DateNepali from Finact.dbo.DateNumber where PenaltyReceivableTillDateOnBs=dateNumber)
 GO
 UPDATE LMTLOANISSUE SET PenaltyReceivableTillDateOn=DBO.ConvertDateNepaliToEnglish(PenaltyReceivableTillDateOnBs)
 GO
SELECT*FROM LmtLoanIssue