USE [NexGenCoSysDBDev];
IF OBJECT_ID('[migrationtest]', 'P') IS NOT NULL
    DROP PROCEDURE migrationtest;
GO
GO

/****** Object:  StoredProcedure [dbo].[migrationtest]    Script Date: 1/28/2019 12:36:31 PM ******/

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE PROCEDURE [dbo].[migrationtest]
AS
    BEGIN
        CREATE TABLE #temp
        (tabletype NVARCHAR(255), 
         Details   NVARCHAR(MAX), 
         Remarks   NVARCHAR(MAX)
        );
        --member registration----------
        IF
        (
            SELECT MAX(CAST(SUBSTRING(memberid, (CHARINDEX('-', memberid, CHARINDEX('-', memberid) + 1) + 1), 50) AS NUMERIC))
            FROM MemMemberRegistration
            WHERE memberid LIKE 'MR%'
        ) =
        (
            SELECT MasterCodeValue
            FROM SycMasterCode
            WHERE SycMasterCodeId = 1
        )
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Memberregistration', 
                 'The memberid code value is updated', 
                 SPACE(10000)
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Memberregistration', 
                 'Please check memberid code', 
                 'Error'
                );
        END;
		PRINT 'MEMBER REGISTRATION CODE VALUE ENDED'
        -----memeber registration end------------
        ---member registration other field update start----
        IF
        (
            SELECT COUNT(MemberId)
            FROM MemMemberRegistration
            WHERE SycStateVDCId IS NULL
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Memmemberregistration', 
                 'Update the sycstatevdcid', 
                 'Error'
                );
        END;
            ELSE
            BEGIN
                IF
                (
                    SELECT COUNT(memberid)
                    FROM MemMemberRegistration
                    WHERE CitizenShipIssuedOn IS NULL
                ) != 0
                    BEGIN
                        INSERT INTO #temp
                        VALUES
                        ('Memmemberregistration', 
                         'Update the citizenshipissuedon', 
                         'Error'
                        );
                END;
                    ELSE
                    BEGIN
                        IF
                        (
                            SELECT COUNT(MemberId)
                            FROM MemMemberRegistration
                            WHERE CitizenShipIssuedOnbs IS NULL
                        ) != 0
                            BEGIN
                                INSERT INTO #temp
                                VALUES
                                ('Memmemberregistration', 
                                 'Update the citizenshipissuedonbs', 
                                 'Error'
                                );
                        END;
                            ELSE
                            INSERT INTO #temp
                            VALUES
                            ('Memmemberregistration', 
                             'The required field is correct', 
                             ''
                            );
                END;
        END;
		PRINT 'MEMBER REGISTRATION OTHER FIELD ENDED'

        ---member registration other filed update end-----
        --Deposit Type code value---------------

        IF
        (
            SELECT COUNT(*)
            FROM sycdeposittype SDT
                 INNER JOIN
            (
                SELECT MAX(CAST(SUBSTRING(accountno, LEN(AccountNo) - CHARINDEX('-', REVERSE(accountno)) + 2, 50) AS NUMERIC)) CODE, 
                       sycdeposittypeid
                FROM mamaccountopening
                GROUP BY sycdeposittypeid
            ) A ON SDT.SYCDEPOSITTYPEID = A.SYCDEPOSITTYPEID
            WHERE SDT.CODEVALUE != A.CODE
        ) = 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Deposittype', 
                 'The code value of deposit is correctly updated', 
                 SPACE(10000)
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Deposittype', 
                 'Please udpate deposit code value correctly', 
                 'Error'
                );
        END;

		--DEPOSIT CODE VALUE CHECKING END---

        IF
        (
            SELECT COUNT(deposittypename)
            FROM SycDepositType
            WHERE CodeValue IS NULL and IsActive=1
        ) = 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Deposittype', 
                 'Codevalue does not contain null value', 
                 ''
                );
        END;
            ELSE
            INSERT INTO #temp
            VALUES
            ('Deposittype', 
             'Codevalue contains null', 
             'Error'
            );

        --deposit type code end---------------
        --duration other than normal start------------
        IF
        (
            SELECT COUNT(*)
            FROM SycDepositType
            WHERE SycDepositCategoryId != 1
                  AND Duration <= '0'
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Deposittype', 
                 'Please check the duration of the deposit schemes other than normal category', 'Error'
                 
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Deposittype', 
                 'The duration is correct', 
                 SPACE(10000)
                );
        END;
        --duration type other than normal end----
        --maturity date of other than normal start-----
        IF
        (
            SELECT COUNT(MaturityOnBs)
            FROM MamAccountOpening
            WHERE SycDepositTypeId IN
            (
                SELECT SycDepositTypeid
                FROM sycdeposittype
                WHERE SycDepositCategoryId != 1
            )
                  AND MamAccountStatusId = 1
                  AND MaturityOnBs IS NULL
        ) = 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('mamaccountopening', 
                 'The maturity date is updated of schemes other than normal', 
                 SPACE(10000)
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('mamaccountopening', 
                 'Please update the maturity date', 
                 'Error'
                );
        END;

        ---maturity date other than normal end-------------

		--last interest  date and accountopening date same-----
		IF
		(
		select count(*)  From MamAccountOpening
		where AccountOpenOnBs=LastInterestDateOnBs and MamAccountStatusId=1)
		!=0
		begin 
		insert into #temp VALUES
		('mamaccountopening',
		'Please change the lastinterest date into null',
		'Error'
		);
		END
		else
		BEGIN
		insert into #temp
		VALUES
		('Mamaccountopening',
		 'Last interest date is correctly updated',
		 space(1000));
		 END;

		--end of lastinterest date and accountopeningidate-----



        --interest transfer link of fixed start-----------
        IF
        (
            SELECT COUNT(AccountNo)
            FROM MamAccountOpening
            WHERE SycDepositTypeId IN
            (
                SELECT SycDepositTypeid
                FROM sycdeposittype
                WHERE SycDepositCategoryId = 3
            )
                  AND MamAccountStatusId = 1
                  AND MamInterestTransferAccountOpeningId IS NULL
        ) = 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('mamaccountopening', 
                 'The fixed interest link is updated', 
                 SPACE(10000)
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('mamaccountopening', 
                 'PLease update the interesttransferlink of fixed deposit account','Error'
                
                );
        END;
        --fixed interest transfer link end-------
        ---for term deposit ---
        IF
        (
            SELECT COUNT(accountno)
            FROM MamAccountOpening
            WHERE SycDepositTypeId IN
            (
                SELECT SycDepositTypeId
                FROM SycDepositType
                WHERE SycDepositCategoryId IN(4)
            )
            AND (TermDepositInstallmentAmount = NULL
                 OR TermDepositInstallmentAmount = 0)
            AND MamAccountStatusId = 1
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'Please update the term deposit TermDepositInstallmentAmount', 
                'Error'
                );
        END;
            ELSE
            BEGIN
                IF
                (
                    SELECT COUNT(accountno)
                    FROM MamAccountOpening
                    WHERE SycDepositTypeId IN
                    (
                        SELECT SycDepositTypeId
                        FROM SycDepositType
                        WHERE SycDepositCategoryId IN(4)
                    )
                    AND (TermDepositMaturityAmount = NULL
                         OR TermDepositMaturityAmount = 0)
                    AND MamAccountStatusId = 1
                ) != 0
                    BEGIN
                        INSERT INTO #temp
                        VALUES
                        ('Mamaccountopening', 
                         'Please update the term deposit TermDepositMaturityAmount', 
                         'Error'
                        );
                END;
                    ELSE
                    BEGIN
                        IF
                        (
                            SELECT COUNT(accountno)
                            FROM MamAccountOpening
                            WHERE SycDepositTypeId IN
                            (
                                SELECT SycDepositTypeId
                                FROM SycDepositType
                                WHERE SycDepositCategoryId IN(4)
                            )
                            AND (TermDepositNoOfInstallment = NULL
                                 OR TermDepositNoOfInstallment = 0)
                            AND MamAccountStatusId = 1
                        ) != 0
                            BEGIN
                                INSERT INTO #temp
                                VALUES
                                ('Mamaccountopening', 
                                 'Please update the term deposit TermDepositNoOfInstallment', 
                                 'Error'
                                );
                        END;
                            ELSE
                            BEGIN
                                IF
                                (
                                    SELECT COUNT(accountno)
                                    FROM MamAccountOpening
                                    WHERE SycDepositTypeId IN
                                    (
                                        SELECT SycDepositTypeId
                                        FROM SycDepositType
                                        WHERE SycDepositCategoryId IN(4)
                                    )
                                    AND (TermDepositNoOfInstallmentType NOT IN('D', 'M', 'Y')
                                    OR TermDepositNoOfInstallmentType IS NULL)
                                    AND MamAccountStatusId = 1
                                ) != 0
                                    BEGIN
                                        INSERT INTO #temp
                                        VALUES
                                        ('Mamaccountopening', 
                                         'Please update the term deposit TermDepositNoOfInstallmentType', 
                                         'Error'
                                        );
                                END;
                                    ELSE
                                    BEGIN
                                        INSERT INTO #temp
                                        VALUES
                                        ('Mamaccountopening', 
                                         'The term deposit accounts is updated correctly', 
                                         space(1000)
                                        );
                                END;
                        END;
                END;
        END;
        ---   end of term deposit             ----------------------
        ---regular category flag check----------------
        IF
        (
            SELECT COUNT(accountno)
            FROM MamAccountOpening
            WHERE SycDepositTypeId IN
            (
                SELECT SycDepositTypeId
                FROM SycDepositType
                WHERE SycDepositCategoryId IN(6)
            )
            AND (TermDepositInstallmentAmount IS NULL
                 OR TermDepositInstallmentAmount = 0)
            AND MamAccountStatusId = 1
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'Please update the termdepositinstallment amount of regular saving', 
                 'Error'
                );
        END;
            ELSE
            BEGIN
                IF
                (
                    SELECT COUNT(accountno)
                    FROM MamAccountOpening
                    WHERE SycDepositTypeId IN
                    (
                        SELECT SycDepositTypeId
                        FROM SycDepositType
                        WHERE SycDepositCategoryId IN(6)
                    )
                    AND (SycDepositMethodTypeId IS NULL
                         OR SycDepositMethodTypeId NOT IN(1, 2, 3, 4, 5, 6))
                    AND MamAccountStatusId = 1
                ) != 0
                    BEGIN
                        INSERT INTO #temp
                        VALUES
                        ('Mamaccountopening', 
                         'Please udpate the sycdepositmethodtypeid of regular account', 
                         'Error'
                        );
                END;
                    ELSE
                    BEGIN
                        INSERT INTO #temp
                        VALUES
                        ('Mamaccountopening', 
                         'The regular category is correctly updated.', 
                         SPACE(10000)
                        );
                END;
        END;
        -------end of regular category flags--------------
        -----start of the double accountno if any------
        IF
        (
            SELECT COUNT(a.accountno)
            FROM
            (
                SELECT COUNT(accountno) accountno
                FROM MamAccountOpening
                WHERE MamAccountStatusId = 1
                GROUP BY AccountNo
                HAVING COUNT(accountno) > 1
            ) a
        ) <> 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'Same Account no for different members please update', 
                 'error'
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'The accountno is correctly updated', 
                 SPACE(10000)
                );
        END;
        ----end of the double account if any--------
        ----start of the fixed interest calc flag-------------
        IF
        (
            SELECT COUNT(accountno)
            FROM mamaccountopening
            WHERE sycdeposittypeid IN
            (
                SELECT SycDepositTypeId
                FROM SycDepositType
                WHERE SycDepositCategoryId = 3
                      AND SycInterestCalculationPeriodId != 5
            )
                  AND (SycInterestCalculationTypeId != 5
                       AND SycInterestCalculationTypeId IS NOT NULL)
                  AND MamAccountStatusId = 1
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'PLease check the fixed sycinterestcalculationtypeid flag', 
                 'Error'
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'The fixed sycinterestcalculationtypeid is correct', 
                 ''
                );
        END;

        ---end of sycinterestcalculationtypeid flag of fixed---------------------
        ---start of the fixed deposit interset rate flag-----------------------------
        IF
        (
            SELECT COUNT(accountno)
            FROM mamaccountopening
            WHERE SycDepositTypeId IN
            (
                SELECT sycdeposittypeid
                FROM sycdeposittype
                WHERE sycdepositcategoryid = 3
            )
                  AND mamaccountstatusid = 1
                  AND InterestRate IS NULL
        ) = 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'The fixed deposit interest rate is correctly udpated', 
                 ''
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'The fixed deposit interest rate is not updated', 
                 'Error'
                );
        END;
        ----end of the fixed deposit interest rate flag------------------
        --start of the interst rate flag of other than fixed account-----------
        IF
        (
            SELECT COUNT(AccountNo)
            FROM MamAccountOpening mam
                 JOIN sycdeposittype sdt ON mam.SycDepositTypeId = sdt.SycDepositTypeId
            WHERE sdt.InterestRate = mam.InterestRate
                  AND MamAccountStatusId = 1
                  AND mam.SycDepositTypeId IN
            (
                SELECT SycDepositTypeId
                FROM SycDepositType
                WHERE SycDepositCategoryId != 3
                      AND IsActive = 1
            )
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'Please update the interest rate of other than fixed category', 
                 'Error'
                );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Mamaccountopening', 
                 'The interest rate other than fixed category is correct', 
                 ''
                );
        END;

        ---end of the interest rate other than fixed account----------
        ---transactionon containing time check start-----------
        IF
        (
            SELECT COUNT(CAST(transactionon AS TIME))
            FROM acotransaction
            WHERE CAST(transactionon AS TIME) != '00:00:00.0000000'
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('acotransactionon', 
                 'Please change the time of acotransactionon', 
                 'Error'
                );
        END;
            ELSE
            INSERT INTO #temp
            VALUES
            ('acotransactionon', 
             'Transactionon is correctly entered', 
             ''
            );

        ---transactionon containing time check end-----------

		--start of the loancode value check---
		if 
		(select count(*)From LmtLoanTypeMaster lltm
inner join 
(

SELECT max(cast((SUBSTRING(LoanAccountNo, LEN(LoanAccountNo) - CHARINDEX('-', REVERSE(LoanAccountNo)) + 2, 50) ) as numeric))code,LmtLoanTypeMasterId
from lmtloanissue
where IsVerified=1 and IsActive=1
group by LmtLoanTypeMasterId ) lla
on lltm.LmtLoanTypeMasterId=lla.LmtLoanTypeMasterId
where lltm.CodeValue!=lla.code       )!=0
Begin 
   INSERT INTO #temp
                VALUES
                ('Lmtloantypemaster', 
                 'The code value of loan is not correctly updated', 
                 'Error'
                );
				end
				else
				insert into #temp 
				values
				  ('Lmtloantypemaster', 
                 'The code value of loan is  correctly updated', 
                 space(1000)                );
				 




		--end of the loan codevalue check----


		--start of the any same loan accountno with different memberid---

		if
		(select count(LoanAccountNo) From 
(select distinct LoanAccountNo,MemMemberRegistrationId from LmtLoanIssue
where IsVerified=1) a 
group by a.LoanAccountNo
having count(a.LoanAccountNo)>1)>0
begin 
insert into #temp
values
('Lmtloanissue','Loanaccountno same for different members','Error')
end
else 
begin 
insert into #temp values ('lmtloanissue','loanaccountno correctly updated',space(1000))
end

		--end of the any same loan accountno with different memberid---




        ----start of the loan intersetreceivable date-----------

        IF
        (
            SELECT COUNT(loanaccountno)
            FROM lmtloanissue
            WHERE lmtloanstatusid = 1
                  AND InterestReceivableTillDateOn IS NULL
                  AND TransStatus IN('i', 'R')
        ) = 0
            BEGIN
                IF
                (
                    SELECT COUNT(loanaccountno)
                    FROM lmtloanissue
                    WHERE lmtloanstatusid = 1
                          AND InterestReceivableTillDateOnbs IS NULL
                          AND TransStatus IN('i', 'r')
                ) = 0
                    INSERT INTO #temp
                    VALUES
                    ('Lmtloanissue', 
                     'The loaninterstdate is correctly updated.', 
                     ''
                    );
                    ELSE
                    INSERT INTO #temp
                    VALUES
                    ('Lmtloanissue', 
                     'PLease update the loaninterest receivable tilltade onbs', 
                     'Error'
                    );
        END;
            ELSE
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Lmtloanissue', 
                 'PLease update the loaninterest receivable tilltadeon', 
                 'Error'
                );
        END;

        ---end of the loan issue interst receivable till date on--------------------
        ----od loan important flags update checking start--------
        IF
        (
            SELECT COUNT(loanaccountno)
            FROM LmtLoanIssue
            WHERE LoanODorNormal = 'O'
                  AND IsOverDraftPayment IS NULL and LmtLoanStatusId=1
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Lmtloanissue', 
                 'Plesae update isoverdraftpayment column', 
                 'Error'
                );
        END;
            ELSE
            IF
            (
                SELECT COUNT(loanaccountno)
                FROM LmtLoanIssue
                WHERE LoanODorNormal = 'O'
                      AND IsOverDraftPayment = 1
                      AND RevolvingSavingACId IS NULL
                      AND TransStatus IN('i', 'R')
            ) != 0
                BEGIN
                    INSERT INTO #temp
                    VALUES
                    ('Lmtloanissue', 
                     'Plesae update revolvingsavcid column', 
                     'Error'
                    );
            END;
                ELSE
                INSERT INTO #temp
                VALUES
                ('Lmtloanissue', 
                 'Revolving savcid is correctly updated.', 
                 ''
                );

        -----od flag important updated end---------------
        ---loan schedule validation start------------
        IF
        (
            SELECT COUNT(LoanAccountNo)
            FROM lmtloanissue
            WHERE LmtLoanStatusId = 1
                  AND LoanODorNormal = 'N'
                  AND IsActive = 1
                  AND IsVerified = 1
                  AND LmtLoanIssueId NOT IN
            (
                SELECT lmtloanissueid
                FROM lmtloanschedule
            )
        ) != 0
            BEGIN
                INSERT INTO #temp
                VALUES
                ('Lmtloanschedule', 
                 'Please update the loanschedule', 
                 'Error'
                );
        END;
            ELSE
            INSERT INTO #temp
            VALUES
            ('Lmtloanschedule', 
             'Loan schedule is correctly updated', 
             ''
            );

        ----loan schedule validation end-----------------

        BEGIN
            INSERT INTO #temp
            VALUES
            ('Mamaccountopening', 
             'Please run the balance cd and ledger balance', 
             SPACE(10000)
            );
            INSERT INTO #temp
            VALUES
            ('Mamaccountopening', 
             'Please verify the last interest date', 
             SPACE(10000)
            );
        END;
        SELECT *
        FROM #temp;
    END;


	