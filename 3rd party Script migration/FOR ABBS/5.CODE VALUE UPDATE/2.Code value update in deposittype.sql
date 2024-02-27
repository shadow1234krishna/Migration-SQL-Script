use NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='BENI BRANCH'
select replace(AccountNo,(select DepositTypeCode from sycdeposittype b where a.SycDepositTypeId=b.SycDepositTypeId)+'-'+(select OfficeShortCode from usmoffice where OfficeName=@OFFICENAME)+'-','') as acc,AccountNo,SycDepositTypeId into #temp From MamAccountOpening a 
where a.UsmOfficeId=(select usmofficeid from usmoffice where OfficeName=@OFFICENAME)

select max(cast(acc as numeric)) codeno ,SycDepositTypeId into #temp2 From #temp  where acc not like '%[^0-9]%' group by SycDepositTypeId
update a set CodeValue=(select codeno from #temp2 b where a.SycDepositTypeId=b.SycDepositTypeId) from SycDepositType a
where a.branch=@OFFICENAME
drop table #temp
drop table #temp2

select sycdeposittypeid,deposittypename,CodeValue From SycDepositType where branch=@OFFICENAME