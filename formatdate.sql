select [Account Open Date] from Migration$

--Convert the date format in YYYY/MM/DD
UPDATE Migration$
SET [Account Open Date] = 
    CASE 
        WHEN TRY_CONVERT(datetime, [Account Open Date]) IS NULL THEN 
            REPLACE(REPLACE([Account Open Date], '.', '/'), '-', '/')  
        ELSE 
            CONVERT(varchar, TRY_CONVERT(datetime, [Account Open Date]), 111)  
    END

--Applying condition the acccount openning date must no be greater than current day
UPDATE Migration$
SET [Account Open Date] = 
    CASE 
        WHEN TRY_CONVERT(datetime, [Account Open Date]) IS NULL THEN 
            REPLACE(REPLACE([Account Open Date], '.', '/'), '-', '/')
        WHEN TRY_CONVERT(datetime, [Account Open Date]) <= '2080/09/18' THEN 
            CONVERT(varchar, TRY_CONVERT(datetime, [Account Open Date]), 111) 
        ELSE 
            'Invalid Date'  
    END


----date format as per YYYY/MM/DD
use NexGenCoSysDBDev
go
select * from MemMemberRegistration

select birthonBs into #temp from MemMemberRegistration
where BirthOnBS is not null

select distinct BirthOnBS from #temp


UPDATE MemMemberRegistration
SET BirthOnBS = 
    CASE 
        WHEN ISDATE(BirthOnBS) = 0 OR CONVERT(datetime, BirthOnBS, 111) > '2080/09/18' THEN 
            '2065/01/01'
        ELSE 
            CONVERT(varchar, CONVERT(datetime, BirthOnBS, 111), 111)
    END;




--convert date
update MemMemberRegistration
set BirthOn= dbo.ConvertDateNepaliToEnglish(BirthOnBS)


--maturity date as per duration
UPDATE MamAccountOpening
SET MaturityOn = DATEADD(YEAR, 5, AccountOpenOn)
WHERE SycDepositTypeId = 14;


--format date
UPDATE MamAccountOpening
--set  MaturityOnBs =replace( MaturityOnBs,'.','/')
set MaturityOnBs=REPLACE(REPLACE(MaturityOnBs, '.', '/'), '-', '/')
WHERE SycDepositTypeId = 11;



-- valid date verification in MemMemberRegistration
SELECT *
FROM MemMemberRegistration
WHERE ISDATE(BirthOnBS) = 0
   OR CONVERT(VARCHAR, CONVERT(DATE, BirthOnBS, 111), 111) != BirthOnBS;

 
select dbo.ConvertDateNepaliToEnglish('2046/04/31')



--valid date 
SELECT [Account Open Date3], [Account Maturity Date3],S#N,[Members Name]
FROM #temp
WHERE ISDATE([Account Open Date3]) = 0 OR ISDATE([Account Maturity Date3]) = 0;


--update datedifference 
update #temp
select
 --set Total =
 DATEDIFF(YEAR, [Account Open Date3], [Account Maturity Date3]) from #temp