USE NexGenCoSysDBDev
delete from ShmShareAllotment

select LDateOfTran, * FROM Finact.dbo.ledger WHERE GlSubHead  in ('101010100','101010200') and LBalance!=0
	and len(LDateOfTran) != 10

INSERT INTO NexGenCoSysDBDev.[dbo].[ShmShareAllotment]
				   (
				    [MemMemberRegistrationId]
				   ,[UsmOfficeId]
				   ,[ShmShareTypeId]
				   ,[ShareNo]
				   ,[ShareNoFrom]
				   ,[ShareNoTo]
				   ,[SharePurchaseOn]
				   ,[SharePurchaseOnBs]
				   ,[ShareHoldingPeriodFromOn]
				   ,[ShareHoldingPeriodFromOnBs]
				   ,[ShareFaceValue]
				   ,[SharePremium]
				   ,[SharePurchaseAmount]
				   ,[Remarks]				   
				   ,[CreatedBy]
				   ,[CreatedOn]
				   ,[CreatedOnBs] 
				   ,[IsTransferred]				   
				   ,[IsActive]
				   ,[IsReturned]  
				   )
		SELECT 		  
			  (SELECT TOP 1 MemMemberRegistrationId FROM MemMemberRegistration AS MR WHERE CAST(Remarks AS NVARCHAR)=cuscidno)
			  ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice)
			  ,3
			  ,LBalance/100
			  ,0
			  ,0
			  ,'2000-01-01'
			  ,LDateOfTran
			  ,'2000-01-01'
			  ,LDateOfTran
			  ,100
			  ,0
			  ,LBalance
			  ,''      
			  ,0
			  ,GETDATE()
			  ,dbo.ConvertDateEnglishToNepali(GETDATE())
			  ,0   
			  ,1
			  ,0 
		      
FROM Finact.dbo.ledger WHERE GlSubHead  in ('101010100','101010200') and LBalance!=0
	
	--select * from rkdeposittype.dbo.lastgledger
select * from ShmShareAllotment

update ShmShareAllotment
set SharePurchaseOn = dbo.ConvertDateNepaliToEnglish(SharePurchaseOnBs)
where len(SharePurchaseOnBs) = 10