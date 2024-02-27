USE NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='Beni Branch'

DELETE FROM MemMemberRegistration
WHERE UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)

		INSERT INTO NexGenCoSysDBDev.[dbo].[MemMemberRegistration]
				   ([MemberId]
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
				   )
		SELECT 
			  'MR-'+(SELECT OfficeShortCode FROM USMOFFICE WHERE OfficeName=@OFFICENAME) +'-'+ CAST(CusCidNo AS NVARCHAR) --member id
			  , (SELECT TOP 1 SycMemberTypeId FROM SycMemberType) --sycmembertype
			  ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice WHERE OfficeName=@OFFICENAME) --usmoffice
			  ,CASE WHEN CusTitle IS NULL THEN (SELECT TOP 1 SycSalutationId FROM SycSalutation WHERE SalutationName='-')
			  ELSE (SELECT TOP 1 SycSalutationId FROM dbo.SycSalutation WHERE SalutationName=CusTitle) END --salutation
			  ,ISNULL(rtrim(ltrim(cusfname)),'')--first name
			  ,''	--middle name
			  ,ISNULL(rtrim(ltrim(CusLName)),'')--last name
			  ,'' --dob
			  ,CusDob --dob nepali
			  ,CusAdd1+ISNULL(CusAdd2,'') --address
			  ,CusMAdd1+ISNULL(CusMAdd2,'')--address
			  ,ISNULL(CusOffTel,'')--phone no
			  ,ISNULL(CusResTel,'')-- phone no
			  ,ISNULL(CusEmail,'')--email
			  ,CASE WHEN  CusCity LIKE 'nepal' THEN (SELECT TOP 1 SycNationalityId FROM SycNationality WHERE Nationality='Nepal')
			  ELSE (SELECT TOP 1 SycNationalityId FROM SycNationality WHERE Nationality='-') END --nationality
			  ,ISNULL(cuscitinum,'')--citizenship no
			  ,''--passport
			  ,CASE WHEN cusAccupetion IS NULL THEN (SELECT TOP 1 SycOccupationId FROM SycOccupation WHERE Occupation='-') 
			  ELSE (SELECT TOP 1 SycOccupationId FROM SycOccupation WHERE Occupation = cusAccupetion) END --occupation
			  ,'' --other occupation
			  ,(SELECT TOP 1 SycReligionId FROM SycReligion)--RELIGION
			  ,CASE WHEN CusMarital IS NULL THEN (SELECT TOP 1 SycMaritualStatusId FROM SycMaritualStatus WHERE MaritualStatus='-') 
			  ELSE (SELECT TOP 1 SycMaritualStatusId FROM dbo.SycMaritualStatus WHERE  MaritualStatus= CusMarital) END --MARITAL STATUS
			  ,ISNULL(cusgfather,'') -- GRANDFATHER
			  ,ISNULL(cusfather,'')--FATHER
			  ,''--MOTHER
			  ,ISNULL(cushuswife,'')--SPOUSE
			  ,(SELECT TOP 1 SycCasteId FROM SycCaste WHERE Caste = CusLName) --CASTE
			  ,CASE WHEN CusSexMale='Male' THEN 1
					WHEN CusSexMale='Female' THEN 2
					ELSE 3 END --GENDER
			  ,(SELECT TOP 1 SycVDCId FROM SycVDC)-- VDC
			  ,'' --REGISTRATION ON 
			  ,ISNULL(CusRegister,'')--REGISTRATION NEPALI
			  ,NULL-- INTRODUCED BY
			  ,1--STATUS
			  ,11 --MEMBER GROUP
			  ,CAST(CusCidNo AS NVARCHAR)--REMARKS
			  ,0 --CREATED BY
			  ,GETDATE()-- CREATED ON
			  ,dbo.ConvertDateEnglishToNepali(GETDATE())   --CREATED ON BS
		      
		  FROM KAMANA.DBO.fincif ORDER BY CusCidNo
		  
 


update MemMemberRegistration set BirthOnBS= REPLACE(BirthOnBS,'.','/') WHERE UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)

update MemMemberRegistration set BirthOnBS= REPLACE(BirthOnBS,'-','/') WHERE UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)



update MemMemberRegistration set RegistrationOnBS= (select DateNepali from KAMANA.dbo.DateNumber where RegistrationOnBS=dateNumber) WHERE UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)


update MemMemberRegistration set RegistrationOn= dbo.ConvertDateNepaliToEnglish(RegistrationOnBS) WHERE UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)


---------------------------------------------------dummy updates-----------------------------------------------------------	 
update MemMemberRegistration set CitizenShipIssuedOn='1989-09-02',CitizenShipIssuedOnBs=dbo.ConvertDateEnglishToNepali('1989-09-02') WHERE UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)

update MemMemberRegistration set [SycStateVDCId]=2 WHERE UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)


SELECt*FROM MemMemberRegistration ORDER BY MemberId
	 

