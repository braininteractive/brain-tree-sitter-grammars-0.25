USE AdventureWorks;
GO
SELECT COUNT(*) FROM dbo.Orders;
GO 2
EXEC dbo.usp_RebuildIndexes;
GO
