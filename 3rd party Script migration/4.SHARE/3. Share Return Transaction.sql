use NexGenCoSysDBDev
INSERT INTO [NexGenCoSysDBDev].[dbo].[AcoTransaction]
           ([MemMemberRegistrationId]
           ,[ShmShareAllotmentId]          
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
		   ,REFERENCE
		   ,tranno)
           
SELECT 
    (SELECT TOP 1 MemMemberRegistrationID FROM MemMemberRegistration WHERE CAST(Remarks AS NVARCHAR)= b.cuscidno )
	  ,null
	  ,9  
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)
      ,null
	  ,a.TranAmount
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(a.nepTranDate)
      ,a.nepTranDate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice)
      ,1
      ,NULL
      ,NULL      
      ,a.description
      ,a.tranno
      ,GETDATE()
      ,0
      ,1
      ,0
	  ,a.typeoftranname
	  ,a.TranNo
  FROM Finact..[TRANSACTION] a join Finact..ledger b on a.AcctNo=b.acctno where b.glsubhead in('101010100','101010200') and a.TypeOfTran=44
  

