use NexGenCoSysDBDev
---------------- SHARE NO UPDATE--------------------------------------------------
DECLARE @share AS NUMERIC(18,0)
DECLARE @OFFICENAME NVARCHAR(MAX)='BENI BRANCH'

SET @share=(select mastercodevalue from SycMasterCode where SycMasterCodeId=2)

UPDATE S SET S.ShareNoTo=@share,
			@share=s.ShareNo+@share
	FROM ShmShareAllotment AS S
	WHERE S.SharePurchaseAmount >0 and s.UsmOfficeId=(select usmofficeid from UsmOffice where OfficeName=@OFFICENAME)
 
 UPDATE S SET S.ShareNoFrom=S.ShareNoTo-S.ShareNo+1		
	FROM ShmShareAllotment AS S 
	WHERE S.SharePurchaseAmount >0
	and s.UsmOfficeId=(select usmofficeid from UsmOffice where OfficeName=@OFFICENAME)

---------------- SHARE CODE VALUE UPDATE--------------------------------------------------

UPDATE  SycMasterCode  SET MasterCodeValue=(CAST((SELECT max(ShareNoTo) FROM ShmShareAllotment ) AS BIGINT))
WHERE SycMasterCodeId=2
select * from NexGenCoSysDBDev..SycMasterCode
 
