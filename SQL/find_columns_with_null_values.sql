/*
SQL Server:
Generates and executes dynamic SQL to check each column in a specified table 
for NULL values. Outputs the names of columns that contain NULLs.
*/

DECLARE @TableName NVARCHAR(MAX) = '<table-name>';
DECLARE @SchemaName NVARCHAR(MAX) = '<schema-name>';

DECLARE @SQL NVARCHAR(MAX);
SET @SQL = '';

SELECT @SQL = CONCAT(@SQL, 
'SELECT ''', COLUMN_NAME, ''' AS ColumnName
 FROM ', @SchemaName, '.', @TableName, '
 WHERE [', COLUMN_NAME, '] IS NULL
 UNION ')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName AND TABLE_SCHEMA = @SchemaName;


-- Removes the trailing 'UNION'
IF LEN(@SQL) > 0
    SET @SQL = LEFT(@SQL, LEN(@SQL) - 6);


---- If you need to verify the dynamic SQL
--PRINT @SQL;


-- Execute the dynamic SQL
IF LEN(@SQL) > 0
    EXEC sp_executesql @SQL;
ELSE
    PRINT 'No NULL values found or table does not exist.';