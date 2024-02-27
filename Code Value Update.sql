use NexGenCoSysDBDev

-------Deposit Code Value Update------

use NexGenCoSysDBDev

select replace(AccountNo,(select DepositTypeCode from sycdeposittype b where a.SycDepositTypeId=b.SycDepositTypeId)+'-01-','') as acc,AccountNo,SycDepositTypeId into #temp From MamAccountOpening a
where MamAccountStatusId=1

select max(cast(acc as numeric)) codeno ,SycDepositTypeId into #temp2 From #temp
where acc not like '%[^0-9]%'
group by SycDepositTypeId

update a
set CodeValue=(select codeno from #temp2 b
	where a.SycDepositTypeId=b.SycDepositTypeId) from SycDepositType a

drop table #temp
drop table #temp2


------Loan Code Value Update--------
use NexGenCoSysDBDev
delete from LmtLoanTypeMaster where LmtLoanTypeMasterId not in (select LmtLoanTypeMasterId from LmtLoanIssue)
select replace(loanaccountno,(select LoanTypeCode from LmtLoanTypeMaster b where a.lmtloantypemasterid=b.LmtLoanTypeMasterId)+'-01-','') as acc,loanaccountno,LmtLoanTypeMasterid into #temp From LmtLoanIssue a 
select max(cast(acc as numeric)) codeno ,LmtLoanTypeMasterId into #temp2 From #temp  where acc not like '%[^0-9]%' group by LmtLoanTypeMasterId
update a set CodeValue=(select codeno from #temp2 b where a.LmtLoanTypeMasterId=b.LmtLoanTypeMasterId) from LmtLoanTypeMaster a
drop table #temp
drop table #temp2


------Member Code Value Update---------

update SycMasterCode set MasterCodeValue=( SELECT(max (cast(substring(MemberId,charindex('-',MemberId)+4,4) as numeric))) 
from MemMemberRegistration) where SycMasterCodeId=1


-------Share Code Value Update----------


DECLARE @share AS NUMERIC(18,0)

SET @share=0

UPDATE S SET S.ShareNoTo=@share,
			@share=s.ShareNo+@share
	FROM ShmShareAllotment AS S
	WHERE S.SharePurchaseAmount >0
 
 UPDATE S SET S.ShareNoFrom=S.ShareNoTo-S.ShareNo+1		
	FROM ShmShareAllotment AS S 
	WHERE S.SharePurchaseAmount >0

 UPDATE S set 
		 S.IsActive=0
		,S.IsReturned=1
		,S.ShareReturnedOn=(select MAX(t.TransactionOn) from AcoTransaction as t where t.ShmShareAllotmentId=S.ShmShareAllotmentId)
		,S.ShareReturnedOnBs=dbo.ConvertDateEnglishToNepali((select MAX(t.TransactionOn) from AcoTransaction as t where t.ShmShareAllotmentId=S.ShmShareAllotmentId))
	FROM ShmShareAllotment AS S
	WHERE S.SharePurchaseAmount <=0

---------------- SHARE CODE VALUE UPDATE--------------------------------------------------

UPDATE  SycMasterCode  SET MasterCodeValue=(CAST((SELECT max(ShareNoTo) FROM ShmShareAllotment ) AS BIGINT))
WHERE SycMasterCodeId=2


select * from NexGenCoSysDBDev..SycMasterCode


