USE [NexGenCoSysDBDev]
GO

select * from Demo.dbo.migration$

select S#N
     ,[Loan issue Date1]
      ,[Maturity date1]
      ,[Interest Receivable1]
      ,[interest rate5]
      ,[Agriculture Loan principle last balance]


	into #temp
	  from Demo.dbo.migration$
	where [Agriculture Loan principle last balance] is not null

select * from #temp
delete from #temp
where [Loan issue Date1] is null
where S#N='204'

update #temp
set [Loan issue Date1] =replace( [Loan issue Date1],'.','/')

update #temp
set [Loan issue Date1] ='2079/11/29'
where S#N=327

update #temp
set [interest rate5]=16

alter table #temp
add LoanAcc int identity(1,1)
select * from #temp

--delete from LmtLoanIssue
--dbcc checkident ('LmtLoanIssue',reseed,0)

INSERT INTO [dbo].[LmtLoanIssue](
	 [MemMemberRegistrationId]
	,[LoanAccountNo]
	,[LmtLoanTypeMasterId]
	,[LoanSanctionAmount]
	,[LoanIssueAmount]
	,[Period]
	,[PeriodType]
	,[LmtPaymentDurationTypeId]
	,[InterestRate]
	,[LmtLoanPaymentTypeId]
	,[LoanIssueOn]
	,[LoanIssueOnBs]
	,[PrinciplePaidFrom]
	,[PrinciplePaidAfterEach]
	,[MaturityOn]
	,[MaturityOnBs]
	,[LmtLoanPaymentMethodId]
	,[NetPaidAmount]
	,[LmtLoanStatusId]
	,[MamAccountOpeningId]
	,[LoanODorNormal]
	,[RevolvingSanctionAmount]
	,[RevolvingSavingACId]
	,[RevolvingBalanceAmount]
	,[HurCollectorId]
	,[UsmOfficeId]
	,[TransStatus]
	,[IsVerified]
	,[VerifiedBy]
	,[VerifiedOn]
	,[CreatedBy]
	,[CreatedOn]
	,[LastModifiedBy]
	,[LastModifiedOn]
	,[IsActive]
	,[Remarks]
	,[LoanGuarantee]
	,[IsEdited]
	,[IsPosted]
	,[InterestReceivableAmount]
	,[InterestReceivableTillDateOnBs]
	,[InterestReceivableTillDateOn]
	,[PenaltyReceivableAmount]
	,[PenaltyReceivableTillDateOnBs]
	,[PenaltyReceivableTillDateOn]
	,[InstallamentAmount]
	,[InstallmentType]
	,[PenaltyPaymentMethod]
	,[LoanPaymentMethod]
	,[LoanCloseOn]
	,[LoanCloseOnBs]
	,[SycSmsCategoryId]
	,[LoanScheduleInterval]
	,[IsOverDraftPayment]
	,[IsProcessed]
	,[ProcessedOn]
	,[ProcessedOnBs]
	,[ProcessedBy]
	,[SycMemberGroupId]
	,[SycCollectionCenterId]
	,[FirstInstallmentOn]
	,[FirstInstallmentOnBs]
	,[EnableMobileAppNotification]
	,[LoanScheduleDateType]
	,[LoanRescheduleDateOn]
	,[LoanRescheduleDateOnBs]
	,[UploadedDocument]
)
select
	(select MemMemberRegistrationId from MemMemberRegistration mem where cast(mem.Remarks as nvarchar) = cast(t.S#N as nvarchar))--<MemMemberRegistrationId, bigint,>	*****
	,'AGL' + '-01-' + cast(t.LoanAcc as nvarchar(max)) --,<LoanAccountNo, nvarchar(50),>		*****
	,(select LmtLoanTypeMasterId from LmtLoanTypeMaster where LoanTypeCode = 'AGL')--,<LmtLoanTypeMasterId, bigint,>		*****
	,0--,<LoanSanctionAmount, numeric(18,2),>
	,t.[Agriculture Loan principle last balance]--,<LoanIssueAmount, numeric(18,2),> *****
	,1--,<Period, numeric(18,0),>
	,'Y'--,<PeriodType, char(1),>
	,3--,<LmtPaymentDurationTypeId, int,>
	,t.[interest rate5]--,<InterestRate, numeric(18,2),>
	,1--,<LmtLoanPaymentTypeId, int,>
	,dbo.ConvertDateNepaliToEnglish(REPLACE(t.[Loan issue Date1], '.', '/'))--,<LoanIssueOn, date,>	*****
	,REPLACE(t.[Loan issue Date1], '.', '/')--,<LoanIssueOnBs, nvarchar(50),>							
	,null--,<PrinciplePaidFrom, numeric(18,0),>
	,null--,<PrinciplePaidAfterEach, numeric(18,0),>
	,dbo.ConvertDateNepaliToEnglish(REPLACE(t.[Maturity date1], '.', '/'))--,<MaturityOn, datetime,>	*****
	,REPLACE(t.[Maturity date1], '.', '/')--,<MaturityOnBs, nvarchar(50),>
	,1--,<LmtLoanPaymentMethodId, int,>
	,t.[Agriculture Loan principle last balance]--,<NetPaidAmount, numeric(18,2),>					*****
	,1--,<LmtLoanStatusId, int,>
	,null--,<MamAccountOpeningId, bigint,>
	,'N'--,<LoanODorNormal, char(1),>
	,0--,<RevolvingSanctionAmount, numeric(18,2),>
	,null--,<RevolvingSavingACId, bigint,>
	,0--,<RevolvingBalanceAmount, numeric(18,2),>
	,69--,<HurCollectorId, bigint,>
	,2--,<UsmOfficeId, bigint,>
	,'I'--,<TransStatus, char(1),>
	,1--,<IsVerified, bit,>
	,0--,<VerifiedBy, nvarchar(100),>
	,null--,<VerifiedOn, datetime,>
	,0--,<CreatedBy, bigint,>
	,GETDATE()--,<CreatedOn, datetime,>
	,null--,<LastModifiedBy, bigint,>
	,null--,<LastModifiedOn, datetime,>
	,1--,<IsActive, bit,>
	,cast(t.LoanAcc as nvarchar(max))--,<Remarks, ntext,>					*****
	,'Collateral'--,<LoanGuarantee, varchar(40),>
	,0--,<IsEdited, bit,>
	,1--,<IsPosted, bit,>
	,t.[Interest Receivable1]--,<InterestReceivableAmount, numeric(18,2),>						*****
	,null--,<InterestReceivableTillDateOnBs, nvarchar(50),>
	,null--,<InterestReceivableTillDateOn, datetime,>
	,0--,<PenaltyReceivableAmount, numeric(18,2),>
	,''--,<PenaltyReceivableTillDateOnBs, nvarchar(50),>				*****
	,''--,<PenaltyReceivableTillDateOn, datetime,>
	,0--,<InstallamentAmount, numeric(18,2),>
	,'AOD'--,<InstallmentType, nvarchar(5),>
	,3--,<PenaltyPaymentMethod, int,>
	,1--,<LoanPaymentMethod, int,>
	,null--,<LoanCloseOn, datetime,>
	,null--,<LoanCloseOnBs, nvarchar(50),>
	,1--,<SycSmsCategoryId, bigint,>
	,1--,<LoanScheduleInterval, int,>
	,null--,<IsOverDraftPayment, bit,>
	,1--,<IsProcessed, bit,>
	,1--,<ProcessedOn, datetime,>
	,GETDATE()--,<ProcessedOnBs, nvarchar(10),>
	,0--,<ProcessedBy, int,>
	,11--,<SycMemberGroupId, int,>
	,1--,<SycCollectionCenterId, bigint,>
	,null--,<FirstInstallmentOn, date,>
	,null--,<FirstInstallmentOnBs, nvarchar(10),>
	,1--,<EnableMobileAppNotification, bit,>
	,0--,<LoanScheduleDateType, char(1),>
	,null--,<LoanRescheduleDateOn, date,>
	,null--,<LoanRescheduleDateOnBs, nvarchar(10),>
	,null--,<UploadedDocument, nvarchar(max),>)
from #temp t

drop table #temp

select * from LmtLoanIssue
select *from LmtLoanTypeMaster

select * from #temp
update #temp
set intere



update LmtLoanTypeMaster
set InterestRate=16