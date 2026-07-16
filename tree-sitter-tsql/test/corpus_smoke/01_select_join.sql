SELECT o.OrderID, c.CustomerName, o.OrderDate
FROM dbo.Orders o
INNER JOIN dbo.Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN dbo.Shippers s ON o.ShipperID = s.ShipperID
WHERE o.OrderDate >= '2024-01-01' AND c.Country = 'USA'
ORDER BY o.OrderDate DESC;
