use NexGenCoSysDBDev
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
           ,[IsPayable]
		   ,REFERENCE
		   ,tranno)
           
SELECT 
    (SELECT TOP 1 MemMemberRegistrationID FROM MemMemberRegistration WHERE CAST(Remarks AS NVARCHAR)= b.cuscidno and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME) )
	  ,null
	  ,8  
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)
      ,a.tranamount
	  ,null
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(a.nepTranDate)
      ,a.nepTranDate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice where UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
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
  FROM KAMANA..[TRANSACTION] a join KAMANA..ledger b on a.AcctNo=b.acctno where b.glsubhead in('101010100','101010200') and a.TypeOfTran=43
  

