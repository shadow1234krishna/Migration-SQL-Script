

USE NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='Beni Branch'

 
INSERT INTO [NexGenCoSysDBDev].[dbo].[MamAccountOpening]
           ([UsmOfficeId]
           ,[MemMemberRegistrationId]
           ,[HurCollectorId]
           ,[AccountNo]
           ,[SycDepositTypeId]
           ,[MamAccountHolderTypeId]
           ,[InterestRate]
           ,[SycInterestCalculationTypeId]
           ,[SycDepositMethodTypeId]
           ,[MamInterestTransferAccountOpeningId]
           ,[TaxRate]
           ,[AccountOpenOn]
           ,[AccountOpenOnBs]
           ,[Certificates]
           ,[Signature]
           ,[LedgerBalance]
           ,[FreezeAmount]
           ,[MaturityOn]
           ,[MaturityOnBs]
           ,[NextInterestDateOn]
           ,[NextInterestDateOnBs]
           ,[Withdrawal]
           ,[AccountClose]
           ,[MamAccountStatusId]
           ,[TermDepositInstallmentAmount]
           ,[TermDepositMaturityAmount]
           ,[TermDepositNoOfInstallment]
           ,[TermDepositNoOfInstallmentType]
           ,[SycSmsCategoryId]
           ,[Remarks]
           ,[BalanceCd]
           ,[LastInterestDateOn]
           ,[LastInterestDateOnBs]
           ,[IsInterestCalculationActive]
           ,[IsInterestCreditable]
           ,[IsInterestCustomized]
           ,[InterestPayable]
           ,[TaxReceivable]
           ,[PendingTransactionRemarks]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[CreatedOnBs]
           ,[IsDeleted]
           ,[IsRenewed]
		   ,PreviousInterest
           )
SELECT 
	   (SELECT TOP 1 UsmOfficeId FROM UsmOffice where OfficeName=@OFFICENAME) --USMOFFICEID
       ,(SELECT TOP 1 MemMemberRegistrationId FROM dbo.MemMemberRegistration WHERE D.CusCidNo=cast(Remarks as nvarchar) and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))--MEMMEMBERREGISTRATIONID
       ,(SELECT top 1 HurCollectorId FROM HurCollector)--HURCOLLECTOR
       ,AcctNo--ACCOUNTNO
       ,(SELECT TOP 1 SycDepositTypeId FROM SycDepositType WHERE DepositTypeCode = GlSubHead and branch='BEni branch') 
       ,CASE WHEN DCategory=110 THEN 1
			 WHEN DCategory=150 THEN 3
			 ELSE 1 END--MAMACCOUNTHOLDERTYPEID
	   ,DInterestRate--INTRATE
	   ,CASE WHEN D.AcctNo LIKE '10404%' THEN 5 ELSE NULL END  --SycInterestCalculationTypeId
	   ,NULL   --SycDepositMethodTypeId	   
	   ,NULL --INTEREST TRANSFER ID
	   ,CASE WHEN DCategory=110 THEN 5
			 WHEN DCategory=150 THEN 15
			 ELSE 5 END--TAXRATE
	   ,dbo.ConvertDateNepaliToEnglish(AcctOpenDate) --ACCOUNT OPENING DATE ENGLISH
	   ,AcctOpenDate --NEPALI DATE
	   ,'' --CERTIFICATE
	   ,NULL --SIGNATURE
	   ,0  -- LEDGER BALANCE
	   ,0  -- FREEZE AMOUNT
	   ,(select dateEnglish from kamana.dbo.DateNumber where D.DFMatuDate=dateNumber)	-- MATURITY DATE
	   ,(select DateNepali from kamana.dbo.DateNumber where D.DFMatuDate=dateNumber)		-- MATURITY NEPALI
	   ,null		-- NEXT INTEREST DATE ON
	   ,null	-- NEXT INTEREST DATE BS
	   ,1 --WITHDRAWL
	   ,1 --ACCOUNT CLOSE
	   ,CASE WHEN DAcctStatus = '50' THEN 2
	         when DAcctStatus='90' then 5	       
			 ELSE 1 END -- ACCOUNT STATUS O
	   ,NULL--TERM DEPOSIT INSTALLMENT AMOUNT
	   ,NULL--TERM DEPOSIT MATURITY AMOUNT
	   ,NULL--TERM DEPOSIT NO OF INSTALLMENT
	   ,NULL --TERM DEPOSIT INSTALLMENT TYPE 
	   ,1 --SYCSMSCATEGORY ID
	   ,CAST (AcctNo AS NVARCHAR)  -- REMARKS
	   ,0 --BALANCE CD
	   ,case when DIntEffDate=DAcctOpenDate then null else (select dateEnglish from kamana.dbo.DateNumber where (D.DIntEffDate-1)=dateNumber)	end	 -- LAST INTEREST DATE ON
	   , case when DIntEffDate=DAcctOpenDate then null else (select DateNepali from kamana.dbo.DateNumber where (D.DIntEffDate-1)=dateNumber)	end	-- LAST INTEREST DATE BS   
       ,1
       ,1
       ,1
       ,DFIntBal--Interest payable
	   ,0--Tax Recievable
       ,NULL
       ,0
       ,GETDATE()
       ,dbo.ConvertDateEnglishToNepali(GETDATE())
       ,0-- IS DELETED
       ,0 -- IS RENEWED
	   ,IntCalAmount--previousinterest
      
  FROM kamana.DBO.deposit D ORDER BY AcctNo
  
 







