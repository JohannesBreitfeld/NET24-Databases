-- -- E1
SELECT 
	Title, 
	'S' + FORMAT(Season, '00') + 'E' + FORMAT(EpisodeInSeason, '00') AS Episode
FROM 
	GameOfThrones
ORDER BY 
	Episode;

---- E2
SELECT
	ID,
	LOWER(CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2))) AS UserName,
	Password,
	FirstName,
	LastName,
	Email,
	Phone
INTO
	Users3
FROM
	Users;

-- E3
SELECT
	IATA,
	ICAO,
	[Airport name],
	[Location served],
	COALESCE(Time, '-') AS Time,
	COALESCE(DST, '-') AS DST
INTO
	Airports2
FROM
	Airports;

--E4
SELECT * INTO Elements2 FROM Elements;
DELETE FROM 
	Elements2
WHERE 
	Name IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
OR
	LEFT(Name, 1) IN ('D', 'K', 'M', 'O', 'U');

---- E5
SELECT
	Symbol,
	Name,
	CASE
		WHEN LEN(Symbol) = 1 AND LEFT(Name, 1) = Symbol THEN 'YES'
		WHEN LEN(Symbol) = 2 AND LEFT(Name, 2) = Symbol THEN 'YES'
		ELSE 'NO'
	END AS SymbolMatch
INTO
	Elements3
FROM 
	Elements

SELECT * FROM Elements3;

-- E6
SELECT
	Name,
	Red,
	Green,
	Blue
INTO
	Colors2
From
	Colors

SELECT 
    Name,
    Red,
    Green,
    Blue,
    '#' + FORMAT(Red, 'X2') + FORMAT(Green, 'X2') + FORMAT(Blue, 'X2') AS HexCode
FROM Colors2;

-- E7
SELECT
	Integer,
	String
INTO
	Types2
FROM
	Types;

SELECT
	Integer,
	CAST(Integer AS FLOAT) * 0.01  AS Float,
	DATEADD(MINUTE, Integer, DATEADD(DAY, Integer-1, '2019-01-01 09:00:00')) AS DateTime,
	CASE 
        WHEN (Integer % 2 = 0 )THEN 0
        ELSE 1
    END AS Bool
FROM
	Types2

