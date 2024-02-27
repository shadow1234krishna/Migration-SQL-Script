use NexGenCoSysDBDev
delete from LmtLoanTypeMaster
dbcc checkident ('LmtLoanTypeMaster', reseed, 0)


delete from LmtLoanType
INSERT INTO [NexGenCoSysDBDev].[dbo].[LmtLoanType]
           ([LoanTypeName]
           ,[CreatedBy]
           ,[CreatedOn])
SELECT
	    GlSubName      
       ,0
       ,GETDATE()
FROM  Finact.DBO.lastgledger where keyfigg='600Loan'
GO


USE NexGenCoSysDBDev

IF NOT EXISTS(SELECT * FROM LmtLoanCategory WHERE LoanCategoryName='Long Term Loan')
BEGIN 
	INSERT INTO LmtLoanCategory VALUES('Long Term Loan','')
END
IF NOT EXISTS(SELECT * FROM LmtLoanCategory WHERE LoanCategoryName='Mid Term Loan')
BEGIN 
	INSERT INTO LmtLoanCategory VALUES('Mid Term Loan','')
END
IF NOT EXISTS(SELECT * FROM LmtLoanCategory WHERE LoanCategoryName='Short Term Loan')
BEGIN 
	INSERT INTO LmtLoanCategory VALUES('Short Term Loan','')
END

use NexGenCoSysDBDev
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
      ,(SELECT TOP 1 LmtLoanTypeId FROM LmtLoanType WHERE LoanTypeName = GlSubName)      
      ,GlSubInstNo 
      ,'Y'
      ,GlSubIntRate
      ,0
      ,0
      ,'N'
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice)
      ,1
	  ,''
      ,0
	  ,GETDATE()
	  ,'1990-01-01'
	  ,'2046/09/17'
     
  FROM  PraNew.DBO.lastgledger where keyfigg='600Loan'
  
GO

select * from LmtLoanTypeMaster

SELECT LoanTypeName, COUNT(*) AS count
FROM LmtLoanTypeMaster
GROUP BY LoanTypeName
HAVING COUNT(*) > 1;





select * from LmtLoanTypeMaster

DELETE FROM LmtLoanTypeMaster
WHERE LmtLoanTypeMasterId in (43,53)

DELETE FROM LmtLoanTypeMaster
WHERE LoanTypeName IN (
    SELECT LoanTypeName
    FROM (
        SELECT 
            LoanTypeName,
            ROW_NUMBER() OVER (PARTITION BY LoanTypeName ORDER BY LoanTypeName) AS RowNum
        FROM LmtLoanTypeMaster
    ) AS DuplicateRows
    WHERE RowNum > 1
);
