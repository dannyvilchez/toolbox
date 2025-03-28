/*
SQL Server:
Executes the system stored procedure sp_help on a remote linked server
to retrieve metadata about the specified table.
*/

EXEC [<linked-server-name>].[<db-name>].[<schema-name>].sp_help 'table-name'