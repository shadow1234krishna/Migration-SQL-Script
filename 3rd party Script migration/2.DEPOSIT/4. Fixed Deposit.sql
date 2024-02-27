USE NexGenCoSysDBDev
INSERT INTO   [AcoTransaction]
           ([MemMemberRegistrationId]
           ,[MamAccountOpeningId]          
           ,[AcoTransactionTypeId]          
           ,[HurCollectorId]
           ,[CashReceived]
           ,[CashWithdrawl]                     
           ,[TransactionNumber]
           ,[TransactionOn]
           ,[TransactionOnBs]
           ,[UsmOfficeId]
           ,[IsPosted]
           ,[AcoVoucherId]
           ,[AcoReverseVoucherId]
           ,[Description]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[IsEdited]
           ,[IsActive]
           ,[IsPayable]
           ,[REFERENCE]
           ,[TRANNO]
           )
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM MamAccountOpening  WHERE AccountNo = AcctNo)
	  , (SELECT TOP 1 MamAccountOpeningId FROM MamAccountOpening WHERE AccountNo = AcctNo)	 
	  ,1
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount
	  ,0
      ,0      
       ,dbo.ConvertDateNepaliToEnglish(nepTranDate)
      ,nepTranDate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice)
      ,1
      ,NULL
      ,NULL      
      ,[DESCRIPTION]
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
      ,CAST(Typeoftranname AS NVARCHAR)
      ,TranNo
  FROM Finact..[transaction] WHERE AcctNo IN (SELECT AccountNo FROM MamAccountOpening WHERE AccountNo LIKE '10401%'
  OR AccountNo LIKE '10404%')
   AND Typeoftranname = 'open'
 ORDER BY TranNo,nepTranDate
GO
INSERT INTO   [AcoTransaction]
           ([MemMemberRegistrationId]
           ,[MamAccountOpeningId]          
           ,[AcoTransactionTypeId]          
           ,[HurCollectorId]
           ,[CashReceived]
           ,[CashWithdrawl]                     
           ,[TransactionNumber]
           ,[TransactionOn]
           ,[TransactionOnBs]
           ,[UsmOfficeId]
           ,[IsPosted]
           ,[AcoVoucherId]
           ,[AcoReverseVoucherId]
           ,[Description]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[IsEdited]
           ,[IsActive]
           ,[IsPayable]
           ,[REFERENCE]
           ,[TRANNO]
           )
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM MamAccountOpening  WHERE AccountNo = AcctNo)
	  , (SELECT TOP 1 MamAccountOpeningId FROM MamAccountOpening WHERE AccountNo = AcctNo)	 
	  ,1
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount
	  ,0
      ,0      
       ,dbo.ConvertDateNepaliToEnglish(nepTranDate)
      ,nepTranDate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice)
      ,1
      ,NULL
      ,NULL      
      ,[DESCRIPTION]
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
      ,CAST(Typeoftranname AS NVARCHAR)
      ,TranNo
  FROM Finact..[transaction] WHERE AcctNo IN (SELECT AccountNo FROM MamAccountOpening WHERE AccountNo LIKE '10401%'
  OR AccountNo LIKE '10404%')
   AND Typeoftranname = 'rnew' and sequence='01'
 ORDER BY TranNo,nepTranDate
GO

INSERT INTO   [AcoTransaction]
           ([MemMemberRegistrationId]
           ,[MamAccountOpeningId]          
           ,[AcoTransactionTypeId]          
           ,[HurCollectorId]
           ,[CashReceived]
           ,[CashWithdrawl]                     
           ,[TransactionNumber]
           ,[TransactionOn]
           ,[TransactionOnBs]
           ,[UsmOfficeId]
           ,[IsPosted]
           ,[AcoVoucherId]
           ,[AcoReverseVoucherId]
           ,[Description]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[IsEdited]
           ,[IsActive]
           ,[IsPayable]
           ,[REFERENCE]
           ,[TRANNO]
           )
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM MamAccountOpening  WHERE AccountNo = AcctNo)
	  , (SELECT TOP 1 MamAccountOpeningId FROM MamAccountOpening WHERE AccountNo = AcctNo)	 
	  ,1
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount
	  ,0
      ,0      
       ,dbo.ConvertDateNepaliToEnglish(nepTranDate)
      ,nepTranDate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice)
      ,1
      ,NULL
      ,NULL      
      ,[DESCRIPTION]
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
      ,CAST(Typeoftranname AS NVARCHAR)
      ,TranNo
  FROM Finact..[transaction] WHERE AcctNo IN (SELECT AccountNo FROM MamAccountOpening WHERE AccountNo LIKE '10401%')
   AND TypeOfTran = 13 and Typeoftranname = 'CAPT'
 ORDER BY TranNo,nepTranDate

GO

INSERT INTO   [AcoTransaction]
           ([MemMemberRegistrationId]
           ,[MamAccountOpeningId]          
           ,[AcoTransactionTypeId]          
           ,[HurCollectorId]
           ,[CashReceived]
           ,[CashWithdrawl]                     
           ,[TransactionNumber]
           ,[TransactionOn]
           ,[TransactionOnBs]
           ,[UsmOfficeId]
           ,[IsPosted]
           ,[AcoVoucherId]
           ,[AcoReverseVoucherId]
           ,[Description]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[IsEdited]
           ,[IsActive]
           ,[IsPayable]
           ,[REFERENCE]
           ,[TRANNO]
           )
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM MamAccountOpening  WHERE AccountNo = AcctNo)
	  , (SELECT TOP 1 MamAccountOpeningId FROM MamAccountOpening WHERE AccountNo = AcctNo)	 
	  ,2
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,0
	  ,TranAmount
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(nepTranDate)
      ,nepTranDate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice)
      ,1
      ,NULL
      ,NULL      
      ,[DESCRIPTION]
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
      ,CAST(Typeoftranname AS NVARCHAR)
      ,TranNo
      
  FROM Finact..[transaction] WHERE AcctNo IN (SELECT AccountNo FROM MamAccountOpening WHERE AccountNo LIKE '10401%'
  OR AccountNo LIKE '10404%')
   AND Typeoftranname = 'CLOS'
 ORDER BY TranNo,nepTranDate
