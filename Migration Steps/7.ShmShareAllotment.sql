USE [NexGenCoSysDBDev]
GO

select [S#N]
      ,[Member name]
      ,[ share blance] into #temp from Demo.dbo.migration$
where [ share blance] is not null

select SN, NameOFShareholders, ShareAmount into #temp from ShreeKrishna..main
where ShareAmount is not null

select * from #temp

delete from ShmShareAllotment
dbcc checkident ('ShmShareAllotment',reseed,0)

INSERT INTO [dbo].[ShmShareAllotment](
	[MemMemberRegistrationId]
	,[UsmOfficeId]
	,[ShmShareTypeId]
	,[ParentId]
	,[ShareNo]
	,[ShareNoFrom]
	,[ShareNoTo]
	,[SharePurchaseOn]
	,[SharePurchaseOnBs]
	,[ShareHoldingPeriodFromOn]
	,[ShareHoldingPeriodFromOnBs]
	,[ShareFaceValue]
	,[SharePremium]
	,[SharePurchaseAmount]
	,[ShareReturnedOn]
	,[ShareReturnedOnBs]
	,[ShareTransferredOn]
	,[ShareTransferredOnBs]
	,[Remarks]
	,[CreatedBy]
	,[CreatedOn]
	,[CreatedOnBs]
	,[LastModifiedBy]
	,[LastModifiedOn]
	,[LastModifiedOnBs]
	,[IsTransferred]
	,[IsActive]
	,[IsReturned]
	,[PreviousMemberId]
	,[IsBonusShare]
	,[CertificateNo]
)
select
	(select MemMemberRegistrationId from MemMemberRegistration mem where cast(mem.Remarks as nvarchar) = cast(t.S#N as nvarchar))--<MemMemberRegistrationId, bigint,>	*****
	,2--,<UsmOfficeId, bigint,>
	,3--,<ShmShareTypeId, int,>
	,null--,<ParentId, bigint,>
	,(t.[ share blance]/100)--,<ShareNo, numeric(18,0),>							*****
	,null--,<ShareNoFrom, numeric(18,0),>
	,null--,<ShareNoTo, numeric(18,0),>
	,dbo.ConvertDateNepaliToEnglish('2080/03/31')--,<SharePurchaseOn, datetime,>			*****
	,'2080/03/31'--,<SharePurchaseOnBs, varchar(50),>
	,dbo.ConvertDateNepaliToEnglish('2080/03/31')--,<ShareHoldingPeriodFromOn, datetime,>	*****
	,'2080/03/31'--,<ShareHoldingPeriodFromOnBs, nvarchar(50),>
	,100--,<ShareFaceValue, numeric(18,2),>
	,0--,<SharePremium, numeric(18,2),>
	,t.[ share blance]--,<SharePurchaseAmount, numeric(18,2),>						*****
	,null--,<ShareReturnedOn, datetime,>
	,null--,<ShareReturnedOnBs, varchar(50),>
	,null--,<ShareTransferredOn, datetime,>
	,null--,<ShareTransferredOnBs, varchar(50),>
	,''--,<Remarks, ntext,>
	,0--,<CreatedBy, bigint,>
	,GETDATE()--,<CreatedOn, datetime,>
	,dbo.ConvertDateEnglishToNepali(GETDATE())--,<CreatedOnBs, nvarchar(50),>
	,null--,<LastModifiedBy, bigint,>
	,null--,<LastModifiedOn, datetime,>
	,null--,<LastModifiedOnBs, nvarchar(50),>
	,0--,<IsTransferred, bit,>
	,1--,<IsActive, bit,>
	,0--,<IsReturned, bit,>
	,null--,<PreviousMemberId, bigint,>
	,0--,<IsBonusShare, bit,>
	,0--,<CertificateNo, numeric(18,0),>
from #temp t

drop table #temp

update ShmShareAllotment
set CertificateNo = ShmShareAllotmentId

select * from HurCollector

select * from ShmShareAllotment





