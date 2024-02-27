--begin tran

--delete NexgenCosys41.dbo.AcoLedgerHead where AcoLedgerHeadId between 220 and 311


use NexgenCosys41
dbcc checkident('AcoLedgerHead',reseed,127)

select  * from NexgenCosys41..AcoLedgerHead

insert into NexgenCosys41.dbo.AcoLedgerHead(
       [ParentId]--1
      ,[NodeLevel]--2
      ,[LedgerHead]--3
      ,[AcoAccountTypeId]---4
      ,[OpeningBalance]---5
      ,[AcoLedgerOpeningTypeId]---6
      ,[IsActive]----7
      ,[CreatedBy]----8
      ,[CreatedOn]-----9
       ,[IsEditable]----10
      ,[IsNaturalValue]----11
)

select 
	  parentid,
	  (select top 1 NodeLevel+1 from NexgenCosys41.dbo.AcoLedgerHead b where a.parentid=b.AcoLedgerHeadId),
	  a.[ledgerhead],
	  (select top 1 AcoAccountTypeId from NexgenCosys41.dbo.AcoLedgerHead b where a.parentid=b.AcoLedgerHeadId),
	  '0',
	  (select top 1 AcoLedgerOpeningTypeId from NexgenCosys41.dbo.AcoLedgerHead b where a.parentid=b.AcoLedgerHeadId),
	  '1',
	  '0',
	  GETDATE(),
	  '1',
	  '0'

	  from excel..DeuraliVoucher a where a.parentId is not null and a.IsTobeCreated = 1

--rollback tran

select * from AcoLedgerHead

