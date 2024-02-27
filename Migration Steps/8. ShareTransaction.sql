INSERT INTO NexGenCoSysDBDev.[dbo].[AcoTransaction](
			[MemMemberRegistrationId]
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
)
           
SELECT 
		S.MemMemberRegistrationId	--[MemMemberRegistrationId]
	  ,S.ShmShareAllotmentId		--[ShmShareAllotmentId]
	  ,8				--[AcoTransactionTypeId]
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)		--[HurCollectorId]
      ,S.SharePurchaseAmount		--[CashReceived]
	  ,null		--[CashWithdrawl]
      ,0      --[TransactionNumber]
      ,SharePurchaseOn		--[TransactionOn]
      ,SharePurchaseOnBs		--[TransactionOnBs]
      ,S.UsmOfficeId		--[UsmOfficeId]
      ,1		--[IsPosted]
      ,NULL		--[AcoVoucherId]
      ,NULL     -- [AcoReverseVoucherId]
      ,'SHARE PURCHASE MIGRATION'		--[Description]
      ,0		--[CreatedBy]
      ,GETDATE()		--[CreatedOn]
      ,0		--[IsEdited]
      ,1		--[IsActive]
      ,0		--[IsPayable]
  FROM NexGenCoSysDBDev.[dbo].[ShmShareAllotment] AS S
GO

select * from AcoTransaction


