USE NexGenCoSysDBDev
DELETE FROM AcoTransaction WHERE AcoTransactionTypeId IN (5,6,7)

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
SELECT 
		(SELECT TOP 1 MemMemberRegistrationId FROM LmtLoanIssue as mem WHERE LoanAccountNo = AcctNo)
	  ,(SELECT TOP 1 LmtLoanIssueId FROM LmtLoanIssue WHERE LoanAccountNo = AcctNo)
	  ,5
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount --CASH RECEIVED
      ,0 --WITHDRAW
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(neptrandate)
      ,neptrandate
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
      ,Sequence
      ,TranNo
 FROM Finact.DBO.[TRANSACTION] WHERE AcctNo IN (SELECT LoanAccountNo FROM LmtLoanIssue) AND TypeOfTranname IN ('coll','clos')
and status='01'  ORDER BY [SEQUENCE]

GO

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
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM LmtLoanIssue as mem WHERE LoanAccountNo = AcctNo)
	  ,(SELECT TOP 1 LmtLoanIssueId FROM LmtLoanIssue WHERE LoanAccountNo = AcctNo)
	  ,5
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,-1 * TranAmount --CASH RECEIVED
      ,0 --WITHDRAW
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(neptrandate)
      ,neptrandate
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
      ,Sequence
      ,TranNo
FROM Finact.DBO.[TRANSACTION]
WHERE AcctNo IN (SELECT LoanAccountNo FROM LmtLoanIssue)
	AND TypeOfTranname IN ('REV')
	and status='01'
	and Tran_mode = 1
	and TypeOfTran not in (78, 80, 81)

GO
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
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM LmtLoanIssue as mem WHERE LoanAccountNo = AcctNo)
	  ,(SELECT TOP 1 LmtLoanIssueId FROM LmtLoanIssue WHERE LoanAccountNo = AcctNo)
	  ,6
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount --CASH RECEIVED
       ,0 --WITHDRAW
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(neptrandate)
      ,neptrandate
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
      ,Sequence
      ,TranNo
  FROM Finact.DBO.[TRANSACTION] WHERE AcctNo IN (SELECT LoanAccountNo FROM LmtLoanIssue) AND Typeoftranname IN ('NINP','QANP')
  ORDER BY [SEQUENCE]

GO

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
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM LmtLoanIssue as mem WHERE LoanAccountNo = AcctNo)
	  ,(SELECT TOP 1 LmtLoanIssueId FROM LmtLoanIssue WHERE LoanAccountNo = AcctNo)
	  ,7
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,TranAmount --CASH RECEIVED
       ,0 --WITHDRAW
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(neptrandate)
      ,neptrandate
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
      ,Sequence
      ,TranNo
  FROM Finact.DBO.[TRANSACTION] where AcctNo IN (SELECT LoanAccountNo FROM LmtLoanIssue) and TypeOfTran IN (82) ORDER BY [SEQUENCE]



--update AcoTransaction set TransactionOn= (select dateEnglish from Finact1.dbo.DateNumber where dateNumber=TransactionOnBs) where  LmtLoanIssueid>0
--update AcoTransaction set TransactionOnBs=(select DateNepali from Finact1.dbo.DateNumber where dateNumber=TransactionOnBs )where  LmtLoanIssueid>0

select * from AcoTransaction where AcoTransactionTypeId in (5,6,7)



