IF EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderID = 10248)
BEGIN
    PRINT 'Order exists';
END
ELSE
BEGIN
    PRINT 'Order not found';
END
