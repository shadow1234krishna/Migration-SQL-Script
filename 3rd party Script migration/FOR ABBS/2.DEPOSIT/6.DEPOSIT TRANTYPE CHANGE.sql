USE NEXGENCOSYSDBDEV
DECLARE @OFFICENAME NVARCHAR(MAX)='Beni Branch'
update AcoTransaction set AcoTransactionTypeId= 3 where REFERENCE='INTR' and UsmOfficeId=(select UsmOfficeId from UsmOffice where OfficeName=@OFFICENAME)--FOR INTERSTTYPE
update AcoTransaction set AcoTransactionTypeId= 4 where REFERENCE='TAXP' and UsmOfficeId=(select UsmOfficeId from UsmOffice where OfficeName=@OFFICENAME)--FOR TAX TYPE

