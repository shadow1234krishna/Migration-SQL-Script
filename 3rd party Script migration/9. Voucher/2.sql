--begin tran
use excel
--alter table ledger add acoledgerheadid bigint


update a set acoledgerheadid=(select top 1 acoledgerheadid from  
NexgenCosys41.dbo.acoledgerhead b where b.ledgerhead=a.[ledgerhead] and a.parentid=b.parentid) 
  from excel..DeuraliVoucher a where acoledgerheadid is null
--rollback tran