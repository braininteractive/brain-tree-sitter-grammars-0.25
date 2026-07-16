MERGE dbo.TargetProducts AS t
USING dbo.SourceProducts AS s
ON t.ProductID = s.ProductID
WHEN MATCHED THEN
    UPDATE SET t.UnitPrice = s.UnitPrice
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName) VALUES (s.ProductID, s.ProductName)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
