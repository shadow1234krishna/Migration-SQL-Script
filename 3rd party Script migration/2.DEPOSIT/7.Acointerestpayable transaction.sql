use NexGenCoSysDBDev
DBCC CHECKIDENT ('acointerestpayable',RESEED,1)
go
delete FROM AcoInterestPayable
go
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
,'closing interest payable during migration'
,0----13
,GETDATE()
,1
FROM MamAccountOpening a WHERE InterestPayable!=0 and MamAccountStatusId in (1,5)

select LastInterestDateOnBs, InterestPayable, AccountOpenOnBs, * from MamAccountOpening
where MamAccountStatusId = 1

select * from AcoInterestPayable