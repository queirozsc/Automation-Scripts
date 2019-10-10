/* CREATE TEMP TABLE FOR SPACEUSED STORED PROCEDURE RESULTS */
CREATE TABLE #SPACEUSED (
    TABLENAME sysname
	, NUMROWS BIGINT
	, RESERVEDSPACE VARCHAR(50)
	, DATASPACE VARCHAR(50)
	, INDEXSIZE VARCHAR(50)
	, UNUSEDSPACE VARCHAR(50)
);

DECLARE @TABLENAME VARCHAR(50);
DECLARE CUR_TABLES CURSOR FOR
    SELECT T.NAME AS TABLE_NAME
        --, SCHEMA_NAME(T.SCHEMA_ID) AS SCHEMA_NAME
        --, T.CREATE_DATE
        --, T.MODIFY_DATE
    FROM SYS.TABLES T
    ORDER BY TABLE_NAME;

OPEN CUR_TABLES

FETCH NEXT FROM CUR_TABLES INTO @TABLENAME
WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO #SPACEUSED (TABLENAME, NUMROWS, RESERVEDSPACE, DATASPACE, INDEXSIZE, UNUSEDSPACE)
    EXECUTE sp_spaceused @TABLENAME;
    FETCH NEXT FROM CUR_TABLES INTO @TABLENAME;
END

CLOSE CUR_TABLES
DEALLOCATE CUR_TABLES

SELECT * FROM #SPACEUSED ORDER BY NUMROWS DESC