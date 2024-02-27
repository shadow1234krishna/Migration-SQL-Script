use NexGenCoSysDBDev
--modify the loantypecode of the loan typemaster manually and run the following script--

DECLARE @OFFICENAME NVARCHAR(MAX)='BENI BRANCH'
delete From LmtLoanTypeMaster where LmtLoanTypeMasterId not in (select LmtLoanTypeMasterId from LmtLoanIssue)

update LmtLoanIssue set LoanAccountNo=right(LoanAccountNo,4) 
where UsmOfficeId=(select usmofficeid from usmoffice where OfficeName=@OFFICENAME)


update a set a.LoanAccountNo=cast((select LoanTypeCode from LmtLoanTypeMaster b where a.LmtLoanTypeMasterId=b.LmtLoanTypeMasterId)as nvarchar)+'-'+(select OfficeShortCode from usmoffice where OfficeName=@OFFICENAME)+'-'+LoanAccountNo from LmtLoanIssue a
where UsmOfficeId=(select usmofficeid from usmoffice where OfficeName=@OFFICENAME)

select *From lmtloanissue



