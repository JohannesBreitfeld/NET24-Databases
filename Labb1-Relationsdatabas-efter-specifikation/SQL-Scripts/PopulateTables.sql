--Populate Languages
INSERT INTO Languages(Name)
VALUES
	('Svenska'), 
	('Engelska')

--Populate BookBinding
INSERT INTO BookBinding([Type])
VALUES
	('Inbunden'),
	('Pocket'),
	(N'H�ftad')

--Populate Genres
INSERT INTO Genres(Name)
VALUES
	('Deckare'),
	('Memoarer'),
	(N'Samtida sk�nlitteratur'),
	('Barnbok')

--Populate Publishers
INSERT INTO Publishers(Name, Email, StreetAddress, PostalCode, City, Country)
VALUES
	(N'Piratf�rlaget', 'info@piratforlaget.se', 'Kaptensgatan 6', '114 57', 'Stockholm', 'Sverige'),
	(N'Vintage', 'info@penguinhouse.co.uk', '8 Viaduct Gardens', 'SW11 BW', 'London', 'Storbrittanien'),
	(N'Leopard f�rlag', 'info@leopardforlag.se', 'Bj�rng�rdsgatan 15', '102 68', 'Stockholm', 'Sverige'),
	(N'LL-F�rlaget', 'll-forlaget@mtm.se', 'Hans Michelsensgatan 2', '211 20', 'Malm�', 'Sverige'),
	(N'Bokf�rlaget forum', 'info@forum.se', 'Sveav�gen 56', '103 63', 'Stockholm', 'Sverige'),
	(N'Bonnier Carlsen', 'info@bonniercarlsen.se', 'Sveav�gen 56', '103 63', 'Stockholm', 'Sverige'),
	(N'Rab�n & Sj�gren', 'info@rabensjogren.se', 'Tryckerigatan 4', '103 12', 'Stockholm', 'Sverige')


--Populate Authors
INSERT INTO Authors(FirstName, LastName, BirthDate)
VALUES
	('Jan', 'Guillou', '1944-01-17'),
	('Henning', 'Mankell', '1948-02-03'),
	(N'Camilla', 'L�ckberg', '1974-08-30'),
	('Astrid', 'Lindgren', '1907-11-14'),
	(N'Johan', 'Werkm�ster', '1955-10-05'),
	('Millis', 'Sarri', '1973-07-11') 

--Populate Books
INSERT INTO Books(ISBN13, Title, LanguageId, GenreId, Price, PublisherId, DatePublished, BindingId)
VALUES
	(N'9789164209252', 'Anteckningar fr�n aftons�ngen', 1, 1, 239, 1, '2024-10-17', 1),
	(N'9789164208606', 'Eventuellt upps�t : att d�da ortens gangsters', 1, 1, 239, 1, '2023-03-29', 1),
	(N'9789164207746', 'Den som d�dade helvetets �nglar', 1, 1, 219, 1, '2022-01-19', 1), 
	(N'9781784701567', 'Quicksand', 2, 2, 169, 2, '2017-02-02', 3),
	(N'9780099532040', 'The Man From Beijing', 2, 2, 169, 2, '2011-02-03', 3),
	(N'9789173436007', 'Svenska gummist�vlar', 1, 3, 252, 3, '2015-06-01', 1),
	(N'9789188180964', 'Fotografens D�d : L�ttl�st version', 1, 1, 89, 4, '1997-01-01', 2),
	(N'9789137503547', 'Dr�mmar av brons', 1, 1, 239, 5, '2024-05-02', 1),
	(N'9789179754273', 'Super-Charlie och gosedjurstjuven', 1, 4, 81, 6, '2021-02-25', 1),
	(N'9789129743111', 'Pippi r�ddar julen', 1, 4, 119, 7, '2023-10-20', 1), 
	(N'9789129674521', 'Sagor, hyss & �ventyr', 1, 4, 239, 7, '2010-09-27', 1)

--Populate AuthorsBooks
INSERT INTO AuthorsBooks(ISBN13, AuthorID)
VALUES
	('9789164209252', 1),
	('9789164208606', 1),
	('9789164207746', 1),
	('9781784701567', 2),
	('9780099532040', 2),
	('9789188180964', 5),
	('9789188180964', 2),
	('9789137503547', 3),
	('9789179754273', 3),
	('9789179754273', 6),
	('9789129743111', 4),
	('9789129674521', 4)

--Populate Stores
INSERT INTO Stores ([Name], StreetAddress, PostalCode, City, Country)
VALUES 
(N'Bokhandel S�der', 'S�dergatan 12', '211 34', 'Malm�', 'Sverige'),
(N'Vasa B�cker', 'Vasagatan 8', '111 20', 'Stockholm', 'Sverige'),
(N'Berras B�cker AB', 'Storgatan 5', '413 01', 'G�teborg', 'Sverige');

