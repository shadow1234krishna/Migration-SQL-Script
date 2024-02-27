use NexGenCoSysDBDev

		INSERT INTO NexGenCoSysDBDev.dbo.SycSalutation SELECT DISTINCT(CusTitle),0,GETDATE(),NULL,NULL FROM Finact.dbo.fincif WHERE CusTitle IS NOT NULL
		INSERT INTO NexGenCoSysDBDev.dbo.SycSalutation VALUES('-',0,GETDATE(),NULL,NULL)

DELETE FROM SycNationality 

		INSERT INTO NexGenCoSysDBDev.dbo.SycNationality VALUES('-',0,GETDATE(),NULL,NULL)
		INSERT INTO NexGenCoSysDBDev.dbo.SycNationality VALUES('Nepal',0,GETDATE(),NULL,NULL)
DELETE FROM SycOccupation 

		INSERT INTO NexGenCoSysDBDev.dbo.SycOccupation SELECT DISTINCT(ISNULL(cusAccupetion,'')),0,GETDATE(),NULL,NULL FROM Finact.dbo.fincif WHERE cusAccupetion IS NOT NULL
	    INSERT INTO NexGenCoSysDBDev.dbo.SycOccupation VALUES('-',0,GETDATE(),NULL,NULL)
	    
DELETE FROM SycCaste 

		INSERT INTO NexGenCoSysDBDev.dbo.SycCaste SELECT DISTINCT(ISNULL(CusLName,'')),0,GETDATE(),NULL,NULL FROM Finact.dbo.fincif WHERE CusLName IS NOT NULL

DELETE FROM SycRelation 

		INSERT INTO NexGenCoSysDBDev.dbo.SycRelation SELECT DISTINCT(NRelation),0,GETDATE(),NULL,NULL FROM Finact.DBO.Nominee WHERE NRelation IS NOT NULL	
		INSERT INTO NexGenCoSysDBDev.dbo.SycRelation VALUES('-',0,GETDATE(),NULL,NULL)

DELETE FROM SycReligion 

		INSERT INTO NexGenCoSysDBDev.dbo.SycReligion VALUES('-',0,GETDATE(),NULL,NULL)

DELETE FROM SycMaritualStatus 

		INSERT INTO NexGenCoSysDBDev.dbo.SycMaritualStatus SELECT DISTINCT(CusMarital),0,GETDATE(),NULL,NULL FROM Finact.dbo.fincif WHERE CusMarital IS NOT NULL
		INSERT INTO NexGenCoSysDBDev.dbo.SycMaritualStatus VALUES('-',0,GETDATE(),NULL,NULL)

