use NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='beni BRANCH'
--first manually change the deposittypecode from the database and then run 
--the following scripts---

delete from SycDepositType where SycDepositTypeId not in (select SycDepositTypeId from MamAccountOpening) AND IsActive=1
update MamAccountOpening
set AccountNo= right(AccountNo,4) where UsmOfficeId=(select usmofficeid from usmoffice where OfficeName=@OFFICENAME)

update a set AccountNo=cast((select DepositTypeCode from SycDepositType b where a.SycDepositTypeId=b.SycDepositTypeId) as nvarchar)+'-'+(select OfficeShortCode from usmoffice where officename=@OFFICENAME)+'-'+AccountNo  from MamAccountOpening a
where a.UsmOfficeId=(select usmofficeid from usmoffice where OfficeName=@OFFICENAME)


select * from MamAccountOpening