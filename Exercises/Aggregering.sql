---- E1
SELECT
	Period,
	MIN(Number) AS [From],
	MAX(Number) AS [To],
	FORMAT(AVG(CAST(Stableisotopes AS FLOAT)), '0.00') AS [Average Isotopes],
	STRING_AGG(Symbol, ', ') AS [Symbols]
FROM
	Elements
GROUP BY
	Period
ORDER BY
	Period

---- E2
SELECT
	City,
	Region,
	Country,
	COUNT(id) AS [Number of customers]
FROM
	company.Customers
GROUP BY
	City, Country, Region
HAVING
	COUNT(id) >= 2
ORDER BY
	[Number of customers] desc

-- E3
DECLARE @GOT AS NVARCHAR(MAX) = '';

SELECT
	@GOT = @GOT + 'Säsong ' + CAST(Season AS NVARCHAR(10)) + ' sändes från ' 
         + FORMAT(MIN([Original air date]), 'MMMM', 'sv') + ' till ' 
         + FORMAT(MAX([Original air date]), 'MMMM yyyy', 'sv') + '. '
         + 'Totalt sändes ' + CAST(COUNT(*) AS NVARCHAR(10)) + ' avsnitt, '
         + 'som i genomsnitt sågs av ' + FORMAT(AVG([U.S. viewers(millions)]), '0.0') 
         + ' miljoner människor i USA.' + CHAR(13)
FROM	
	GameOfThrones
GROUP BY
	Season

PRINT @GOT

--E4
SELECT
	CONCAT(Firstname, ' ', LastName) AS Name,
	DATEDIFF(YEAR, 
		CAST('19' + SUBSTRING(id, 1, 2) AS NVARCHAR(4)) + '-'
		+ SUBSTRING(id, 3, 2) + '-'
		+ SUBSTRING(id, 5, 2),
		GETDATE()) AS Age,
	CASE
		WHEN CAST(SUBSTRING(id, 10, 1) AS INT) % 2 = 0 THEN 'W'
		ELSE 'M'
	END AS Gender
FROM
	Users
ORDER BY
	LastName, FirstName;

-- E5
SELECT
	Region,
	COUNT(Country) AS [Number of countries],
	FORMAT(SUM(CAST(Population AS BIGINT)), 'N0') AS [Total population], 
	FORMAT(SUM(CAST([Area (sq# mi#)] AS INT)) * 2.58998811, 'N0') AS [Total Area (sq/km)],
	FORMAT(AVG(CAST(REPLACE([Pop# Density (per sq# mi#)], ',', '.') AS FLOAT)) * 0.38610216, '0.00') AS [Population Density (per sq/km)],
	CAST(AVG(CAST(REPLACE([Infant mortality (per 1000 births)], ',', '.') AS FLOAT)) * 100 AS INT) AS [Infant morality per 100.000]
FROM
	Countries
GROUP BY
	Region

-- E6 -- Inte helt nöjd med resultatet, 245 resultat både när jag kör med trim och inte, men det verkar finnas kvar whitespaces innan vissa resultat.
SELECT
    REPLACE(REPLACE(REPLACE(  
		CASE 
			WHEN CHARINDEX(',', [Location served]) > 0 THEN 
				 SUBSTRING([Location served], 
				 LEN([Location served]) - CHARINDEX(',', REVERSE([Location served])) + 2,
				 LEN([Location served])) 
		END,
	'1', ''), '2', ''), '7', '')
	AS [Country],
	COUNT(IATA) AS [Number of Airports],
	COUNT(CASE WHEN ICAO IS NULL THEN 1 END) AS [Airports without ICAO],
	FORMAT(CAST(COUNT(CASE WHEN ICAO IS NULL THEN 1 END) AS FLOAT) / COUNT(IATA) * 100, '0.##') AS [Percent without ICAO]
FROM
	Airports
GROUP BY
   REPLACE(REPLACE(REPLACE(  
		CASE 
			WHEN CHARINDEX(',', [Location served]) > 0 THEN 
				SUBSTRING([Location served], 
				LEN([Location served]) - CHARINDEX(',', REVERSE([Location served])) + 2,
				LEN([Location served])) 
		END,
	'1', ''), '2', ''), '7', '')
ORDER BY
	[Number of Airports]

