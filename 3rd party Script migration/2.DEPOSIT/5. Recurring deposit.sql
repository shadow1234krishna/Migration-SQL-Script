use NexGenCoSysDBDev
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
	  ,1  --ACOTRANSTYPEID
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount --CASHRECEIVED
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
    FROM Finact..[transaction] WHERE AcctNo IN (SELECT CAST(Remarks AS nvarchar)
	FROM NexGenCoSysDBDev..MamAccountOpening where CAST(Remarks AS nvarchar) like '10402%')
	AND TranAmount!=0 and 
	TypeOfTran IN ('01','03','05','07','09','11','22','24','43','41','45','51','61','78','80','82','94') 

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
	  ,2  --ACOTRANSTYPEID
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,0
	  ,TranAmount  --CASH WITHDRAWL
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
  FROM Finact..[transaction] WHERE AcctNo IN 
 (SELECT CAST(Remarks AS nvarchar) FROM NexGenCoSysDBDev..MamAccountOpening where CAST(Remarks AS nvarchar) like '10402%') 
 AND TypeOfTran IN ('02','04','08','12','21','23','25','44','46','77','79','81') AND TranAmount!=0

 





