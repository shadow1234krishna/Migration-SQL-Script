use NexGenCoSysDBDev

delete from MemNomineeDetail
dbcc checkident ('MemNomineeDetail',reseed,1)

insert into NexGenCoSysDBDev.dbo.MemNomineeDetail
      ( [MemMemberRegistrationId]
      ,[NomineeName]
      ,[NomineeAddress]
      ,[NomineeContactNo]
      ,[SycRelationId]
      ,[Remarks]
      ,[IsActive])
      
select 
(select top 1 memmemberregistrationid from MemMemberRegistration  where REPLACE(MemberId,'MR-01-','')=NomineeId)
,SUBSTRING(NName,0,101)
,NAdd1+','+NAdd2
 ,NTelNo
 ,(SELECT TOP 1 SycRelationId FROM SycRelation WHERE Relation = NRelation)
 ,CAST(NomineeId AS NVARCHAR)
 ,1
 FROM Finact.DBO.Nominee WHERE NomineeId IN (select  REPLACE(MemberId,'MR-01-','') from MemMemberRegistration)