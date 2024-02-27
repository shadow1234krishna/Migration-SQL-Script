--use NexGenCoSysDBDev	
select  dbo.fn_GetLoanPrincipleBalance (LoanAccountNo) as balance ,LoanAccountNo, lmtloanissueid into #temp from lmtloanissue 
--select * from #temp

delete from LmtLoanSchedule
dbcc checkident('lmtloanschedule', reseed, 1)

INSERT INTO LmtLoanSchedule
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
       (select top 1 lmtloanissueid from LmtLoanIssue where LoanAccountNo=a.LoanAccountNo)  ---lmtloanissueid---
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
	  
	 from #temp a join LmtLoanIssue l on a.loanaccountno=l.LoanAccountNo 


drop table #temp

	 select * from LmtLoanSchedule

	
	  
