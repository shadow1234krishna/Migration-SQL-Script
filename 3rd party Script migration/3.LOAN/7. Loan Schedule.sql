use NexGenCoSysDBDev
delete from lmtloanschedule
insert into [LmtLoanSchedule]
(
      [LmtLoanIssueId]
      ,[LoanFrequency]
      ,[PrincipleAmount]
      ,[InterestAmount]
      ,[InstallmentAmount]
      ,[PrincipleBalanceAmount]
      ,[ScheduleDateOn]
      ,[ScheduleDateOnBs]
      ,[CreatedBy]
      ,[CreatedOn]
      ,[LastModifiedBy]
      ,[LastModifiedOn]
      ,[IsPaid]
      ,[InstallmentPaidOn]
      ,[InstallmentPaidOnBS]
      ,[IsActive]
	  ,ActualPrincipleAmount
	  ,ActualInterestAmount
	  
     
	  )

select 
(select top 1 LmtLoanIssueId from lmtloanissue a where cast(a.Remarks as nvarchar)=M.acctno)
,M.InstCount --loan frequency
,M.MaturityAmt --principleamount
,M.interest --interest Amount
,0 --installment Amount
,M.Principle --Principle Balance Amount
,dbo.ConvertDateNepaliToEnglish(M.NepDate)--[ScheduleDateOn]
,m.NepDate --[ScheduleDateOnBs]
,0 --created by
,getdate() --createdon
,null--[LastModifiedBy]
,null --[LastModifiedOn] 
,1 --ispaid
,dbo.ConvertDateNepaliToEnglish(M.MdateofTran)--[InstallmentPaidOn]
,M.MdateofTran--[InstallmentPaidOnBS]
,1--[IsActive]
,m.MaturityAmt
,m.Interest


 FROM Finact.dbo.maturity M  order by Instcount

 update LmtLoanSchedule set ScheduleDateOnBS=dbo.ConvertDateEnglishToNepali(ScheduleDateOn)