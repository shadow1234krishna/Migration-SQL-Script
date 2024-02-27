use NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='Beni Branch'




insert into NexGenCoSysDBDev.dbo.MemNomineeDetail
      ( [MemMemberRegistrationId]
      ,[NomineeName]
      ,[NomineeAddress]
      ,[NomineeContactNo]
      ,[SycRelationId]
      ,[Remarks]
      ,[IsActive]
	  ,ID)
      
select 
(select top 1 memmemberregistrationid from MemMemberRegistration  where CAST(REMARKS AS NVARCHAR)=NomineeId AND UsmOfficeId=((SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)))
,SUBSTRING(NName,0,101)
,NAdd1+','+NAdd2
 ,NTelNo
 ,(SELECT TOP 1 SycRelationId FROM SycRelation WHERE Relation = NRelation)
 ,CAST(NomineeId AS NVARCHAR)
 ,1
 ,(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)
 FROM kamana.DBO.Nominee WHERE NomineeId IN (select  CAST(REMARKS AS NVARCHAR) from MemMemberRegistration WHERE UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))