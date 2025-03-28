/*
SQL Server:
Retrieves column names, data types, precision, and size 
for a specified table using the INFORMATION_SCHEMA.COLUMNS view.
*/

SELECT COLUMN_NAME
      ,DATA_TYPE
	    ,CAST(NUMERIC_PRECISION AS VARCHAR(10)) + ',' + CAST(NUMERIC_SCALE AS VARCHAR(10)) AS [PRECISION]
	    ,CHARACTER_MAXIMUM_LENGTH AS SIZE
  FROM INFORMATION_SCHEMA.COLUMNS
 WHERE TABLE_NAME = 'table_name'
   AND TABLE_SCHEMA = 'schema_name';