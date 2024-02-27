USE NexGenCoSysDBDev
update AcoTransaction set AcoTransactionTypeId= 3 where REFERENCE='INTR'--FOR INTERSTTYPE
update AcoTransaction set AcoTransactionTypeId= 4 where REFERENCE='TAXP'--FOR TAX TYPE

