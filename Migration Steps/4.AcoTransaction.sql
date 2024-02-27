USE [NexGenCoSysDBDev]
GO


select  [S#N]
      ,[Members Name]
      ,[Monthly Saving Acount]
      ,[Account Open Date]
      ,[Account Maturity Date]
      ,[Interest rate]
      ,[Int# Payable]
      ,[Monthly Saving Account Balance]

	 into ##temp
	  from Demo.dbo.Migration1$
where [Monthly Saving Account Balance]is not null

go
alter table ##temp
add Accno int identity(1,1)

select * from ##temp
select * from MemMemberRegistration

--delete from AcoTransaction
--dbcc checkident ('AcoTransaction',reseed,0)

INSERT INTO [dbo].[AcoTransaction](
	[MemMemberRegistrationId]
	,[MamAccountOpeningId]
	,[LmtLoanIssueId]
	,[AcoMiscellaneousChargesId]
	,[AcoTransactionTypeId]
	,[ShmShareAllotmentId]
	,[HurCollectorId]
	,[CashReceived]
	,[CashWithdrawl]
	,[MamChequeWithdrawId]
	,[ChequeNo]
	,[ChequeInstitutionName]
	,[ChequeClearanceSendOn]
	,[ChequeClearanceSendOnBs]
	,[ChequeClearanceOn]
	,[ChequeClearanceOnBs]
	,[TransactionNumber]
	,[TransactionOn]
	,[TransactionOnBs]
	,[UsmOfficeId]
	,[IsPosted]
	,[AcoVoucherId]
	,[AcoReverseVoucherId]
	,[Description]
	,[CreatedBy]
	,[CreatedOn]
	,[LastModifiedBy]
	,[LastModifiedOn]
	,[IsEdited]
	,[IsActive]
	,[IsPayable]
	,[DepositOrWithdrawlBy]
	,[AcoLedgerHeadId]
	,[InterestOfMamaccountOpeningId]
	,[SycMemberGroupId]
	,[SycCollectionCenterId]
	,[SycFundPaymentTypeId]
)
select
	(select MemMemberRegistrationId from MemMemberRegistration mem where cast(mem.Remarks as nvarchar) = t.[S#N])--<MemMemberRegistrationId, bigint,>	*****
	,(select MamAccountOpeningId from MamAccountOpening mam where cast(mam.AccountNo as nvarchar) = 'WS-01-' + cast(t.Accno as nvarchar))--,<MamAccountOpeningId, bigint,>	*****
	,null--,<LmtLoanIssueId, bigint,>
	,null--,<AcoMiscellaneousChargesId, bigint,>
	,1--,<AcoTransactionTypeId, bigint,>
	,null--,<ShmShareAllotmentId, bigint,>
	,69--,<HurCollectorId, bigint,>
	,t.[weekly saving Accont blance]--,<CashReceived, numeric(18,2),>		*****
	,null--,<CashWithdrawl, numeric(18,2),>
	,null--,<MamChequeWithdrawId, bigint,>
	,null--,<ChequeNo, nvarchar(50),>
	,null--,<ChequeInstitutionName, nvarchar(200),>
	,null--,<ChequeClearanceSendOn, datetime,>
	,null--,<ChequeClearanceSendOnBs, nvarchar(50),>
	,null--,<ChequeClearanceOn, datetime,>
	,null--,<ChequeClearanceOnBs, nvarchar(50),>
	,0--,<TransactionNumber, numeric(18,0),>
	,dbo.ConvertDateNepaliToEnglish('2080/03/31')--,<TransactionOn, datetime,>		*****
	,'2080/03/31'--,<TransactionOnBs, varchar(50),>
	,2--,<UsmOfficeId, bigint,>
	,1--,<IsPosted, bit,>
	,null--,<AcoVoucherId, bigint,>
	,null--,<AcoReverseVoucherId, bigint,>
	,''--,<Description, ntext,>
	,0--,<CreatedBy, bigint,>
	,GETDATE()--,<CreatedOn, datetime,>
	,null--,<LastModifiedBy, bigint,>
	,null--,<LastModifiedOn, datetime,>
	,0--,<IsEdited, bit,>
	,1--,<IsActive, bit,>
	,1--,<IsPayable, bit,>
	,''--,<DepositOrWithdrawlBy, nvarchar(100),>
	,null--,<AcoLedgerHeadId, bigint,>
	,null--,<InterestOfMamaccountOpeningId, bigint,>
	,null--,<SycMemberGroupId, int,>
	,null--,<SycCollectionCenterId, bigint,>
	,null--,<SycFundPaymentTypeId, bigint,>
from ##temp t

drop table ##temp

select * from AcoTransaction

select * from SycDepositType