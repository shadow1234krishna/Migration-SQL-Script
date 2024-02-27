USE NexGenCoSysDBDev
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
           ,[IsPayable])
           
SELECT S.MemMemberRegistrationId
	  ,null
	  ,9
	 ,(SELECT TOP 1 HurCollectorId FROM HurCollector)
      ,null
	  ,s.sharepurchaseamount
      ,0      
      ,SharePurchaseOn
      ,SharePurchaseOnBs
      ,S.UsmOfficeId
      ,1
      ,NULL
      ,NULL      
      ,'SHARE PURCHASE return'
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
  FROM [NexGenCoSysDBDev].[dbo].[ShmShareAllotment] AS S
GO



GO


