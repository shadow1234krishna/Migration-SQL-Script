USE NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='beni BRANCH'

delete from ShmShareAllotment
where UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)

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
			  (SELECT TOP 1 MemMemberRegistrationId FROM MemMemberRegistration AS MR WHERE CAST(Remarks AS NVARCHAR)=cuscidno and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
			  ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice where UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
			  ,3
			  ,LBalance/100
			  ,0
			  ,0
			  ,dbo.ConvertDateNepaliToEnglish( LDateOfTran )
			  ,LDateOfTran
			  ,dbo.ConvertDateNepaliToEnglish( LDateOfTran )
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
		      
FROM KAMANA.dbo.ledger WHERE GlSubHead  in ('101010100','101010200') and LBalance!=0
	
	--select * from rkdeposittype.dbo.lastgledger

