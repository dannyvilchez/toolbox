/*
SQL Server:
Retrieves the column names and their ordinal positions 
for a specific table in the given schema using the INFORMATION_SCHEMA view.
*/

SELECT 
    COLUMN_NAME,
    ORDINAL_POSITION
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_SCHEMA = '<schema-name>' 
    AND TABLE_NAME = '<table-name>'
ORDER BY 
    ORDINAL_POSITION;
