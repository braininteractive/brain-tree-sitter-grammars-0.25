SELECT TOP (10)
    CustomerID,
    SUM(TotalDue) AS TotalSpend,
    ROW_NUMBER() OVER (ORDER BY SUM(TotalDue) DESC) AS Rank,
    CASE WHEN SUM(TotalDue) > 10000 THEN 'Gold' ELSE 'Standard' END AS Tier
FROM Sales.SalesOrderHeader
WHERE Status = 5
GROUP BY CustomerID
HAVING COUNT(*) > 3
ORDER BY TotalSpend DESC;
