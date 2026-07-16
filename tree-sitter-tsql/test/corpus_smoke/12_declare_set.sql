DECLARE @Name NVARCHAR(100), @Total DECIMAL(18,2) = 0;
DECLARE @Today DATE = GETDATE();
SET @Name = N'Contoso';
SET @Total = @Total + 42.50;
SELECT @Name AS CompanyName, @Total AS Total;
