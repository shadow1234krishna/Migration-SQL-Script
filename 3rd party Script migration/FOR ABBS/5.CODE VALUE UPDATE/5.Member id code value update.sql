use NexGenCoSysDBDev
--code value of the member registration should be changed on the basis of the master code value
--entered in the sycmastercodevalue.If the migrated data max member id value is less than the value 
--in the mastercode value then no need to update if less then need to update the master code value
DECLARE @OFFICENAME NVARCHAR(MAX)='KAMANA BRANCH'

select *from sycmastercode where sycmastercodeid=1

select max(cast(replace(memberid,'MR-04-','') as money))from memmemberregistration where usmofficeid=(select usmofficeid from usmoffice where officename=@officename)

