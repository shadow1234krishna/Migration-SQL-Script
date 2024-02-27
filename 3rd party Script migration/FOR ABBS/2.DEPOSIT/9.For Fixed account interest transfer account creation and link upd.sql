use NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='beni BRANCH'
Declare @memmemberregistrationid as int
Declare @maxAccId as NVARCHAR(50)
declare @deposittypename nvarchar(45)='INTEREST TRANSFER ACCOUNT'

Declare MY_data CURSOR FOR

select distinct MemMemberRegistrationId From MamAccountOpening where SycDepositTypeId in (select SycDepositTypeId from SycDepositType where SycDepositCategoryId=3) and MamAccountStatusId in (1,5)
and MamInterestTransferAccountOpeningId is null and UsmOfficeId=(select usmofficeid from UsmOffice where OfficeName=@OFFICENAME)

OPEN MY_data
    FETCH NEXT FROM MY_data INTO @memmemberregistrationid
        WHILE @@FETCH_STATUS = 0
        BEGIN

            select @maxAccId =  max(cast(substring(accountno,(charindex('-',accountno,charindex('-',accountno)+1 )+1) ,50) as numeric)) from mamaccountopening 
			where sycdeposittypeid=(select sycdeposittypeid from sycdeposittype where deposittypename=@deposittypename)
			           
		    Insert Into NexGenCoSysDBDev..mamaccountopening
			  ([UsmOfficeId]--1
           ,[MemMemberRegistrationId]---2
           ,[HurCollectorId]--3
           ,[AccountNo]---4
           ,[SycDepositTypeId]---5
           ,[MamAccountHolderTypeId]----6
           ,[AccountOpenOn]---7
           ,[AccountOpenOnBs]---8
           ,[Withdrawal]----9
           ,[AccountClose]----10
           ,[MamAccountStatusId]----11
           ,[IsInterestCalculationActive]--12
           ,[IsInterestCreditable]---13
           ,[IsInterestCustomized]---14
           ,[InterestPayable]---15
           ,[TaxReceivable]----16
            ,[CreatedBy]---17
           ,[CreatedOn]---18
           ,[CreatedOnBs]---19
           ,[IsDeleted]----20
           ,[IsRenewed]---21
           )
			
			 values ((select usmofficeid from usmoffice where OfficeName=@OFFICENAME),---1
			 @memmemberregistrationid,---2
			 69,--3
			 (select DepositTypeCode from sycdeposittype where DepositTypeName=@deposittypename)+'-'+(select OfficeShortCode from usmoffice where OfficeName=@OFFICENAME)+'-'+ISNULL(CAST((@maxAccId+1) AS nvarchar),1)--4
			 ,(select sycdeposittypeid from sycdeposittype where DepositTypeName=@deposittypename ),---5
			 1,---6
			 DBO.ConvertDateNepaliToEnglish('2070/04/01'),---7
			 '2070/04/01',-----8
			 1,----9
			 1,-----10
			 1,------11
			 0,---12
			 0,---13
			 0,----14
			 0,---15
			 0,----16
			 0,----17
			 GETDATE(),----18
			 DBO.ConvertDateEnglishToNepali(GETDATE()),---19
			 0,----20
			 0)


        FETCH NEXT FROM MY_data INTO @memmemberregistrationid
        END
    CLOSE MY_data
DEALLOCATE MY_data

go

USE NexGenCoSysDBDev
declare @deposittypename nvarchar(45)='INTEREST TRANSFER ACCOUNT'
	DECLARE @OFFICENAME NVARCHAR(MAX)='beni BRANCH'
UPDATE AO SET AO.MamInterestTransferAccountOpeningId=
	(
		SELECT TOP 1 MA.MamAccountOpeningId FROM MamAccountOpening AS MA
		LEFT JOIN SycDepositType AS DT 
		ON DT.SycDepositTypeId=MA.SycDepositTypeId
		WHERE MA.MemMemberRegistrationId=AO.MemMemberRegistrationId AND MA.IsDeleted=0 
		AND MA.MamAccountStatusId IN (1,4) AND dt.SycDepositTypeId=(select sycdeposittypeid from 
		sycdeposittype where DepositTypeName=@deposittypename)
	)
	FROM MamAccountOpening AS AO
	LEFT JOIN SycDepositType AS DTY 
	ON DTY.SycDepositTypeId=AO.SycDepositTypeId
	WHERE DTY.SycDepositCategoryId IN (3) AND AO.MamAccountStatusId IN (1,4)
	and UsmOfficeId=(select usmofficeid from usmoffice where officename=@OFFICENAME)
	go
	declare @deposittypename nvarchar(45)='INTEREST TRANSFER ACCOUNT'

	update sycdeposittype set CodeValue=(
	select max(cast(substring(accountno,(charindex('-',accountno,charindex('-',accountno)+1 )+1) ,50) as numeric)) from mamaccountopening 
			where sycdeposittypeid=(select sycdeposittypeid from sycdeposittype where deposittypename=@deposittypename) )
			where SycDepositTypeId=(select sycdeposittypeid from sycdeposittype where deposittypename=@deposittypename) 
