WITH RecentOrders AS (
    SELECT CustomerID, COUNT(*) AS OrderCount
    FROM dbo.Orders
    WHERE OrderDate >= '2024-01-01'
    GROUP BY CustomerID
)
SELECT c.CustomerName, r.OrderCount
FROM RecentOrders r
JOIN dbo.Customers c ON c.CustomerID = r.CustomerID;
