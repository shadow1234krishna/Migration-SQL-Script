USE NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='beni BRANCH'

DELETE FROM AcoTransaction WHERE AcoTransactionTypeId IN (5,6,7)
and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)


INSERT INTO [NexGenCoSysDBDev].[dbo].[AcoTransaction]
           ([MemMemberRegistrationId]
           ,[LmtLoanIssueId]          
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
           ,TRANNO)
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM LmtLoanIssue as mem WHERE LoanAccountNo = AcctNo and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
	  ,(SELECT TOP 1 LmtLoanIssueId FROM LmtLoanIssue WHERE LoanAccountNo = AcctNo and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
	  ,5
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount --CASH RECEIVED
       ,0 --WITHDRAW
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(neptrandate)
      ,neptrandate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice where UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
      ,1
      ,NULL
      ,NULL      
      ,[DESCRIPTION]
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
      ,Sequence
      ,TranNo
 FROM KAMANA.DBO.[TRANSACTION] WHERE AcctNo IN (SELECT LoanAccountNo FROM LmtLoanIssue where usmofficeid=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)) AND TypeOfTranname IN ('coll','clos')
and status='01'   ORDER BY [SEQUENCE]



INSERT INTO [NexGenCoSysDBDev].[dbo].[AcoTransaction]
           ([MemMemberRegistrationId]
           ,[LmtLoanIssueId]          
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
           ,TRANNO)
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM LmtLoanIssue as mem WHERE LoanAccountNo = AcctNo and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
	  ,(SELECT TOP 1 LmtLoanIssueId FROM LmtLoanIssue WHERE LoanAccountNo = AcctNo and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
	  ,6
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount --CASH RECEIVED
       ,0 --WITHDRAW
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(neptrandate)
      ,neptrandate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice where UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
      ,1
      ,NULL
      ,NULL      
      ,[DESCRIPTION]
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
      ,Sequence
      ,TranNo
  FROM KAMANA.DBO.[TRANSACTION] WHERE AcctNo IN (SELECT LoanAccountNo FROM LmtLoanIssue where UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)) AND Typeoftranname IN ('NINP','QANP')
  ORDER BY [SEQUENCE]


INSERT INTO [NexGenCoSysDBDev].[dbo].[AcoTransaction]
           ([MemMemberRegistrationId]
           ,[LmtLoanIssueId]          
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
           ,TRANNO)
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM LmtLoanIssue as mem WHERE LoanAccountNo = AcctNo and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
	  ,(SELECT TOP 1 LmtLoanIssueId FROM LmtLoanIssue WHERE LoanAccountNo = AcctNo and UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
	  ,7
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount --CASH RECEIVED
       ,0 --WITHDRAW
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(neptrandate)
      ,neptrandate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice where UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
      ,1
      ,NULL
      ,NULL      
      ,[DESCRIPTION]
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
      ,Sequence
      ,TranNo
  FROM KAMANA.DBO.[TRANSACTION] where AcctNo IN (SELECT LoanAccountNo FROM LmtLoanIssue where UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)) and TypeOfTran IN (82) ORDER BY [SEQUENCE]



--update AcoTransaction set TransactionOn= (select dateEnglish from KAMANA.dbo.DateNumber where dateNumber=TransactionOnBs) where  LmtLoanIssueid>0
--update AcoTransaction set TransactionOnBs=(select DateNepali from KAMANA.dbo.DateNumber where dateNumber=TransactionOnBs )where  LmtLoanIssueid>0





