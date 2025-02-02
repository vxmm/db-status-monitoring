USE [master]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CheckAllDatabaseStatus] AS
BEGIN
    DECLARE @dbName NVARCHAR(1000);
    DECLARE @outputFile NVARCHAR(1000) = 'C:\logs.txt';

-- Cursor to iterate through all databases

    DECLARE cursor_databases CURSOR FOR
    SELECT name
    FROM sys.databases;
    OPEN cursor_databases;
    FETCH NEXT FROM cursor_databases INTO @dbName;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @sql NVARCHAR(1000) = 'USE ' + @dbName + ';' +
            'SELECT name FROM sys.databases WHERE name = ''' + @dbName + ''' AND state_desc = ''ONLINE''';
            EXEC master.dbo.sp_executesql @sql
            BEGIN
                DECLARE @logText NVARCHAR(1000) = CONCAT('Database ', @dbName, ' is ONLINE');
                DECLARE @cmd NVARCHAR(1000);
                SET @cmd = CONCAT('ECHO ', @logText, '>>' + @outputFile);
                EXEC master.dbo.xp_cmdshell @cmd;
            END;
        FETCH NEXT FROM cursor_databases INTO @dbName;
        END;

    CLOSE cursor_databases;
    DEALLOCATE cursor_databases;
END;