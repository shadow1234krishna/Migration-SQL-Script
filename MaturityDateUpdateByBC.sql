use NexGenCoSysDBDev
go

 --updating maturity date of Normal Savings
 update MamAccountOpening
 set MaturityOn = null, MaturityOnBs = null
 where SycDepositTypeId in (select SycDepositTypeId from SycDepositType
	where SycDepositCategoryId = 1
		and IsActive = 1)


--=============================================================================

 --updating maturity date of Other Categories (Not Normal)
 select mam.AccountNo, mam.AccountOpenOn, mam.AccountOpenOnBs,mam.MaturityOn, mam.MaturityOnBs,b.Duration,b.DurationType into #temp from SycDepositCategory a
INNER JOIN SycDepositType b
ON a.SycDepositCategoryId = b.SycDepositCategoryId
INNER JOIN MamAccountOpening mam
ON b.SycDepositTypeId = mam.SycDepositTypeId
where a.SycDepositCategoryId != 1 and (mam.MaturityOn is  null or mam.MaturityOnBs is  null);

--select * from #temp;
--------------
update #temp
SET 
MaturityOnBs = CASE WHEN t.DurationType = 'Y' THEN dbo.ConvertDateEnglishToNepali( DATEADD(Year, t.Duration,dbo.ConvertDateNepaliToEnglish( t.AccountOpenOnBs )))
					WHEN t.DurationType = 'M' THEN dbo.ConvertDateEnglishToNepali( DATEADD(Month, t.Duration,dbo.ConvertDateNepaliToEnglish( t.AccountOpenOnBs )))
					WHEN t.DurationType = 'D' THEN dbo.ConvertDateEnglishToNepali( DATEADD(Day, t.Duration,dbo.ConvertDateNepaliToEnglish( t.AccountOpenOnBs )))
END
FROM #temp t;
----------------
update #temp
SET MaturityOn = dbo.ConvertDateNepaliToEnglish(t.MaturityOnBs)
FROM #temp t;
-----------------

update mam
SET mam.MaturityOn = t.MaturityOn,
	mam.MaturityOnBs = t.MaturityOnBs
FROM  #temp t
INNER JOIN MamAccountOpening mam
ON t.AccountNo = mam.AccountNo;

--Message
IF(select COUNT(*) from #temp where(MaturityOn is not null or MaturityOnBs is not null)) = 0
PRINT('Maturity Date is already exist')
ELSE
PRINT('Maturity Date is Updated')

drop table #temp;

