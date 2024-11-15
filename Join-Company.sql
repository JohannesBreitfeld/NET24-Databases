-- A1.
-- order_details.ProductId, order_details.OrderId, orders.Id, orders.ShipCity

SELECT
	FORMAT(
		(
		SELECT
			COUNT(DISTINCT od.ProductID)
		FROM
			company.order_details od
			JOIN company.orders o 
			ON od.OrderId = o.Id
		WHERE o.ShipCity = 'London'
		) * 1.0 / 77 * 100,
	'0.##')
	
-- A2
SELECT
	o.Shipcity,
	COUNT(DISTINCT od.ProductId) AS [Unique products delivered]
FROM
	company.order_details od
	JOIN company.orders o 
	ON od.OrderId = o.Id
GROUP BY
	o.shipcity
ORDER BY
	[Unique products delivered] desc

-- A3 Av de produkter som inte längre finns I vårat sortiment, hur mycket har vi sålt för totalt till Tyskland?
SELECT
	o.Shipcountry,
	SUM(od.UnitPrice * od.Quantity * (1.0 - CAST(REPLACE(Discount, ',', '.') AS FLOAT))) AS [Total value]
FROM
	company.orders o
	JOIN company.order_details od 
	ON o.id = od.OrderId
	JOIN company.products p
	ON od.ProductId = p.Id
WHERE
	p.Discontinued  = 1 AND
	o.Shipcountry = 'Germany'
GROUP BY
	o.ShipCountry

-- A4. För vilken produktkategori har vi högst lagervärde?
SELECT
	TOP 1
	c.CategoryName,
	SUM(p.UnitPrice * p.UnitsInStock) AS [Total value]
FROM
	company.products p
	JOIN company.categories c 
	ON p.CategoryId = c.Id
GROUP BY
	c.CategoryName
ORDER BY
	[Total value] desc

-- A5. Från vilken leverantör har vi sålt flest produkter totalt under sommaren 2013?

-- Går på orders.Shippeddate NVARCHAR, 2013-06-01 till 2013-08-30, ID ->
-- ORDERID - order_details.quantity - PRODUCTID -> 
-- ID - products.SupplierId - SUPPLIERID -> 
-- ID - supplier.CompanyName

SELECT
	TOP 1
	s.CompanyName,
	SUM(od.Quantity) AS [Total amount]
FROM
	company.orders o
	JOIN company.order_details od
	ON o.Id = od.OrderId
	JOIN company.products p
	ON od.ProductId = p.Id
	JOIN company.suppliers s
	ON p.SupplierId = s.Id
WHERE
	CAST(o.ShippedDate AS DATE) BETWEEN '2013-06-01' AND '2013-08-30'
GROUP BY
	s.CompanyName
ORDER BY
	[Total amount] desc
	