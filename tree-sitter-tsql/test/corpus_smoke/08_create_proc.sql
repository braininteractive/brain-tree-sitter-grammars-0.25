CREATE PROCEDURE dbo.usp_GetEmployeesByDept
    @DepartmentID INT,
    @MinSalary DECIMAL(18,2) = 0,
    @Count INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT EmployeeID, FirstName, LastName
    FROM dbo.Employees
    WHERE DepartmentID = @DepartmentID AND Salary >= @MinSalary;
    SET @Count = @@ROWCOUNT;
END
