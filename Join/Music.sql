---- C1. Av alla audiospår, vilken artist har längst total speltid?
SELECT
	ar.Name AS Artist,
	CONCAT(FORMAT(SUM(CAST(t.Milliseconds AS BIGINT)) / 3600000, '0'), 'h '
	, FORMAT((SUM(CAST(t.Milliseconds AS BIGINT)) % 3600000) / 60000, '00'), 'min '
	, FORMAT((((SUM(CAST(t.Milliseconds AS BIGINT)) % 3600000) % 60000) / 1000), '00'), 'sec')
	AS [Total playtime]
FROM
	music.tracks t
	JOIN music.albums al
		ON t.AlbumId = al.AlbumId
	JOIN music.artists ar
		ON ar.ArtistId = al.ArtistId 
WHERE
	t.MediaTypeId != 3
GROUP BY
	ar.Name
ORDER BY
	SUM(CAST(t.Milliseconds AS BIGINT)) desc

-- C2. Vad är den genomsnittliga speltiden på den artistens låtar?
SELECT
	CONCAT(FORMAT(SUM(CAST(t.Milliseconds AS BIGINT)) / COUNT(t.TrackId) / 60000, '00'), 'min ',
	FORMAT(SUM(CAST(t.Milliseconds AS BIGINT)) / COUNT(t.TrackId) % 60000 / 1000, '00'), 'seconds'
	) AS [Average playtime]
FROM
	music.tracks t
	JOIN music.albums al
		ON t.AlbumId = al.AlbumId
	JOIN music.artists ar
		ON ar.ArtistId = al.ArtistId
WHERE
	ar.Name = 'Iron Maiden'

-- C3. Vad är den sammanlagda filstorleken för all video?
SELECT
	CONCAT(FORMAT(SUM(CAST(t.bytes AS BIGINT)) / 1000000000.0, '0.00'), ' GB') AS [Total size]
FROM
	music.tracks t
	JOIN music.media_types mt
	ON t.MediaTypeId = mt.MediaTypeId
WHERE
	mt.Name	LIKE '%VIDEO%'

-- C4. Vilket är det högsta antal artister som finns på en enskild spellista?
SELECT
	p.Name AS [Playlist Name],
	p.playlistID,
	COUNT(DISTINCT a.ArtistID) as [Unique artists]
FROM
	music.playlists p
	LEFT JOIN music.playlist_track pt
		ON p.PlaylistId = pt.PlaylistId
	LEFT JOIN music.tracks t
		ON t.TrackId = pt.TrackId
	LEFT JOIN music.albums a
		ON t.AlbumId = a.AlbumId
GROUP BY
	p.PlaylistId, p.Name
ORDER BY
	[Unique artists] desc

-- C5. Vilket är det genomsnittliga antalet artister per spellista?
SELECT 
    FORMAT(AVG(CAST([Unique artists] AS FLOAT)), '00.00') AS [Average unique artists per playlist]
FROM (
    SELECT
        p.PlaylistId,
        COUNT(DISTINCT a.ArtistID) AS [Unique artists]
    FROM
        music.playlists p
    LEFT JOIN music.playlist_track pt
        ON p.PlaylistId = pt.PlaylistId
    LEFT JOIN music.tracks t
        ON t.TrackId = pt.TrackId
    LEFT JOIN music.albums a
        ON t.AlbumId = a.AlbumId
    WHERE 
       p.Name NOT IN ('Music Videos', 'TV Shows', 'Movies', 'Audiobooks')
    GROUP BY
        p.PlaylistId
) AS Subquery;
