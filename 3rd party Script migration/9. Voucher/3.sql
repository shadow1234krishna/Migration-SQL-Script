use NexgenCosys41

select dbo.ConvertDateNepaliToEnglish('2080/04/22')

delete NexgenCosys41..AcoVoucherPosting
dbcc checkident('AcoVoucherPosting',reseed,0)
delete NexgenCosys41..AcoVoucher
dbcc checkident('AcoVoucher',reseed,0)


insert into AcoVoucher values ('2','adjustment1','2023-08-07 00:00:00.000','2080/04/22','2077/78','0','2023-08-07',null,null)
--begin tran
insert into NexgenCosys41.dbo.AcoVoucherPosting
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
	  'closing balance voucher upto 2078/09/30',----5
	  '',-----6
	  '1',------7
	  '0',-------8
	  '0',------9
	  GETDATE()----10


	  from excel..DeuraliVoucher b 


select * From AcoVoucher
--rollback tran

--insert into AcoVoucherPosting values ('22145','75','2975379.21',1,null,null,1,0,0,'2017-08-16 00:00:00.000',null,null)
