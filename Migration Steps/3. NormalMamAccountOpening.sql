USE [NexGenCoSysDBDev]
GO

select  [S#N]
         ,[weekly saving account]
      ,[Account open date4]
      ,[Account maturity date4]
      ,[interst rate]
      ,[int#payable]
      ,[weekly saving Accont blance]
	into ##temp
	  from Demo.dbo.migration$
where [weekly saving Accont blance] is not null

drop table ##temp

select dbo.ConvertDateNepaliToEnglish('2079.02.29')
select * from ##temp


go
alter table ##temp
add Accno int identity(1,1)



--delete from MamAccountOpening
--dbcc checkident ('MamAccountOpening',reseed,0)

INSERT INTO [dbo].[MamAccountOpening](
	 [UsmOfficeId]
	,[MemMemberRegistrationId]
	,[HurCollectorId]
	,[AccountNo]
	,[SycDepositTypeId]
	,[MamAccountHolderTypeId]
	,[InterestRate]
	,[SycInterestCalculationTypeId]
	,[SycDepositMethodTypeId]
	,[MamInterestTransferAccountOpeningId]
	,[TaxRate]
	,[AccountOpenOn]
	,[AccountOpenOnBs]
	,[Certificates]
	,[Signature]
	,[LedgerBalance]
	,[FreezeAmount]
	,[MaturityOn]
	,[MaturityOnBs]
	,[NextInterestDateOn]
	,[NextInterestDateOnBs]
	,[Withdrawal]
	,[AccountClose]
	,[MamAccountStatusId]
	,[TermDepositInstallmentAmount]
	,[TermDepositMaturityAmount]
	,[TermDepositNoOfInstallment]
	,[TermDepositNoOfInstallmentType]
	,[SycSmsCategoryId]
	,[Remarks]
	,[BalanceCd]
	,[LastInterestDateOn]
	,[LastInterestDateOnBs]
	,[IsInterestCalculationActive]
	,[IsInterestCreditable]
	,[IsInterestCustomized]
	,[InterestPayable]
	,[TaxReceivable]
	,[PendingTransactionRemarks]
	,[CreatedBy]
	,[CreatedOn]
	,[CreatedOnBs]
	,[LastModifiedBy]
	,[LastModifiedOn]
	,[LastModifiedOnBs]
	,[IsDeleted]
	,[IsRenewed]
	,[PreviousInterest]
	,[PinCode]
	,[PinCodeGeneratedOn]
	,[PinCodeGeneratedBy]
	,[PinCodeLastChangedOn]
	,[MinimumAmount]
	,[MaximumAmount]
	,[IsFundTransferActive]
	,[eSewaId]
	,[AccountNamingOption]
	,[MinorAccount]
	,[AccountName]
	,[EnableMobileAppNotification]
	,[CompulsaryAmountLastChangedOn]
	,[CompulsaryAmountLastChangedOnBS]
	,[CompulsaryDueAmount]
	,[CompulsaryDueAmountCount]
	,[CompulsaryDueAmountInstallment]
	,[PenaltyTillDateOn]
	,[PenaltyTillDateOnBs]
	,[PreviousPenaltyAmount]
	,[RenewAutomatically]
)
select
	2--<UsmOfficeId, bigint,>
	,(select MemMemberRegistrationId from MemMemberRegistration mem where cast(mem.Remarks as nvarchar) = t.[S#N] )--,<MemMemberRegistrationId, bigint,>	*****
	,(select top 1 HurCollectorId from HurCollector)--,<HurCollectorId, bigint,>
	,'WS' + '-01-' + cast(t.Accno as nvarchar)--,<AccountNo, nvarchar(50),>	*****
	,(select SycDepositTypeId from SycDepositType where DepositTypeCode = 'WS')--,<SycDepositTypeId, bigint,>	****
	,1--,<MamAccountHolderTypeId, bigint,>
	,t.[interst rate]--,<InterestRate, numeric(18,2),>
	,null--,<SycInterestCalculationTypeId, bigint,>
	,null--,<SycDepositMethodTypeId, int,>
	,null--,<MamInterestTransferAccountOpeningId, bigint,>
	,6--,<TaxRate, numeric(18,2),>
	,dbo.ConvertDateNepaliToEnglish(REPLACE(t.[Account open date4], '.', '/'))--,<AccountOpenOn, datetime,>		*****
	,REPLACE(t.[Account open date4], '.', '/')--,<AccountOpenOnBs, nvarchar(50),>
	,''--,<Certificates, nvarchar(255),>
	,null--,<Signature, nvarchar(255),>
	,0--,<LedgerBalance, numeric(18,2),>
	,0--,<FreezeAmount, numeric(18,2),>
	,dbo.ConvertDateNepaliToEnglish(REPLACE(t.[Account maturity date4], '.', '/'))--,<MaturityOn, datetime,>
	,REPLACE(t.[Account maturity date4], '.', '/')--,<MaturityOnBs, nvarchar(50),>
	,null--,<NextInterestDateOn, datetime,>
	,null--,<NextInterestDateOnBs, nvarchar(50),>
	,1--,<Withdrawal, bit,>
	,1--,<AccountClose, bit,>
	,1--,<MamAccountStatusId, bigint,>
	,null--,<TermDepositInstallmentAmount, numeric(18,2),>
	,null--,<TermDepositMaturityAmount, numeric(18,2),>
	,null--,<TermDepositNoOfInstallment, numeric(18,0),>
	,null--,<TermDepositNoOfInstallmentType, nvarchar(1),>
	,1--,<SycSmsCategoryId, bigint,>
	,cast(t.[S#N] as nvarchar)--,<Remarks, ntext,>				*****
	,0--,<BalanceCd, decimal(18,2),>
	,null--,<LastInterestDateOn, datetime,>								*****
	,null--,<LastInterestDateOnBs, nvarchar(50),>
	,1--,<IsInterestCalculationActive, bit,>
	,1--,<IsInterestCreditable, bit,>
	,1--,<IsInterestCustomized, bit,>
	,0--,<InterestPayable, decimal(18,2),>
	,0--,<TaxReceivable, decimal(18,2),>
	,null--,<PendingTransactionRemarks, nvarchar(max),>
	,0--,<CreatedBy, bigint,>
	,GETDATE()--,<CreatedOn, datetime,>
	,dbo.ConvertDateEnglishToNepali(GETDATE())--,<CreatedOnBs, nvarchar(50),>
	,null--,<LastModifiedBy, bigint,>
	,null--,<LastModifiedOn, datetime,>
	,null--,<LastModifiedOnBs, nvarchar(50),>
	,0--,<IsDeleted, bit,>
	,0--,<IsRenewed, bit,>
	,0--,<PreviousInterest, numeric(18,2),>
	,null--,<PinCode, nvarchar(10),>
	,null--,<PinCodeGeneratedOn, datetime,>
	,null--,<PinCodeGeneratedBy, bigint,>
	,null--,<PinCodeLastChangedOn, datetime,>
	,0--,<MinimumAmount, decimal(18,0),>
	,0--,<MaximumAmount, decimal(18,0),>
	,1--,<IsFundTransferActive, bit,>
	,0--,<eSewaId, nvarchar(50),>
	,0--,<AccountNamingOption, bit,>						*** if minor acc
	,0--,<MinorAccount, bit,>								*** if minor acc
	,null--,<AccountName, nvarchar(255),>			*** if minor acc
	,0--,<EnableMobileAppNotification, bit,>
	,null--,<CompulsaryAmountLastChangedOn, date,>
	,0--,<CompulsaryAmountLastChangedOnBS, nvarchar(10),>
	,0--,<CompulsaryDueAmount, numeric(18,2),>
	,0--,<CompulsaryDueAmountCount, int,>
	,0--,<CompulsaryDueAmountInstallment, numeric(18,2),>
	,null--,<PenaltyTillDateOn, date,>
	,null--,<PenaltyTillDateOnBs, nvarchar(10),>
	,null--,<PreviousPenaltyAmount, numeric(18,2),>
	,0--,<RenewAutomatically, bit,>
from ##temp t

drop table ##temp

select * from MamAccountOpening
where SycDepositTypeId in (select SycDepositTypeId from SycDepositType
	where SycDepositCategoryId = 1)

SELECT dbo.ConvertDateNepaliToEnglish('2079/02/09') AS EnglishDate;





update ##temp
set  [Interest rate2]=10
where S#N =192


select * from MamAccountOpening
delete from MamAccountOpening
where MamAccountOpeningId between 526 and 654

update MamAccountOpening
set InterestRate=5
where SycDepositTypeId=2

where MamAccountOpeningId=522

select * from SycDepositType


select * from MamAccountOpening
where SycDepositTypeId in (select SycDepositTypeId from SycDepositType where SycDepositCategoryId=2)
and MaturityOnBs is null


select  Distinct SycDepositCategoryId from SycDepositType
select * from SycDepositCategory

update MamAccountOpening
set MaturityOnBs='2082/03/01'
where MamAccountOpeningId=26


select * from MamAccountOpening
where MamAccountOpeningId=238



UPDATE MamAccountOpening
SET MaturityOnBs = DATEADD(YEAR, 5, AccountOpenOnBs)
WHERE SycDepositTypeId = 14;

SELECT DATEADD(YEAR, 5, '2079-02-28') AS NewDate;


select * from MamAccountHolderType