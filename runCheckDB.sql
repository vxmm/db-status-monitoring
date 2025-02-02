USE [master]
GO
DECLARE	@return_value int
EXEC	@return_value = [dbo].[CheckAllDatabaseStatus]
SELECT	'Return Value' = @return_value
GO