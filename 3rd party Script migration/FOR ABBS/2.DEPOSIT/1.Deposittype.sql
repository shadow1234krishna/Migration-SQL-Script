USE NexGenCoSysDBDev
--alter table sycdeposittype
--add branch nvarchar(25)
INSERT INTO [NexGenCoSysDBDev].[dbo].[SycDepositType]
				   (
				    [DepositTypeCode]
				   ,[DepositTypeName]
				   ,[Duration]
				   ,[DurationType]
				   ,[SycDepositCategoryId]
				   ,[InterestRate]
				   ,[SycInterestTypeId]
				   ,[SycInterestCalculationPeriodId]
				   ,[TaxRate]
				   ,[MinimumDepositForInterest]
				   ,[MininumDepositAmount]
				   ,[MaximumDepositAmount]
				   ,[MinimumPerDayWithDrawal]
				   ,[MaxPerDayWithDrawal]
				   ,[MinimumBalance]
				   ,[Widthdrawal]
				   ,[Mandatory]
				   ,[CollectorCommission]
				   ,[CodeValue]
				   ,[InterestCalculationType]
				   ,[IsCustomizable]
				   ,[IsActive]
				   ,[InterestActivationOn]
				   ,[InterestActivationOnBs]
				   ,[SycInterestProvisioningInterestCalculationPeriodId]
				   ,[Remarks]				   
				   ,[CreatedBy]
				   ,[CreatedOn] 
				   ,DepositTypeInNepali
				   ,branch
				   )
		SELECT 		  
			 
			  CAST(GlSubHead AS NVARCHAR)--[DepositTypeCode]
			  ,GlSubName --[DepositTypeName]
			  ,CAST(GlSubInstNo AS INT) --[Duration]
			,'M' -- ,[DurationType]
			  ,CASE WHEN GlSubHead like '10401%' THEN 3
					WHEN GlSubHead LIKE '10402%' THEN 2
					WHEN GlSubHead LIKE '10403%' THEN 1
					WHEN GlSubHead LIKE '10404%' THEN 3
					 END --  ,[SycDepositCategoryId]
			  ,CAST(GlSubIntRate AS NUMERIC(18,2)) -- ,[InterestRate]
			  ,1	--   ,[SycInterestTypeId]/DAILY MINIMUM BALANCE			
			  ,CASE WHEN GlSubHead like '10401%' THEN 2
					WHEN GlSubHead LIKE '10402%' THEN 5
					WHEN GlSubHead LIKE '10403%' THEN 2
					WHEN GlSubHead LIKE '10404%' THEN 5
					 END	--  ,[SycInterestCalculationPeriodId]
			 ,5 --  ,[TaxRate]
			 ,0 --,[MinimumDepositForInterest]
		    ,CAST (GlSubMinBal AS NUMERIC(18,2)) --,[MininumDepositAmount]
			 ,CAST(GlSubMaxBal AS NUMERIC(18,2)) --  ,[MaximumDepositAmount]
			 ,0 -- ,[MinimumPerDayWithDrawal]
			 ,0 -- ,[MaxPerDayWithDrawal]
			 ,CAST(GlSubMinBal AS NUMERIC(18,2)) -- ,[MinimumBalance]
			 ,1 --  ,[Widthdrawal]
			 ,1 -- ,[Mandatory]
			 ,0 --  ,[CollectorCommission]
			 ,0 --  ,[CodeValue]
			 ,'D' --,[InterestCalculationType]
			 ,1 --  ,[IsCustomizable]
			 ,1 -- ,[IsActive]
			 ,CAST('1990-01-01' AS DATE) --   ,[InterestActivationOn]
			 ,'2046/09/17' --,[InterestActivationOnBs]
			 ,2 --,[SycInterestProvisioningInterestCalculationPeriodId]
			 ,CAST(GlSubHead AS NVARCHAR) --,[Remarks]
			 ,0 --,[CreatedBy]
			 ,GETDATE() -- ,[CreatedOn] 
			 ,'kkafdj'
			 ,'Beni branch'
		      
 FROM kamana.DBO.lastgledger WHERE CAST(keyfigg AS NVARCHAR)='104Deposit'
 

 


