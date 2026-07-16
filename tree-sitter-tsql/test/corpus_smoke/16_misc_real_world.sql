-- comment test
/* block
   comment */
USE MyDb;
GO
DROP TABLE IF EXISTS dbo.Stage;
CREATE VIEW dbo.vw_Active AS
SELECT Id, Name FROM dbo.Items WHERE IsActive = 1 AND Name IS NOT NULL;
GO
CREATE NONCLUSTERED INDEX IX_Items_Name ON dbo.Items (Name ASC) INCLUDE (Id);
GO
SELECT i.Id,
       ISNULL(i.Name, 'n/a') AS DisplayName,
       CONVERT(VARCHAR(10), i.CreatedAt, 120) AS CreatedDay
FROM dbo.Items i WITH (NOLOCK)
WHERE i.CategoryId NOT IN (SELECT CategoryId FROM dbo.Excluded)
  AND i.Name LIKE 'A%'
  AND EXISTS (SELECT 1 FROM dbo.Stock s WHERE s.ItemId = i.Id)
UNION ALL
SELECT 0, 'none', NULL;
GO
DECLARE @msg NVARCHAR(200) = N'total: ' + CAST(@@ROWCOUNT AS NVARCHAR(20));
IF @@ERROR <> 0
    RAISERROR('failed with %d', 16, 1, @@ERROR) WITH NOWAIT;
ELSE
    PRINT @msg;
GO
