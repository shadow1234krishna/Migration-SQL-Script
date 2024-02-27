USE NexGenCoSysDBDev

delete from MamAccountOpening
DBCC CHECKIDENT ('MamAccountOpening',RESEED,0)

--select * FROM Finact.DBO.deposit D ORDER BY AcctNo

INSERT INTO NexGenCoSysDBDev.[dbo].[MamAccountOpening]
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
	   (SELECT TOP 1 UsmOfficeId FROM UsmOffice) --USMOFFICEID
       ,(SELECT TOP 1 MemMemberRegistrationId FROM dbo.MemMemberRegistration WHERE D.CusCidNo=REPLACE(MemberId,'MR-01-',''))--MEMMEMBERREGISTRATIONID
       ,(SELECT top 1 HurCollectorId FROM HurCollector)--HURCOLLECTOR
       ,AcctNo--ACCOUNTNO
       ,(SELECT TOP 1 SycDepositTypeId FROM SycDepositType WHERE DepositTypeCode = GlSubHead) 
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
	   ,NULL	-- MATURITY DATE
	   ,D.DFMatuDate		-- MATURITY NEPALI
	   ,null		-- NEXT INTEREST DATE ON
	   ,null	-- NEXT INTEREST DATE BS
	   ,1
	   ,1
	   ,CASE WHEN DAcctStatus = '50' THEN 2
	         when DAcctStatus='90' then 5	       
			 ELSE 1 END -- ACCOUNT STATUS O
	   ,0
	   ,0
	   ,0
	   , 'D' 
	   ,1 
	   ,CAST (AcctNo AS NVARCHAR)  -- REMARKS
	   ,0 --BALANCE CD
	   ,null	 -- LAST INTEREST DATE ON
	   , case when DIntEffDate=DAcctOpenDate then null else d.DIntEffDate-1	end	-- LAST INTEREST DATE BS   
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
      
  FROM Finact..deposit D ORDER BY AcctNo
  
 
GO

UPDATE MamAccountOpening set MaturityOnBs = (select DateNepali from Finact.dbo.DateNumber where MaturityOnBs=dateNumber)
 go
UPDATE MamAccountOpening SET MaturityOn= dbo.ConvertDateNepaliToEnglish(MaturityOnBs) 
go

update MamAccountOpening set LastInterestDateOnBs=((select DateNepali from Finact.dbo.DateNumber where LastInterestDateOnBs=dateNumber))
go
update mamaccountopening set LastInterestDateOn=dbo.ConvertDateNepaliToEnglish(LastInterestDateOnBs)


select * FROM MamAccountOpening
