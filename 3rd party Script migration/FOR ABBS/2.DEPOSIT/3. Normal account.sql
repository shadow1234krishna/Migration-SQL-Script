use NexGenCoSysDBDev
DECLARE @OFFICENAME NVARCHAR(MAX)='Beni Branch'

--go
--alter table acotransaction 
--add REFERENCE NVARCHAR(25)
--GO
--ALTER TABLE ACOTRANSACTION
--ADD TRANNO NVARCHAR(25)
--GO

INSERT INTO   [AcoTransaction]
           ([MemMemberRegistrationId]
           ,[MamAccountOpeningId]          
           ,[AcoTransactionTypeId]          
           ,[HurCollectorId]
           ,[CashReceived]
           ,[CashWithdrawl]                     
           ,[TransactionNumber]
           ,[TransactionOn]
           ,[TransactionOnBs]
           ,[UsmOfficeId]
           ,[IsPosted]
           ,[AcoVoucherId]
           ,[AcoReverseVoucherId]
           ,[Description]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[IsEdited]
           ,[IsActive]
           ,[IsPayable]
           ,[REFERENCE]
           ,[TRANNO]
           )
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM MamAccountOpening  WHERE AccountNo = AcctNo AND UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
	  , (SELECT TOP 1 MamAccountOpeningId FROM MamAccountOpening WHERE AccountNo = AcctNo AND UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))	 
	  ,1  --acotranstypeid
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)--HURCOLLECTOR	  
      ,TranAmount  --cashreceived
	  ,NULL--CASHWITHDRAWL	
      ,0    --TRANSACTIONNUMBER
       ,dbo.ConvertDateNepaliToEnglish(nepTranDate)--TRANSACTIONON
      ,nepTranDate--TRANSACTIONONBS
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice WHERE OfficeName=@OFFICENAME )--USMOFFICEID
      ,1 --ISPOSTED
      ,NULL --ACOVOUCHERID
      ,NULL --ACOREVERSEVOUCHERID     
      ,[DESCRIPTION]--DESCRIPTION
      ,0 --CREATEDBY
      ,GETDATE() --CREATEDON
      ,0 --ISEDITED
      ,1 --ISACTIVE
      ,0 --ISPAYABLE
      ,CAST(Typeoftranname AS NVARCHAR)
      ,TranNo
   FROM kamana..[transaction] WHERE AcctNo IN (SELECT CAST(Remarks AS nvarchar)
   FROM NexGenCoSysDBDev..MamAccountOpening where CAST(Remarks AS nvarchar) like '10403%' AND UsmOfficeId=(SELECT UsmOfficeId FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
   AND TranAmount!=0 and 
   TypeOfTran IN ('01','03','05','07','09','11','22','24','43','41','45','51','61','65','69','78','80','82','94') 


   --status 50 tranmode 2 INTR


--CCRT   cash adjustment
--CDEP   cash deposit
--INTR   interest 
--JDEP   share dividend to account
--OPEN   account open 
--XWDL  error// correction of transaction sqeuence

  




INSERT INTO   [AcoTransaction]
           ([MemMemberRegistrationId]
           ,[MamAccountOpeningId]          
           ,[AcoTransactionTypeId]          
           ,[HurCollectorId]
           ,[CashReceived]
           ,[CashWithdrawl]                     
           ,[TransactionNumber]
           ,[TransactionOn]
           ,[TransactionOnBs]
           ,[UsmOfficeId]
           ,[IsPosted]
           ,[AcoVoucherId]
           ,[AcoReverseVoucherId]
           ,[Description]
           ,[CreatedBy]
           ,[CreatedOn]
           ,[IsEdited]
           ,[IsActive]
           ,[IsPayable]
           ,[REFERENCE]
           ,[TRANNO]
           )
           
SELECT (SELECT TOP 1 MemMemberRegistrationId FROM MamAccountOpening  WHERE AccountNo = AcctNo AND UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))
	  , (SELECT TOP 1 MamAccountOpeningId FROM MamAccountOpening WHERE AccountNo = AcctNo AND UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME))	 
	  ,2		--acotransactiontypeid
	  ,(SELECT TOP 1 HurCollectorId FROM HurCollector)	  
      ,NULL
	  ,TranAmount  --cashwithdrawl
      ,0      
      ,dbo.ConvertDateNepaliToEnglish(nepTranDate)
      ,nepTranDate
      ,(SELECT TOP 1 UsmOfficeId FROM UsmOffice where OfficeName=@OFFICENAME)
      ,1
      ,NULL
      ,NULL      
      ,[DESCRIPTION]
      ,0
      ,GETDATE()
      ,0
      ,1
      ,0
      ,CAST(Typeoftranname AS NVARCHAR)
      ,TranNo
	FROM kamana..[transaction] WHERE AcctNo IN (SELECT CAST(Remarks AS nvarchar) FROM 
	 NexGenCoSysDBDev..MamAccountOpening where CAST(Remarks AS nvarchar) like '10403%' AND UsmOfficeId=(SELECT USMOFFICEID FROM USMOFFICE WHERE OfficeName=@OFFICENAME)) 
	AND TypeOfTran IN ('02','04','08','12','21','23','25','44','46','66','64','68','70','77','79','81')
	and TranAmount!=0





--CCHQ  cash withdrawl self
--CLOS  account close
--CWDL  cash withdrawl
--JCHQ  cash withdrawl bank
--JWDL  share withdrawl, advertisement, loan exp and renew,  
--TAXP  tax deduction 
--XDEP error adjustment, cheque refund




