SELECT * FROM (SELECT Year, Amount FROM Sales) s
PIVOT (SUM(Amount) FOR Year IN ([2023], [2024])) p;

SELECT o.Id, x.Val
FROM dbo.Orders o
CROSS APPLY dbo.fn_GetLines(o.Id) x;
