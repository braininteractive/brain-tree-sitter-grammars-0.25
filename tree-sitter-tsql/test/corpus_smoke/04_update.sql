UPDATE dbo.Products
SET UnitPrice = UnitPrice * 1.10, ModifiedDate = GETDATE()
WHERE CategoryID = 3;
