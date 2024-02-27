use NexGenCoSysDBDev	
select  dbo.fn_GetLoanPrincipleBalance (LoanAccountNo) as balance ,LoanAccountNo, lmtloanissueid,usmofficeid into #temp from NexGenCoSysDBDev..lmtloanissue
where LmtLoanStatusId=1 and IsVerified=1 and LoanODorNormal='N' and LmtLoanIssueId not in (select LmtLoanIssueId from LmtLoanSchedule) 
select * from #temp

use NexGenCoSysDBDev
INSERT INTO [NexGenCoSysDBDev].[dbo].[LmtLoanSchedule]
           ([LmtLoanIssueId]
           ,[LoanFrequency]
           ,[PrincipleAmount]
           ,Interestamount
           ,[InstallmentAmount]
           ,[PrincipleBalanceAmount]
           ,[ScheduleDateOn]
           ,[ScheduleDateOnBs]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[IsPaid]
           ,[InstallmentPaidOn]
           ,[InstallmentPaidOnBS]
           ,[IsActive])     

SELECT 
       a.LmtLoanIssueId ---lmtloanissueid---
	  ,1 -------loanfrequency--
	  ,a.balance-----principleamount--------
	  ,0----interest is considered as o----------
      ,a.balance----installment amount---------
	  ,a.balance--principlebalanceamount--------
	  ,dbo.ConvertDateNepaliToEnglish(l.MaturityOnBs)--schedule date-------
      ,l.MaturityOnBs----schedule date on bs---------  
      ,0---------createdby-----------
      ,GETDATE()----------created on--------------
      ,0------is paid-----------------
      ,null--------installment paid on----------
	  ,null----------installment paid on bs----------
	  ,1---------is active-------------------
	  
	 from #temp a join NexGenCoSysDBDev..LmtLoanIssue l on a.loanaccountno=l.LoanAccountNo 
	 where a.balance>0


drop table #temp

	 select * from LmtLoanSchedule

	
	  