--Populate Inventories
-- Infogar b�cker i Inventories med faktiska kvantiteter
INSERT INTO Inventories (ISBN13, StoreId, Quantity)
VALUES
-- F�r butik med ID 1 (Bokhandel S�der)
('9789164209252', 1, 5),  -- Anteckningar fr�n aftons�ngen
('9789164208606', 1, 3),  -- Eventuellt upps�t : att d�da ortens gangsters
('9789164207746', 1, 7),  -- Den som d�dade helvetets �nglar
('9781784701567', 1, 6),  -- Quicksand
('9780099532040', 1, 4),  -- The Man From Beijing
('9789173436007', 1, 8),  -- Svenska gummist�vlar
('9789188180964', 1, 2),  -- Fotografens D�d : L�ttl�st version
('9789137503547', 1, 5),  -- Dr�mmar av brons
('9789179754273', 1, 10), -- Super-Charlie och gosedjurstjuven
('9789129743111', 1, 9),  -- Pippi r�ddar julen
('9789129674521', 1, 6),  -- Sagor, hyss & �ventyr

-- F�r butik med ID 2 (Kaffebutik)
('9789164209252', 2, 4),  -- Anteckningar fr�n aftons�ngen
('9789164208606', 2, 6),  -- Eventuellt upps�t : att d�da ortens gangsters
('9789164207746', 2, 8),  -- Den som d�dade helvetets �nglar
('9781784701567', 2, 3),  -- Quicksand
('9780099532040', 2, 5),  -- The Man From Beijing
('9789173436007', 2, 6),  -- Svenska gummist�vlar
('9789188180964', 2, 1),  -- Fotografens D�d : L�ttl�st version
('9789137503547', 2, 7),  -- Dr�mmar av brons
('9789179754273', 2, 4),  -- Super-Charlie och gosedjurstjuven
('9789129743111', 2, 3),  -- Pippi r�ddar julen
('9789129674521', 2, 8),  -- Sagor, hyss & �ventyr

-- F�r butik med ID 3 (Elektronikaff�r AB)
('9789164209252', 3, 9),  -- Anteckningar fr�n aftons�ngen
('9789164208606', 3, 2),  -- Eventuellt upps�t : att d�da ortens gangsters
('9789164207746', 3, 5),  -- Den som d�dade helvetets �nglar
('9781784701567', 3, 4),  -- Quicksand
('9780099532040', 3, 6),  -- The Man From Beijing
('9789173436007', 3, 10), -- Svenska gummist�vlar
('9789188180964', 3, 3),  -- Fotografens D�d : L�ttl�st version
('9789137503547', 3, 8),  -- Dr�mmar av brons
('9789179754273', 3, 6),  -- Super-Charlie och gosedjurstjuven
('9789129743111', 3, 4),  -- Pippi r�ddar julen
('9789129674521', 3, 7);  -- Sagor, hyss & �ventyr

-- Populate Customers
INSERT INTO Customers (FirstName, LastName, StreetAddress, PostalCode, City, Country)
VALUES
('Erik', 'Andersson', 'Sveav�gen 22', '111 57', 'Stockholm', 'Sverige'),
('Anna', 'Johansson', 'Storgatan 45', '123 45', 'G�teborg', 'Sverige'),
('Oskar', 'Karlsson', 'V�sterl�nggatan 12', '211 25', 'Malm�', 'Sverige'),
('Emma', 'Nilsson', 'Bergsgatan 10', '503 35', 'Bor�s', 'Sverige'),
('Lars', 'Olsson', 'Kungsgatan 30', '123 47', 'Uppsala', 'Sverige');

--Populate OrderStatus
INSERT INTO OrderStatus 
VALUES
	('�ppen'),
	(N'Slutf�rd'),
	('Annulerad')

--Populate Orders
INSERT INTO Orders (CustomerID, [Status], StoreId) VALUES (1, 2, 1);
INSERT INTO Orders (CustomerID, [Status], StoreId) VALUES (1, 1, 2);
INSERT INTO Orders (CustomerID, [Status], StoreId) VALUES (2, 1, 3);
INSERT INTO Orders (CustomerID, [Status], StoreId) VALUES (3, 2, 1);
INSERT INTO Orders (CustomerID, [Status], StoreId) VALUES (3, 1, 2);
INSERT INTO Orders (CustomerID, [Status], StoreId) VALUES (4, 1, 2);
INSERT INTO Orders (CustomerID, [Status], StoreId) VALUES (5, 2, 1);
INSERT INTO Orders (CustomerID, [Status], StoreId) VALUES (5, 1, 1);

--Populate BooksOrders
INSERT INTO BooksOrders (OrderID, ISBN13, Quantity)
VALUES
(1000000, '9789164209252', 2), 
(1000000, '9781784701567', 1); 

INSERT INTO BooksOrders (OrderID, ISBN13, Quantity)
VALUES
(1000001, '9789173436007', 1), 
(1000001, '9789137503547', 2);  

INSERT INTO BooksOrders (OrderID, ISBN13, Quantity)
VALUES
(1000002, '9789129743111', 1), 
(1000002, '9789129674521', 2); 

INSERT INTO BooksOrders (OrderID, ISBN13, Quantity)
VALUES
(1000003, '9789164209252', 3),  
(1000003, '9789188180964', 1); 

INSERT INTO BooksOrders (OrderID, ISBN13, Quantity)
VALUES 
(1000004, '9789179754273', 1);  

INSERT INTO BooksOrders (OrderID, ISBN13, Quantity)
VALUES
(1000005, '9789164208606', 2); 

INSERT INTO BooksOrders (OrderID, ISBN13, Quantity)
VALUES
(1000006, '9789129674521', 2); 

INSERT INTO BooksOrders (OrderID, ISBN13, Quantity)
VALUES
(1000007, '9789129743111', 3),  
(1000007, '9789164209252', 1);  


