use NexGenCoSysDBDev

select dbo.ConvertDateNepaliToEnglish('2080/03/31')

delete NexGenCoSysDBDev..AcoVoucherPosting
dbcc checkident('AcoVoucherPosting',reseed,0)
delete NexGenCoSysDBDev..AcoVoucher
dbcc checkident('AcoVoucher',reseed,0)


insert into AcoVoucher values ('2','adjustment1','2023-01-14 00:00:00.000','2080/03/31','2080/81','0','2023-01-14',null,null)
begin tran
insert into NexGenCoSysDBDev.dbo.AcoVoucherPosting
 (     [AcoVoucherId]--1
      ,[AcoLedgerHeadId]---2
      ,[Amount]---3
      ,[DebitCredit]---4
      ,[Narration]---5
      ,[NarrationLedger]----6
      ,[IsActive]---7
      ,[IsAutomatic]---8
      ,[CreatedBy]---9
      ,[CreatedOn]----10
      )

	  select 
	  (select top 1 acovoucherid from AcoVoucher where voucherno='adjustment1'),---1
	  b.[acoledgerheadid],----2
	  b.amount,-----3
	  b.[Dr Cr],-----4
	  'closing balance voucher upto 2080/03/31',----5
	  '',-----6
	  '1',------7
	  '0',-------8
	  '0',------9
	  GETDATE()----10


	  from Demo.dbo.Voucher$ b

select * from Demo.dbo.Voucher$
where AcoledgerheadId is null
select * from NexGenCoSysDBDev.dbo.AcoVoucherPosting
--rollback tran

--insert into AcoVoucherPosting values ('22145','75','2975379.21',1,null,null,1,0,0,'2017-08-16 00:00:00.000',null,null)



INSERT INTO NexGenCoSysDBDev.dbo.AcoVoucherPosting (
    [AcoVoucherId], [AcoLedgerHeadId], [Amount],
    [DebitCredit], [Narration], [NarrationLedger],
    [IsActive], [IsAutomatic], [CreatedBy], [CreatedOn]
)
VALUES (
    1,244,'-593783.18',1,'closing balance voucher upto 2078/09/30','',1,0,0,'2023-12-25 13:29:48.350'
);
update AcoVoucherPosting
set DebitCredit=0
where AcoVoucherPostingId='125'

delete from AcoVoucherPosting
where AcoVoucherPostingId=223

delete from Demo.dbo.Voucher$
where ledgerHead is null


select  * from AcoVoucherPosting

