USE [NexGenCoSysDBDev]
GO

select * into #temp from shree.dbo.SavingTypeWiseReport$

drop table #temp

select * from #temp
delete from #temp
where DeposittypeCode is null

delete from SycDepositType
dbcc checkident('[SycDepositType]',reseed,0)

INSERT INTO [dbo].[SycDepositType](
	[DepositTypeCode]
	,[DepositTypeName]
	,[Duration]
	,[DurationType]
	,[SycDepositCategoryId]
	,[InterestRate]
	,[SycInterestTypeId]
	,[SycInterestCalculationPeriodId]
	,[TaxRate]
	,[MinimumDepositForInterest]
	,[MininumDepositAmount]
	,[MaximumDepositAmount]
	,[MinimumPerDayWithDrawal]
	,[MaxPerDayWithDrawal]
	,[MinimumBalance]
	,[Widthdrawal]
	,[Mandatory]
	,[CollectorCommission]
	,[CodeValue]
	,[InterestCalculationType]
	,[IsCustomizable]
	,[IsActive]
	,[InterestActivationOn]
	,[InterestActivationOnBs]
	,[SycInterestProvisioningInterestCalculationPeriodId]
	,[Remarks]
	,[CreatedBy]
	,[CreatedOn]
	,[LastModifiedBy]
	,[LastModifiedOn]
	,[LastInterestTransferDateOn]
	,[LastInterestTransferDateOnBs]
	,[DepositTypeInNepali]
)
select
	RTRIM (LTRIM (t.DeposittypeCode))--(<DepositTypeCode, nvarchar(20),>
	,t.DepositTypeName--,<DepositTypeName, nvarchar(200),>
	,t.Duration--,<Duration, int,>
	,'Y'--,<DurationType, nvarchar(1),>
	,case
		when t.Category = 'Term Savin' then 4
		when t.Category = 'Fixed Saving' then 3
		else 1
	end --,<SycDepositCategoryId, bigint,>
	,t.InterestRate--,<InterestRate, numeric(18,2),>
	,case
		when t.[Interest Type] = 'Monthly Minimum Balance' then 2
		else 1
	end--,<SycInterestTypeId, bigint,>
	,3--,<SycInterestCalculationPeriodId, bigint,>
	,6--,<TaxRate, numeric(18,2),>
	,0--,<MinimumDepositForInterest, numeric(18,2),>
	,0--,<MininumDepositAmount, numeric(18,2),>
	,0--,<MaximumDepositAmount, numeric(18,2),>
	,0--,<MinimumPerDayWithDrawal, numeric(18,2),>
	,0--,<MaxPerDayWithDrawal, numeric(18,2),>
	,0--,<MinimumBalance, numeric(18,2),>
	,1--,<Widthdrawal, bit,>
	,1--,<Mandatory, bit,>
	,0--,<CollectorCommission, numeric(18,2),>
	,0--,<CodeValue, bigint,>
	,'D'--,<InterestCalculationType, char(1),>
	,1--,<IsCustomizable, bit,>
	,1--,<IsActive, bit,>
	,dbo.ConvertDateNepaliToEnglish('2046/01/01')--,<InterestActivationOn, datetime,>		***
	,'2046/01/01'--,<InterestActivationOnBs, nvarchar(50),>									***
	,case
		when t.[Interest Provision] = 'Yearly' then 4
		when t.[Interest Provision] = 'Quaterly' then 2
		else 5
	end--,<SycInterestProvisioningInterestCalculationPeriodId, bigint,>						***
	,''--,<Remarks, ntext,>
	,0--,<CreatedBy, bigint,>
	,GETDATE()--,<CreatedOn, datetime,>
	,null--,<LastModifiedBy, bigint,>
	,null--,<LastModifiedOn, datetime,>
	,null--,<LastInterestTransferDateOn, date,>
	,null--,<LastInterestTransferDateOnBs, nvarchar(10),>
	,' '--,<DepositTypeInNepali, nvarchar(max),>
from #temp t

select * from SycDepositType
select * from SycDepositCategory

update SycDepositType
set DepositTypeName='share monthly Saving Account'
where SycDepositTypeId=1

drop table #temp