use NexGenCoSysDBDev
--create saving acc of different Financial Group

dbcc checkident('AcoLedgerHead',reseed,127)

insert into AcoLedgerHead values (95, 4, null, 'SAVINGS ACCOUNT KHA', 1, '0', 1, null, '1', '0', GETDATE(), null,  null,  1, '1', null)
insert into AcoLedgerHead values (96, 4, null, 'SAVINGS ACCOUNT GA', 1, '0', 1, null, '1', '0', GETDATE(), null,  null,  1, '1', null)
insert into AcoLedgerHead values (97, 4, null, 'SAVINGS ACCOUNT GHA', 1, '0', 1, null, '1', '0', GETDATE(), null,  null,  1, '1', null)
insert into AcoLedgerHead values (98, 4, null, 'SAVINGS ACCOUNT GNA', 1, '0', 1, null, '1', '0', GETDATE(), null,  null,  1, '1', null)

select * from AcoLedgerHead
where LedgerHead  like '%GROUP%'