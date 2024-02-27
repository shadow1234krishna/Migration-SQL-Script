USE NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='beni BRANCH'

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
	  ,S.ShmShareAllotmentId
	  ,8  
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)
      ,S.SharePurchaseAmount
	  ,0
      ,0      
      ,SharePurchaseOn
      ,SharePurchaseOnBs
      ,S.UsmOfficeId
      ,1
      ,NULL
      ,NULL      
      ,'SHARE PURCHASE MIGRATION'
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
  FROM [NexGenCoSysDBDev].[dbo].[ShmShareAllotment] AS S
  where s.UsmOfficeId=(select usmofficeid from usmoffice where OfficeName=@OFFICENAME)



