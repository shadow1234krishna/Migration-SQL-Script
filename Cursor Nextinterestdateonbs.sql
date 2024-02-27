USE NexGenCoSysDBDev;

DECLARE @mamid NVARCHAR(50);
DECLARE @AccountNoToUpdate NVARCHAR(50);
DECLARE @NextInterestDateOnBs NVARCHAR(50);
DECLARE @SN BIGINT;


DECLARE mamid_cursor CURSOR FOR
SELECT MamAccountOpeningId FROM MamAccountOpening
WHERE AccountNo IN ('FD02Y-01-53', 'FD01Y-01-756', 'FD01Y-01-759', 'FD01Y-01-762', 'FD03Y-01-5'); -- update accountno 

OPEN mamid_cursor;

FETCH NEXT FROM mamid_cursor INTO @mamid;

WHILE @@FETCH_STATUS = 0
BEGIN
--temp table ------------------------------------------------------------------------------
    CREATE TABLE #temp (
        SN BIGINT IDENTITY(1,1) NOT NULL,		
        Interest numeric(18,2),		
        Tax numeric(18,2),		
        NetAmount numeric(18,2),
        InterestDateOnBs nvarchar(max),
        InterestDateOn date,
        DaysNo bigint,
        IsGenerated nvarchar(1)
    );

    -----insert into temp----------------------------------
    INSERT INTO #temp(SN, Interest, Tax, NetAmount, InterestDateOnBs, InterestDateOn, DaysNo, IsGenerated)
    EXEC [sp_5_43_GetFixedDepositSchedule] @mamid;

    -- Update NextInterestDateOnBs----------------------
    UPDATE ma
    SET ma.NextInterestDateOnBs = (
        SELECT r2.InterestDateOnBs 
        FROM #temp AS r2 
        WHERE r2.SN = (SELECT r3.SN + 1 FROM #temp AS r3 WHERE r3.InterestDateOnBs = ma.NextInterestDateOnBs)
    )
    FROM MamAccountOpening AS ma
    INNER JOIN #temp AS r ON ma.NextInterestDateOnBs = r.InterestDateOnBs
    WHERE ma.MamAccountOpeningid = @mamid;


    DROP TABLE #temp;

    FETCH NEXT FROM mamid_cursor INTO @mamid;
END

CLOSE mamid_cursor;
DEALLOCATE mamid_cursor;
