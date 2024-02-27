use NexGenCoSysDBDev

update AcoTransaction
set IsActive = 0
where TRANNO in (030799,
067523,
070838,
129223)