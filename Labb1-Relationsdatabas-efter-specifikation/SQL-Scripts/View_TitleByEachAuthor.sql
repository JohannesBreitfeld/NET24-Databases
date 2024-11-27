CREATE VIEW TitlesByEachAuthor AS
SELECT 
	CONCAT(a.FirstName, ' ', a.LastName) AS [Name],
	CONCAT(DATEDIFF(YEAR, a.BirthDate, GETDATE()), ' år') AS Age,
	CONCAT(ISNULL(COUNT(DISTINCT b.Title), 0), ' st') AS Titles,
	CONCAT(SUM(i.Quantity * b.Price), ' kr') AS InventoryValue
FROM
	Authors a
	JOIN AuthorsBooks ab
		ON a.Id = ab.AuthorID
	JOIN Books b
		ON ab.ISBN13 = b.ISBN13
	JOIN Inventories i
		ON b.ISBN13 = i.ISBN13
GROUP BY
	a.FirstName, a.LastName, a.BirthDate;