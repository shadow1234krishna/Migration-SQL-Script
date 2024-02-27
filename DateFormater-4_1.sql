--Date Formater

select CtzDate,* from [pearlsdb_sarwangini].[dbo].[All_Members]
where LEN(DOB)<10;

--ALTER TABLE [pearlsdb_sarwangini].[dbo].[All_Members]
--DROP COLUMN New_CtzDate;


-------------------------------------MAIN SCRIPT---------------------------------------------------------
BEGIN TRANSACTION 

--Declaring queries
DECLARE @sqlQuery Nvarchar(MAX),@sqlNewDateColWithPreDate nvarchar(Max),@sqlCreateTempTable nvarchar(MAX), @sqlUpdateTempTable nvarchar(MAX), 
@sqlCreateTemp2Table nvarchar(MAX), @sqlUpdateTemp2Table  nvarchar(MAX);
DECLARE @TableName nvarchar(100), @DateToUpdate nvarchar(50), @New_Date nvarchar(50), @CommonId nvarchar(MAX),@YearPrefix nvarchar(50);

SET @TableName = '[pearlsdb_sarwangini].[dbo].[All_Members]'; --Your Table Name
SET @DateToUpdate = 'DOB'; --Your Date Column to Update
SET @New_Date = 'New_DOB'; --Your New Date Column Name
SET @CommonId = 'MSN'; --Your Common Column (PK)
SET @YearPrefix = '20'; --Running year perfix like for '2080 BS' "20" is used as YearPrefix or can be added as per the requirement
SET @sqlQuery = 'SELECT * FROM' + @TableName+';
				
				--Added new column New_AccountOpenDate
				ALTER TABLE'+@TableName+'ADD '+@New_Date+' nvarchar(50);

				--Update the ''.'' to ''/''
				UPDATE'+@TableName+'SET '+ @DateToUpdate+'  = REPLACE(' +@DateToUpdate+ ',''.'',''/'');

				--Update the ''-'' to ''/''
				UPDATE'+@TableName+'SET '+ @DateToUpdate+'  = REPLACE(' +@DateToUpdate+ ',''-'',''/'');

				--Update len having less then 8 to null
				UPDATE'+@TableName+'SET '+ @DateToUpdate+'  = null where LEN('+@DateToUpdate+')<8;

				--Update len having less then 8 to null
				UPDATE'+@TableName+'SET '+ @DateToUpdate+'  = null where CtzDate like ''%[a-z]%'';
				';
--Update New_AccountOpenDate with Previous date
SET @sqlNewDateColWithPreDate = 'UPDATE'+@TableName+' SET '+@New_Date+' = '+@DateToUpdate+'';

------------------------Less than 10-----------------------------------------
--Creating #temp1 table --Adding Required Fields
SET @sqlCreateTempTable = 'SELECT * INTO ##temp1 FROM ' + @TableName + ' WHERE LEN(' + @DateToUpdate + ') < 10;'+
						'ALTER TABLE ##temp1 ADD extracted_year  nvarchar(10), extracted_month  nvarchar(10), extracted_day  nvarchar(10);'

