DELETE FROM dbo.OrderDetails WHERE OrderID = 10248;
DELETE TOP (100) FROM dbo.AuditLog WHERE LogDate < '2020-01-01';
