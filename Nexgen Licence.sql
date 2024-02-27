use NexGenCoSysDBDev
go

update SycCompany set CompanyName='Krishna Shah Machine',LicenseKey='MWIFD-GAQXU-JZTVY-OQFUM' ,ClientCode=NULL,LicenceIsActive=1

update UsmSystemEdition set IsActive=1 where UsmSystemEditionId=2

--select CompanyName,LicenseKey,ClientCode,LicenceIsActive,* from SycCompany

update UsmSystemEdition set IsActive=0 where UsmSystemEditionId=1
update UsmSystemEdition set IsActive=1 where UsmSystemEditionId=2
update UsmSystemEdition set IsActive=0 where UsmSystemEditionId=3
update UsmSystemEdition set IsActive=0 where UsmSystemEditionId=4
update UsmSystemEdition set IsActive=0 where UsmSystemEditionId=5

select * from UsmSystemEdition

