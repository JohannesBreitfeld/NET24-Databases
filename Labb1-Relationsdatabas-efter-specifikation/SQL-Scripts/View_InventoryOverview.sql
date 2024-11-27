CREATE VIEW InventoryOverview AS

SELECT
	b.ISBN13 AS ISBN,
	b.Title	AS Title,
	-- In stock store 1
	(SELECT 
		ISNULL(SUM(inv.Quantity), 0) 
	FROM 
		Inventories inv 
	WHERE 
		inv.ISBN13 = b.ISBN13 AND inv.StoreId = 1) 
	AS [In stock store 1],
	--Availble store 1
    (SELECT 
		ISNULL(SUM(inv.Quantity), 0)
	FROM 
		Inventories inv
	WHERE 
		inv.ISBN13 = b.ISBN13
		AND inv.StoreId = 1) - 
	(SELECT 
		ISNULL(SUM(bo.Quantity), 0)
	FROM 
		BooksOrders bo
		JOIN Orders o 
		ON bo.OrderID = o.Id
	WHERE 
		bo.ISBN13 = b.ISBN13 
		AND o.StoreId = 1 
		AND o.Status = 1) 
	AS [Available Store 1],
	--In stock store 2
	(SELECT 
		ISNULL(SUM(inv.Quantity), 0) 
	FROM 
		Inventories inv 
	WHERE 
		inv.ISBN13 = b.ISBN13 
		AND inv.StoreId = 2) 
	AS [In stock store 2],
	--Available store 2
    (SELECT 
		ISNULL(SUM(inv.Quantity), 0)
	FROM 
		Inventories inv
	WHERE 
		inv.ISBN13 = b.ISBN13
		AND inv.StoreId = 2) - 
	(SELECT 
		ISNULL(SUM(bo.Quantity), 0)
	FROM 
		BooksOrders bo
		JOIN Orders o 
		ON bo.OrderID = o.Id
	WHERE 
		bo.ISBN13 = b.ISBN13 
		AND o.StoreId = 2 
		AND o.Status = 1) 
	AS [Available Store 2],
	--In Stock store 3
	(SELECT 
		ISNULL(SUM(inv.Quantity), 0) 
	FROM 
		Inventories inv 
	WHERE 
		inv.ISBN13 = b.ISBN13 
		AND inv.StoreId = 3)
	AS [In stock store 3],
	--Available store 3
	(SELECT 
		ISNULL(SUM(inv.Quantity), 0)
	FROM 
		Inventories inv
	WHERE 
		inv.ISBN13 = b.ISBN13
		AND inv.StoreId = 3) - 
	(SELECT 
		ISNULL(SUM(bo.Quantity), 0)
	FROM 
		BooksOrders bo
		JOIN Orders o 
		ON bo.OrderID = o.Id
	WHERE 
		bo.ISBN13 = b.ISBN13 
		AND o.StoreId = 3 
		AND o.Status = 1) 
	AS [Available Store 3]
FROM
	Books b
	LEFT JOIN Inventories inv
		ON b.ISBN13 = inv.ISBN13
	LEFT JOIN Stores s
		ON inv.StoreId = s.Id
	LEFT JOIN Orders o
		ON s.Id = o.StoreId
	LEFT JOIN BooksOrders bo
		ON o.Id = bo.OrderID
GROUP BY
	b.ISBN13, b.Title
