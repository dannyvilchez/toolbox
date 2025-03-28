/*
SQL Server:
Searches for a specific text string (e.g., table name, column name, or any identifier)
across various database objects (tables, views, procedures, functions, triggers, constraints).
Emulates the functionality of Redgate SQL Search using system views and metadata.
*/

DECLARE @SearchOnlyTables	CHAR(1)	 = 'n'
DECLARE @SearchOnlyProcs	CHAR(1)	 = 'Y'
DECLARE @TextSearch			VARCHAR(64) = '%' + 'revers' + '%'

--Optionally, limit by schema
DECLARE @SearchLimitedSchemas	CHAR(1)	 = 'n'
DECLARE @SchemaList				TABLE (SchemaName VARCHAR(50))
INSERT INTO @SchemaList (SchemaName)
	--SELECT 'dbo'		UNION ALL
	SELECT '<schema-name>'	UNION ALL
	SELECT '<schema-name>'

--Find Tables with a specific textstring in a Table Name
SELECT DISTINCT
	 'Table'		AS ObjectType
	,10				AS SortOrder
	,t.TABLE_SCHEMA AS SchemaName
	,t.TABLE_NAME	AS ObjectName
	,''	AS ColumnName	
	,@@SERVERNAME	AS ServerName
	,DB_NAME()		AS DBName
FROM    INFORMATION_SCHEMA.TABLES t	
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas	= 'N'
	OR sl.SchemaName			= t.TABLE_SCHEMA
WHERE	t.TABLE_NAME NOT LIKE '%_20%'
AND		t.TABLE_TYPE = 'BASE TABLE'
AND		t.TABLE_NAME LIKE @TextSearch
AND		@SearchOnlyProcs <> 'Y'

UNION ALL

--Find Tables with a specific textstring in a columnname
SELECT DISTINCT
	 'Table'		AS ObjectType
	,10				AS SortOrder
	,t.TABLE_SCHEMA AS SchemaName
	,t.TABLE_NAME	AS ObjectName
	,c.COLUMN_NAME	AS ColumnName	
	,@@SERVERNAME	AS ServerName
	,DB_NAME()		AS DBName
FROM    INFORMATION_SCHEMA.TABLES t	
INNER JOIN INFORMATION_SCHEMA.COLUMNS c
	ON	t.TABLE_NAME = c.TABLE_NAME
    AND c.COLUMN_NAME LIKE @TextSearch
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas = 'N'
	OR sl.SchemaName = t.TABLE_SCHEMA
WHERE	t.TABLE_NAME NOT LIKE '%_20%'
AND		t.TABLE_TYPE = 'BASE TABLE'
AND		@SearchOnlyProcs <> 'Y'

UNION ALL

--Find Views with a specific textstring in View Name. 
SELECT DISTINCT
	'View'		AS ObjectType
	,50			AS SortOrder
	,t.TABLE_SCHEMA AS SchemaName
	,t.TABLE_NAME	AS ObjectName
	,''				AS ColumnName	
	,@@SERVERNAME	AS ServerName
	,DB_NAME()		AS DBName
FROM    INFORMATION_SCHEMA.TABLES t	
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas = 'N'
	OR sl.SchemaName = t.TABLE_SCHEMA
WHERE	t.TABLE_NAME NOT LIKE '%_20%'
AND		t.TABLE_TYPE = 'VIEW'
AND		t.TABLE_NAME LIKE @TextSearch
AND		@SearchOnlyTables <> 'Y'
AND		@SearchOnlyProcs <> 'Y'
  
UNION ALL

--Find Views with a specific textstring in Column Name. 
SELECT DISTINCT
	'View'		AS ObjectType
	,50			AS SortOrder
	,t.TABLE_SCHEMA AS SchemaName
	,t.TABLE_NAME	AS ObjectName
	,c.COLUMN_NAME	AS ColumnName	
	,@@SERVERNAME	AS ServerName
	,DB_NAME()		AS DBName
FROM    INFORMATION_SCHEMA.TABLES t	
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas = 'N'
	OR sl.SchemaName = t.TABLE_SCHEMA
INNER JOIN INFORMATION_SCHEMA.COLUMNS c
	ON	t.TABLE_NAME = c.TABLE_NAME
    AND c.COLUMN_NAME LIKE @TextSearch
WHERE	t.TABLE_NAME NOT LIKE '%_20%'
AND		t.TABLE_TYPE = 'VIEW'
AND		@SearchOnlyTables <> 'Y'
AND		@SearchOnlyProcs <> 'Y'
  
UNION ALL

