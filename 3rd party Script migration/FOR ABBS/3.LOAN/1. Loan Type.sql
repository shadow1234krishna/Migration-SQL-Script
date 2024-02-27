use NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='beni BRANCH'
delete from LmtLoanTypeMaster
where UsmOfficeId=(select usmofficeid from UsmOffice where officename=@OFFICENAME)

INSERT INTO [NexGenCoSysDBDev].[dbo].[LmtLoanTypeMaster]
           ([LoanTypeCode]
           ,[LoanTypeName]
           ,[LmtLoanCategoryId]
           ,[LmtLoanTypeId]
           ,[Period]
           ,[PeriodType]
           ,[InterestRate]
           ,[MaximumAmount]
           ,[CodeValue]
           ,[LoanODorNormal]
           ,[UsmOfficeId]
           ,[IsActive]
           ,[Remarks]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[InterestActivationOn]
           ,[InterestActivationOnBs])


SELECT        
		GlSubHead
      ,GlSubName
      ,(SELECT TOP 1 LmtLoanCategoryId FROM LmtLoanCategory WHERE LoanCategoryName='Mid Term Loan')
      ,(SELECT TOP 1 LmtLoanTypeId FROM LmtLoanType )      
      ,GlSubInstNo 
      ,'Y'
      ,GlSubIntRate
      ,0
      ,0
      ,'N'
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice where UsmOfficeId=(select usmofficeid from UsmOffice where OfficeName=@OFFICENAME))
      ,1
	  ,''
      ,0
	  ,GETDATE()
	  ,'1990-01-01'
	  ,'2046/09/17'
     
  FROM  kamana.DBO.lastgledger where keyfigg='600Loan'
  
GO