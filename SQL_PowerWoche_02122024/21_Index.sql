USE SchulungDezember
-- Index

/*
	Table Scan: Durchsucht die gesamte Tabelle von Oben nach Unten (langsam)
	Index Scan: Durche bestimmte Teile der Tabelle (besser)
	Index Seek: Gehe in einen Index gezielt zu den DAten hin (am besten)

	Gruppierten Index:
	- Sortiert sich selber
	- bei INSERT/UPDATE/DELETE werden die Daten herumgeschoben
	- Kann nur einmal existieren pro Tabelle
	- Kostet Performance
	=> Standardmäßig mit Primary Key erstellt (liegt meistens auch darauf)

	Wann brauch ich denn den Gruppierten Index?
	- Sehr gut bei Abfragen mit rel. Großen Ergebnismengen, <, >, between, like


	Nicht-gruppierten Index:
	- Standardindex
	- Zwei Komponenten, Schlüsselspalte, inkludierten Spalten
	- Anhand dieser Komponenten entscheidet die DB, ob der Index verwendet wird oder nicht

	Wann brauch ich denn den Nicht-Gruppierten Index:
	- Sehr gut bei Abfragen die auf rel. eindeutige Werte bzw geringeren Ergebnismengen gehen
	- Kann aber mehrfach verwendet werden (999-Mal)


*/

SELECT * INTO
M005_Index
FROM M004_Kompression

SET STATISTICS TIME, IO ON

-- Table Scan: Kosten 21,71%
SELECT * FROM M005_Index

SELECT * FROM M005_Index
WHERE OrderID >= 11000
-- Table Scan
-- Cost: 21,95, logische Lesevorgänge: 28491, CPU-Zeit = 327ms, verstrichene Zeit = 1009ms

-- Neuer Index: NCIX_OrderID
SELECT * FROM M005_Index
WHERE OrderID >= 11000
-- Index seek
-- Cost: 2,19, logische Lesevorgänge 2898, CPU-Zeit = 141ms, verstrichene Zeit = 957ms

-- Indizes anschauen
SELECT OBJECT_NAME(OBJECT_ID), index_level, page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')
WHERE OBJECT_NAME(object_id) = 'M005_Index'

-- Auf bestimmte (häufige) Abfragen Indizes aufbauen
SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice FROM M005_Index
WHERE ProductName = 'Chocolade'
-- Tablescan:
-- Cost: 21,37, logische Lesevorgänge: 28491, CPU-Zeit: 218ms, verstrichenen Zeit = 110ms

-- Neuer Index: NCIX_ProductName
SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice FROM M005_Index
WHERE ProductName = 'Chocolade'
-- Index seek
-- Cost: 0,02 ; Logische Lesevorgänge: 26, CPU-Zeit = 0ms, verstrichene Zeit 121ms

-- ContactName weg... bleibt trotzdem gleich
SELECT CompanyName, ProductName, Quantity * UnitPrice FROM M005_Index
WHERE ProductName = 'Chocolade'

-- Cost: 4,94, logische Lesevorgänge: 1562, CPU-Zeit 0ms, verstrichene Zeit = 109ms
SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice, Freight FROM M005_Index
WHERE ProductName = 'Chocolade'

-- Index Seek erreichen mit der Abfragen von oben
SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice, Freight FROM M005_Index
WHERE ProductName = 'Chocolade'
-- Index Seek:
-- Cost: 0,02, Logische Lesevorgänge: 27, CPU-Zeit = 0ms, verstrichene Zeit = 142ms

-- Index erstellen
SELECT CompanyName, ContactName, ProductName, Quantity * UnitPrice, Freight
FROM M005_Index
WHERE Freight > 50
-- Index Seek:
-- Cost: 3,96 , Logische Lesevorgänge: 4863, CPU-Zeit = 375ms, verstrichene Zeit = 2621ms

--------------------------------------------------------------------------------

-- View mit Index
-- Benötigt: SCHEMABINDING
-- WITH SCHEMABINDING: Solange diese View existiert, kann die Tabellenstruktur nicht verändert werden

ALTER TABLE M005_Index
ADD id int identity
GO

SELECT * FROM M005_Index
GO

--DROP VIEW Adressen

CREATE VIEW Adressen WITH Schemabinding
AS 
Select id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M005_Index

SELECT * FROM Adressen
-- Table Scan
-- Cost: 21,92 , Logische Lesevorgänge: 34488, CPU-Zeit = 875ms, verstrichene Zeit = 6287ms

SELECT * FROM Adressen
-- Clustered Index
-- Cost: 7,78 , Logische Lesevorgänge: 9696, CPU-Zeit = 922ms, verstrichene Zeit = 5354ms

-- Clustered Index Scan
-- Abfrage auf die Tabelle verwendet den Index der View
Select id, CompanyName, Address, City, Region, PostalCode, Country
FROM dbo.M005_Index

-- INSERT M005_Index (CompanyName, Address, City, Region, PostalCode, Country, CustomerID, OrderID, EmployeeID)
INSERT INTO M005_Index (CompanyName, Address, City, Region, PostalCode, Country, CustomerID, OrderID, EmployeeID)
VALUES ('PPEDV', 'EinE sTRAße', 'Irgendwo', NULL, NULL, NULL, 'PPEDV', 15832, 1)

SELECT * FROM dbo.M005_Index


DELETE FROM M005_Index
WHERE id = 551681