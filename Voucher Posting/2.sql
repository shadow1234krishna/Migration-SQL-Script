--begin tran
use Demo
--alter table ledger add acoledgerheadid bigint


update a set acoledgerheadid=(select top 1 acoledgerheadid from  
NexGenCoSysDBDev.dbo.acoledgerhead b where b.ledgerhead=a.[ledgerhead] and a.parentid=b.parentid) 
  from Demo.dbo.Voucher$ a where acoledgerheadid is null
--rollback tran

select * from NexGenCoSysDBDev.dbo.acoledgerhead
where acoledgerheadid is null
select * from Demo.dbo.Voucher$

ALTER TABLE Demo.dbo.Voucher$
ALTER COLUMN acoledgerheadid BIGINT;
