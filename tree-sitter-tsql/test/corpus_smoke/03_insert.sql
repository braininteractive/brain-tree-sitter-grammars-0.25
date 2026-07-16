INSERT INTO dbo.Products (ProductName, UnitPrice, Discontinued)
VALUES ('Widget', 9.99, 0), ('Gadget', 19.99, 1);

INSERT INTO dbo.ProductArchive (ProductID, ProductName)
SELECT ProductID, ProductName FROM dbo.Products WHERE Discontinued = 1;
