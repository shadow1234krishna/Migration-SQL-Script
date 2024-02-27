USE [NexGenCoSysDBDev]
GO

select * from shree.dbo.['migratation $']
order by S#N

delete from shree.dbo.['migratation $'] where [Members Name] is null
delete from shree.dbo.['migratation $'] where S#N is null

select * from Demo.dbo.Migration$
where [Members Name] is not null
	and [S#N] is not null
order by [S#N]

select [S#N]
      ,[Members Name]
	  into #temp
	  from shree.dbo.['migratation $']
		where 
		[Members Name] is not null
			and [S#N] is not null
		order by [S#N]

select * from #temp

 drop table shree.dbo.['migratation $']

DELETE from nexgencosysdbdev.dbo.MemMemberRegistration
dbcc checkident ('MemMemberRegistration',reseed,0)

INSERT INTO [dbo].[MemMemberRegistration](
	 [MemberId]
	,[SycMemberTypeId]
	,[UsmOfficeId]
	,[SycSalutationId]
	,[FirstName]
	,[MiddleName]
	,[LastName]
	,[BirthOn]
	,[BirthOnBS]
	,[PermanentAddessDetail]
	,[TemporaryAddressDetail]
	,[PhoneNo]
	,[MobileNo]
	,[EmailAddress]
	,[SycNationalityId]
	,[CitizenshipNo]
	,[PassportNo]
	,[SycOccupationId]
	,[OtherOccupation]
	,[SycReligionId]
	,[SycMaritalStatusId]
	,[GrandFatherMotherName]
	,[FatherName]
	,[MotherName]
	,[SpouseName]
	,[SycCasteId]
	,[SycGenderId]
	,[SycVdcId]
	,[RegistrationOn]
	,[RegistrationOnBS]
	,[IntroducedBy]
	,[SycStatusId]
	,[SycMemberGroupId]
	,[Remarks]
	,[CreatedBy]
	,[CreatedOn]
	,[CreatedOnBs]
	,[LastModifiedBy]
	,[LastModifiedOn]
	,[LastModifiedOnBs]
	,[CitizenShipIssuedOn]
	,[CitizenShipIssuedOnBs]
	,[CitizenShipIssuedDistrict]
	,[ElectricityNo]
	,[WaterSupplyNo]
	,[IMEINo]
	,[SycIncomeRangeId]
	,[SycEducationId]
	,[DeviceId]
	,[GPSCoOrdinate]
	,[SycStateVDCId]
	,[MemberYearlyPaymentTillDateOn]
	,[MemberYearlyPaymentTillDateOnBs]
	,[NameInNepali]
	,[AddressInNepali]
)
select
	'MR-01-' + cast(t.S#N as nvarchar)--(<MemberId, nvarchar(50),>
	,3--,<SycMemberTypeId, int,>
	,2--,<UsmOfficeId, bigint,>
	,30--,<SycSalutationId, int,>
	,(SELECT Ltrim(SubString([Members Name],1,Isnull(Nullif(CHARINDEX(' ',[Members Name]),0),1000))))--,<FirstName, nvarchar(100),>
	,(Ltrim(SUBSTRING([Members Name],CharIndex(' ',[Members Name]), CASE WHEN (CHARINDEX(' ',[Members Name],CHARINDEX(' ',[Members Name])+1)-CHARINDEX(' ',[Members Name]))<=0 THEN 0   
		ELSE CHARINDEX(' ',[Members Name],CHARINDEX(' ',[Members Name])+1)-CHARINDEX(' ',[Members Name]) END )))--,<MiddleName, nvarchar(100),>
	,(Ltrim(SUBSTRING([Members Name],Isnull(Nullif(CHARINDEX(' ',[Members Name],Charindex(' ',[Members Name])+1),0),CHARINDEX(' ',[Members Name])),  
		CASE WHEN Charindex(' ',[Members Name])=0 THEN 0 ELSE LEN([Members Name]) END)))--,<LastName, nvarchar(100),>
	,dbo.ConvertDateNepaliToEnglish('2045/01/01')--,<BirthOn, date,>
	,'2045/01/01'--,<BirthOnBS, nvarchar(20),>
	,'-'--,<PermanentAddessDetail, nvarchar(100),>
	,'-'--,<TemporaryAddressDetail, nvarchar(100),>
	,null--,<PhoneNo, nvarchar(50),>
	,null--,<MobileNo, nvarchar(50),>
	,'name@gmail.com'--,<EmailAddress, nvarchar(100),>
	,5--,<SycNationalityId, int,>
	,null--,<CitizenshipNo, nvarchar(50),>
	,null--,<PassportNo, nvarchar(50),>
	,27--,<SycOccupationId, int,>
	,null--,<OtherOccupation, nvarchar(100),>
	,1--,<SycReligionId, int,>
	,3--,<SycMaritalStatusId, int,>
	,''--,<GrandFatherMotherName, nvarchar(100),>
	,''--,<FatherName, nvarchar(100),>
	,''--,<MotherName, nvarchar(100),>
	,''--,<SpouseName, nvarchar(100),>
	,3--,<SycCasteId, int,>
	,1--,<SycGenderId, int,>
	,1--,<SycVdcId, int,>
	,dbo.ConvertDateNepaliToEnglish('2050/01/01')--,<RegistrationOn, date,>		***
	,'2050/01/01'--,<RegistrationOnBS, varchar(50),>							***
	,0--,<IntroducedBy, bigint,>
	,1--,<SycStatusId, int,>
	,11--,<SycMemberGroupId, int,>
	,cast(t.S#N as nvarchar)--,<Remarks, ntext,>
	,0--,<CreatedBy, bigint,>
	,GETDATE()--,<CreatedOn, datetime,>
	,dbo.ConvertDateEnglishToNepali(GETDATE())--,<CreatedOnBs, nvarchar(50),>
	,0--,<LastModifiedBy, bigint,>
	,null--,<LastModifiedOn, datetime,>
	,null--,<LastModifiedOnBs, nvarchar(50),>
	,dbo.ConvertDateNepaliToEnglish('2065/01/01')--,<CitizenShipIssuedOn, datetime,>
	,'2065/01/01'--,<CitizenShipIssuedOnBs, nvarchar(50),>
	,'-'--,<CitizenShipIssuedDistrict, nvarchar(50),>
	,null--,<ElectricityNo, nvarchar(50),>
	,null--,<WaterSupplyNo, nvarchar(50),>
	,null--,<IMEINo, nvarchar(50),>
	,(select top 1 SycIncomeRangeId from SycIncomeRange)--,<SycIncomeRangeId, int,>
	,(select top 1 SycEducationId from SycEducation)--,<SycEducationId, int,>
	,null--,<DeviceId, nvarchar(255),>
	,null--,<GPSCoOrdinate, nvarchar(50),>
	,2--,<SycStateVDCId, int,>
	,null--,<MemberYearlyPaymentTillDateOn, date,>
	,null--,<MemberYearlyPaymentTillDateOnBs, nvarchar(10),>
	,''--,<NameInNepali, nvarchar(max),>
	,''--,<AddressInNepali, nvarchar(max),>
from #temp t

drop table #temp

select * from MemMemberRegistration
where
LastName=' '


update MemMemberRegistration
set LastName=MiddleName
where MemMemberRegistrationId=413

update MemMemberRegistration
set MiddleName=' '
where MemMemberRegistrationId=413

WITH CTE AS (
    SELECT 
        S#N,
        ROW_NUMBER() OVER (PARTITION BY S#N ORDER BY (SELECT NULL)) AS RowNum
    FROM 
        #temp
)
DELETE FROM CTE
WHERE RowNum > 1;


