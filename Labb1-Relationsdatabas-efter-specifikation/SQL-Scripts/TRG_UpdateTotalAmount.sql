CREATE TRIGGER trg_UpdateTotalAmount
ON BooksOrders
AFTER INSERT, UPDATE, DELETE
AS

BEGIN
    UPDATE o
    SET o.TotalAmount = 
	(
        SELECT 
			SUM(b.Price * bo.Quantity)
        FROM 
			Books b
			JOIN BooksOrders bo 
			ON b.ISBN13 = bo.ISBN13
        WHERE 
			bo.OrderID = o.Id
    )
    FROM 
		Orders o
    WHERE 
		o.Id IN (SELECT DISTINCT OrderID FROM inserted);

    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        UPDATE o
        SET o.TotalAmount = 
		(
            SELECT 
				SUM(b.Price * bo.Quantity)
            FROM 
				Books b
				JOIN BooksOrders bo ON b.ISBN13 = bo.ISBN13
            WHERE 
				bo.OrderID = o.Id
        )
        FROM 
			Orders o
        WHERE 
			o.Id IN (SELECT DISTINCT OrderId FROM deleted);
    END
END;