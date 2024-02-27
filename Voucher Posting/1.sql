--begin tran
use NexGenCoSysDBDev
go
delete NexGenCoSysDBDev.dbo.AcoLedgerHead where AcoLedgerHeadId between 116 and 145

select * from Demo.dbo.Voucher1$
delete from Demo.dbo.cry$
where ledgerHead is null
drop table Demo.dbo.Voucher$

select * from AcoLedgerHead
use NexGenCoSysDBDev
dbcc checkident('AcoLedgerHead',reseed,115)

select  * from NexGenCoSysDBDev..AcoLedgerHead
where NodeLevel is null

insert into NexGenCoSysDBDev.dbo.AcoLedgerHead(
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
	  (select top 1 NodeLevel + 1 from NexGenCoSysDBDev.dbo.AcoLedgerHead b where a.parentId=b.AcoLedgerHeadId),
	  a.[ledgerhead],
	  (select top 1 AcoAccountTypeId from NexGenCoSysDBDev.dbo.AcoLedgerHead b where a.parentId=b.AcoLedgerHeadId),
	  '0',
	  (select top 1 AcoLedgerOpeningTypeId from NexGenCoSysDBDev.dbo.AcoLedgerHead b where a.parentId=b.AcoLedgerHeadId),
	  '1',
	  '0',
	  GETDATE(),
	  '1',
	  '0'

	  from Demo.dbo.Voucher$ a where a.parentId is not null and a.IsTobeCreated = 1

--rollback tran

select * from AcoLedgerHead



select * from AcoLedgerHead
---select * from Demo.dbo.Voucher$
where AcoLedgerHeadId is null


select * from AcoledgerHead
where LedgerHead like '%INTEREST%'

DELETE FROM AcoledgerHead
WHERE AcoLedgerHeadId BETWEEN 116 and 145;

delete from Demo.dbo.PLBS$
where ledgerHead is null

DROP TABLE Demo.dbo.Voucher$


INSERT INTO NexGenCoSysDBDev.dbo.AcoLedgerHead (
    [ParentId], [NodeLevel], [LedgerHead], [AcoAccountTypeId],
    [OpeningBalance], [AcoLedgerOpeningTypeId], [IsActive],
    [CreatedBy], [CreatedOn], [IsEditable], [IsNaturalValue]
)
VALUES (
    31,2,'INTERNET EXPENSES1',4,'0.00',1,1,0,'2023-12-25 13:24:11.693',1,0
);


select * from AcoTransaction
where MemMemberRegistrationId = 1
order by MemMemberRegistrationId

