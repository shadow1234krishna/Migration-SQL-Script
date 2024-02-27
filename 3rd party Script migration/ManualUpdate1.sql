use NexGenCoSysDBDev

select * from MemMemberRegistration

update MemMemberRegistration
set MemberId = REPLACE(MemberId, '-01-0', '-01-')

select SUBSTRING(AccountNo, 1, 7) from MamAccountOpening

select * from MamAccountOpening

update MamAccountOpening
set AccountNo = SUBSTRING(AccountNo, 1, 7) + '-01-' + SUBSTRING(AccountNo, 8, 100)


update MamAccountOpening
set AccountNo = REPLACE(AccountNo, '-01-0', '-01-')


select * from LmtLoanIssue

update LmtLoanIssue
set LoanAccountNo = SUBSTRING(LoanAccountNo, 1, 7) + '-01-' + SUBSTRING(LoanAccountNo, 8, 100)

update LmtLoanIssue
set LoanAccountNo = REPLACE(LoanAccountNo, '-01-0', '-01-') 

select InterestReceivableTillDateOnBs, * from LmtLoanIssue