--updating #temp1 table
SET @sqlUpdateTempTable = 'UPDATE ##temp1
    SET extracted_year = LEFT('+@DateToUpdate+',CHARINDEX(''/'','+@DateToUpdate+')-1), --extracted_year
	extracted_month  = SUBSTRING('+@DateToUpdate+',CHARINDEX(''/'','+@DateToUpdate+'),3), -- extracted_month
	extracted_day = RIGHT('+@DateToUpdate+',CHARINDEX(''/'',REVERSE ('+@DateToUpdate+'))); -- extracted_day; 
	
	--Removing unwanted symboles
    UPDATE ##temp1
    SET extracted_year = REPLACE(extracted_year, ''/'', ''''),
        extracted_month = REPLACE(extracted_month, ''/'', ''''),
        extracted_day = REPLACE(extracted_day, ''/'', '''');

	--Coveriting to Bigint
    UPDATE ##temp1
    SET extracted_year = cast(extracted_year as bigint),
        extracted_month = cast(extracted_month as bigint),
        extracted_day = cast(extracted_day as bigint);

	--Working on Year
	UPDATE ##temp1
	SET extracted_year = STUFF (extracted_year,1,0,'''+@YearPrefix+''') where LEN(extracted_year)<4;

	--Working on extrated month
	UPDATE ##temp1
	SET extracted_month = STUff(extracted_month,1,0,''0'') where len(extracted_month)<2;

	--Working on extrated days
	UPDATE ##temp1
	SET extracted_day = STUff(extracted_day,1,0,''0'') where len(extracted_day)<2;

	--Updating New_AccountOpenDate of ##temp1 table
	UPDATE ##temp1
	SET '+@New_Date+' = extracted_year+''/''+extracted_month+''/''+extracted_day;

	UPDATE A
	SET A.'+@New_Date+' = t1.'+@New_Date+'
	FROM'+@TableName+' A
	INNER JOIN ##temp1 t1
	on A.'+@CommonId+' = t1.'+@CommonId+';	
	';

---------------x-----------Less than 10--------------x---------------------------
---------------Greather than 10--------------------------------------
--Creating #temp2 table --Adding Required Fields
SET @sqlCreateTemp2Table = 'SELECT * INTO ##temp2 FROM ' + @TableName + ' WHERE LEN(' + @DateToUpdate + ') > 10;'+
						'ALTER TABLE ##temp2 ADD extracted_year  nvarchar(10), extracted_month  nvarchar(10), extracted_day  nvarchar(10);'

--updating #temp2 table
SET @sqlUpdateTemp2Table = 'UPDATE ##temp2
    SET extracted_year = LEFT('+@DateToUpdate+',CHARINDEX(''/'','+@DateToUpdate+')-1), --extracted_year
	extracted_month  = SUBSTRING('+@DateToUpdate+',CHARINDEX(''/'','+@DateToUpdate+'),3), -- extracted_month
	extracted_day = RIGHT('+@DateToUpdate+',CHARINDEX(''/'',REVERSE ('+@DateToUpdate+'))); -- extracted_day; 
	
	--Removing unwanted symboles
    UPDATE ##temp2
    SET extracted_year = REPLACE(extracted_year, ''/'', ''''),
        extracted_month = REPLACE(extracted_month, ''/'', ''''),
        extracted_day = REPLACE(extracted_day, ''/'', '''');

	--Coveriting to Bigint
    UPDATE ##temp2
    SET extracted_year = cast(extracted_year as bigint),
        extracted_month = cast(extracted_month as bigint),
        extracted_day = cast(extracted_day as bigint);

	--Working on Year
	UPDATE ##temp2
	SET extracted_year = STUFF (extracted_year,1,0,'''+@YearPrefix+''') where LEN(extracted_year)<4;

	--Working on extrated month
	UPDATE ##temp2
	SET extracted_month = STUff(extracted_month,1,0,''0'') where len(extracted_month)<2;

	--Working on extrated days
	UPDATE ##temp2
	SET extracted_day = STUff(extracted_day,1,0,''0'') where len(extracted_day)<2;

	--Updating New_AccountOpenDate of ##temp2 table
	UPDATE ##temp2
	SET '+@New_Date+' = extracted_year+''/''+extracted_month+''/''+extracted_day;

	UPDATE A
	SET A.'+@New_Date+' = t1.'+@New_Date+'
	FROM'+@TableName+' A
	INNER JOIN ##temp2 t1
	on A.'+@CommonId+' = t1.'+@CommonId+';	

	SELECT * FROM' + @TableName+';

	--Destorying Temp tables
	drop table ##temp1;
	drop table ##temp2;
	';

---------x------Greather than 10-----------x---------------------------

BEGIN TRY
    EXEC sp_executesql @sqlQuery;
	EXEC sp_executesql @sqlNewDateColWithPreDate;
	EXEC sp_executesql @sqlCreateTempTable;
	EXEC sp_executesql @sqlCreateTemp2Table;
	EXEC sp_executesql @sqlUpdateTempTable;
	EXEC sp_executesql @sqlUpdateTemp2Table;
END TRY
BEGIN CATCH
    SELECT 
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_STATE() AS ErrorState,
		ERROR_LINE() AS ErrorLine;
END CATCH
COMMIT;
-----------------------x--------------MAIN SCRIPT----------------------x----------------------------------------------

/*
select * from ##temp1;
select * from ##temp2;
drop table ##temp1;
drop table ##temp2; 

SELECT * FROM [pearlsdb_sarwangini].[dbo].[All_Members] A
INNER JOIN ##temp1 t1
on A.S#N = t1.S#N;
*/


