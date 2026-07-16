EXEC dbo.usp_GetEmployeesByDept @DepartmentID = 5, @MinSalary = 50000;
EXECUTE sp_help 'dbo.Employees';
