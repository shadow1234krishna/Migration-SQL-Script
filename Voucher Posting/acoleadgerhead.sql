use NexGenCoSysDBDev
go


select * from AcoLedgerHead
where AcoAccountTypeId =1
and LedgerHead like '%other%'


select * from AcoAccountType


select * from SycDepositType

select * from SycDepositCategory

update MemMemberRegistration
set LastName='Karki'
where MemMemberRegistrationId=184

Ka

select * from MemMemberRegistration
where LastName is null

select * from SycDepositType
select * from LmtLoanTypeMaster

select AccountOpenOn,AccountOpenOnBs,MaturityOn,MaturityOnBs from MamAccountOpening
where MaturityOnBs like '%.%'


update MamAccountOpening
set  MaturityOnBs =replace( MaturityOnBs,'.','/')

select * from AcoVoucherPosting