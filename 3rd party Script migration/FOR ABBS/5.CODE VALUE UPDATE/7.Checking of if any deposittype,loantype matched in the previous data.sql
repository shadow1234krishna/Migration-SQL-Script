use nexgencosysdbdev
select deposittypename from sycdeposittype where isactive=1 group by deposittypename
having count(deposittypename)>1

select LoanTypeName from LmtLoanTypeMaster where isactive=1 group by LoanTypeName
having count(LoanTypeName)>1
-----------------------
--if the count gives the result then the name should be modified---