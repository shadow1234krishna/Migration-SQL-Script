use NexGenCoSysDBDev

DECLARE @OFFICENAME NVARCHAR(MAX)='BENI BRANCH'
select replace(loanaccountno,(select LoanTypeCode from LmtLoanTypeMaster b where a.lmtloantypemasterid=b.LmtLoanTypeMasterId)+'-'+(select OfficeShortCode from usmoffice where OfficeName=@OFFICENAME)+'-','') as acc,loanaccountno,LmtLoanTypeMasterid into #temp From LmtLoanIssue a 
where a.UsmOfficeId=(select usmofficeid from UsmOffice where OfficeName=@officename)

select max(cast(acc as numeric)) codeno ,LmtLoanTypeMasterId into #temp2 From #temp  where acc not like '%[^0-9]%' group by LmtLoanTypeMasterId
update a set CodeValue=(select codeno from #temp2 b where a.LmtLoanTypeMasterId=b.LmtLoanTypeMasterId) from LmtLoanTypeMaster a where a.UsmOfficeId=(select usmofficeid from usmoffice where OfficeName=@OFFICENAME)
drop table #temp
drop table #temp2

select LmtLoanTypeMasterId,LoanTypeName,CodeValue from LmtLoanTypeMaster
where usmofficeid=(select usmofficeid from usmoffice where OfficeName=@OFFICENAME)
