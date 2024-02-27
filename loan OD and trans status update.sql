use NexGenCoSysDBDev
update LmtLoanIssue 
set LoanODorNormal='O',IsOverDraftPayment=0,TransStatus='I' 
where LoanAccountNo in (select loanaccountno from LmtLoanIssue
	group by LoanAccountNo
	having count(LoanAccountNo)>1)


update lmtloanissue 
set TransStatus='U'
where LmtLoanIssueId not in
 (select distinct (select top 1 ll.LmtLoanIssueId from LmtLoanIssue as ll where ll.LoanAccountNo=l.LoanAccountNo )LmtLoanIssueId from LmtLoanIssue as l
  where l.LoanODorNormal='O') and LoanODorNormal='O'