--Find Views with a specific textstring in the actual CREATE VIEW script. 
SELECT DISTINCT
	'View'		AS ObjectType
	,50			AS SortOrder
	,t.TABLE_SCHEMA AS SchemaName
	,t.TABLE_NAME	AS ObjectName
	,''				AS ColumnName	
	,@@SERVERNAME	AS ServerName
	,DB_NAME()		AS DBName
FROM    INFORMATION_SCHEMA.TABLES t	
INNER JOIN sys.objects o
	ON 	t.TABLE_NAME = o.name
	AND	o.type = 'V'
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas = 'N'
	OR sl.SchemaName = t.TABLE_SCHEMA
INNER JOIN sys.sql_modules c
	ON	c.object_id = o.object_id
	AND c.definition LIKE @TextSearch
WHERE	t.TABLE_NAME NOT LIKE '%_20%'
AND		@SearchOnlyTables <> 'Y'
AND		@SearchOnlyProcs <> 'Y'

UNION ALL
--Find Stored Procedures with a specific textstring
--10/04/2011 We can NOT use the INFORMATION_SCHEMA views because the search doesn't work past 4000 bytes in it!!!!  SKF
SELECT DISTINCT
	'Proc'			AS ObjectType
	,60				AS SortOrder
	,s.name			AS SchemaName
	,p.NAME			AS ObjectName
	,''				AS ColumnName
	,@@SERVERNAME	AS ServerName
	,DB_NAME()		AS DBName
FROM    sys.sql_modules c
INNER JOIN sys.procedures p
	ON	p.object_id = c.OBJECT_ID
INNER JOIN SYS.schemas s
	ON S.schema_id = p.schema_id
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas = 'N'
	OR sl.SchemaName = s.name
WHERE   c.definition LIKE @TextSearch
AND p.name NOT LIKE '%msmerge%' -- Exclude merge replication procedures
AND p.name NOT LIKE '%_20%'
AND		@SearchOnlyTables <> 'Y'

UNION ALL

--Find Functions with a specific textstring.   
SELECT DISTINCT
	'Function'  AS ObjectType
	,40			AS SortOrder
	,s.name		 AS SchemaName
	,t.name		AS ObjectName
	,''				AS ColumnName
	,@@SERVERNAME	AS ServerName
	,DB_NAME()		AS DBName
FROM	sys.objects t
INNER JOIN sys.sql_modules c
	ON	t.object_id = c.object_id
INNER JOIN SYS.schemas S
	ON S.schema_id = t.schema_id
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas = 'N'
	OR sl.SchemaName = s.name
WHERE t.type IN ('FS','FT','TF','FN')	
AND c.definition LIKE @TextSearch
AND t.name NOT LIKE '%_20%'
AND	@SearchOnlyTables <> 'Y'
AND		@SearchOnlyProcs <> 'Y'

UNION ALL

--Find Triggers with a specific textstring.   
SELECT DISTINCT
	'Trigger'  AS ObjectType
	,30			AS SortOrder
	,s.name		AS SchemaName
	,t.name		AS ObjectName
	,''				AS ColumnName
	,@@SERVERNAME	AS ServerName
	,DB_Name()		AS DBName
FROM	sys.triggers t
INNER JOIN sys.objects o
	ON o.object_id = t.object_id
INNER JOIN sys.sql_modules c
	ON	t.object_id = c.object_id
	AND c.definition LIKE @TextSearch
INNER JOIN SYS.schemas s
	ON s.schema_id = o.schema_id
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas = 'N'
	OR sl.SchemaName = s.name
WHERE t.name NOT LIKE '%_20%'
AND		@SearchOnlyTables <> 'Y'
AND		@SearchOnlyProcs <> 'Y'

UNION ALL

--Find Constraints with a specific textstring.     This ONLY works if the string is part of the name.
SELECT DISTINCT
	 CASE t.type WHEN 'C'	THEN 'Check'
							ELSE 'Default'	END  AS ObjectType
	,20				AS SortOrder
	,s.name			AS SchemaName
	,t.name			AS ObjectName
	,''				AS ColumnName
	,@@SERVERNAME	AS ServerName
	,DB_Name()		AS DBName
FROM sys.objects t 
INNER JOIN SYS.schemas s
	ON S.schema_id = t.schema_id
INNER JOIN @SchemaList sl
	ON @SearchLimitedSchemas = 'N'
	OR sl.SchemaName = s.name
WHERE	t.type IN ('C','D')	
AND		t.name LIKE @TextSearch
AND		t.name NOT LIKE '%_20%'
AND		@SearchOnlyTables <> 'Y'
AND		@SearchOnlyProcs <> 'Y'


ORDER BY SortOrder, ObjectName, ColumnName
--ORDER BY SortOrder, ColumnName, ObjectName
--ORDER BY ColumnName, SortOrder, ObjectName
--ORDER BY SchemaName, SortOrder, ObjectName, ColumnName


