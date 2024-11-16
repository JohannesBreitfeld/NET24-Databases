
declare @playlist varchar(max) = 'Heavy Metal Classic';

SELECT
	g.Name AS Genre,
	ar.Name AS Artist,
	al.Title AS Album,
	t.Name AS Track,
	FORMAT(t.Milliseconds / 60000 , '00') + ':' + FORMAT(t.Milliseconds % 60000 / 1000, '00') AS Length,
	FORMAT(CAST(t.bytes AS FLOAT)/1048576, '0.0') + ' MiB' AS Size,
	ISNULL(t.Composer, '-') AS Composer
FROM
	music.playlists p
	JOIN music.playlist_track pt
	ON p.PlaylistId = pt.PlaylistId
	JOIN music.tracks t
	ON t.TrackId = pt.TrackId
	JOIN music.genres g
	ON t.GenreId = g.GenreId
	JOIN music.albums al
	ON al.AlbumId = t.AlbumId
	JOIN music.artists ar
	ON al.ArtistId = ar.ArtistId
WHERE
	p.Name = @playlist
	
