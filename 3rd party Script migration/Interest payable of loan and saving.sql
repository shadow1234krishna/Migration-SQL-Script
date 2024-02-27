use NexGenTesting
update a
set InterestPayable=(select b.DFIntBal from FinAct..deposit b where cast(a.Remarks as nvarchar)=b.AcctNo) from MamAccountOpening a 

select distinct DFIntBal from FinAct..deposit

select * from FinAct..deposit





----------------interst payable-----------------------------------------------------------------------------
update a set InterestReceivableAmount=(select b.LAccurInterest from didbahini..Loan b where cast(a.Remarks as nvarchar)=b.AcctNo) from LmtLoanIssue a







--------------------------interst receivable-------------------------------------

select AcctNo,(LIntCalDate-1) as date into #temp From didbahini..loan where LBalPrinc!=0
alter table #temp
add neptrandate nvarchar(max)
update a set a.neptrandate=(select b.DateNepali from didbahini..DateNumber b where a.date=b.dateNumber) from #temp a
update a set InterestReceivableTillDateOnBs=(select b.neptrandate from #temp b where cast(a.Remarks as nvarchar)=b.AcctNo) from LmtLoanIssue a
update LmtLoanIssue set PenaltyReceivableTillDateOnBs=InterestReceivableTillDateOnBs
update lmtloanissue set InterestReceivableTillDateOn=dbo.ConvertDateNepaliToEnglish(InterestReceivableTillDateOnBs),PenaltyReceivableTillDateOn=dbo.ConvertDateNepaliToEnglish(PenaltyReceivableTillDateOnBs)
drop table #temp
--------------interest receivable date for loan--------------------------------------------------------
delete FROM AcoInterestPayable
insert into AcoInterestPayable
   (
     [SycDepositTypeId]--1
      ,[MamAccountOpeningId]---2
      ,[MemMemberRegistrationId]--3
      ,[AccountNo]--4
      ,[TransactionOn]--5
      ,[TransactionOnBs]--6
      ,[InterestAmount]--7
      ,[TaxAmount]--8
      ,[InterestRate]---9
      ,[UsmOfficeId]---10
      ,[InterestTransferMamAccountOpeningId]---11
      ,[IsInterestProvisional]---12
      ,[Narration]---13
      ,[CreatedBy]-----14
      ,[CreatedOn]---15
      ,[IsPosted]-----16
 )

select 
   a.sycdeposittypeid--1
,a.mamaccountopeningid--2
,a.memmemberregistrationid--3
,a.accountno----4
,A.LASTINTERESTdATEON--5
,A.LastInterestDateOnBs---6
,a.interestpayable---7
,a.taxreceivable---8
,a.interestrate----9
,2----10
,a.mamaccountopeningid----11
,1----12
,'closing interest payable'
,0----13
,GETDATE()
,1
FROM MamAccountOpening a WHERE InterestPayable!=0
-------------------------interest payable transferred to acotransaction------------------------
