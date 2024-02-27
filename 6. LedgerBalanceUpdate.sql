use NexGenCoSysDBDev

update MamAccountOpening set LedgerBalance= dbo.fn_GetSavingAccountBalance(MamAccountOpening.AccountNo)


/*
--Whose database have negative ledger bal
select dbo.fn_GetSavingAccountBalance(MamAccountOpening.AccountNo) ledgerbal, AccountNo into #temp from MamAccountOpening

select * from #temp
where ledgerbal < 0

update MamAccountOpening
set LedgerBalance= dbo.fn_GetSavingAccountBalance(MamAccountOpening.AccountNo)
where AccountNo not in (select AccountNo from #temp where ledgerbal < 0)

*/