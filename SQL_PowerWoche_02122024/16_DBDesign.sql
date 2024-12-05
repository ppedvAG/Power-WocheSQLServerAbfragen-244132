/*
	Normalerweise:
	1. Jede Zelle sollte einen Wert haben
	2. Jeder Datensatz soll einen Primärschlüssel haben
	3. Keine Beziehung haben zwischen nicht-Schlüssel Spalten

	Redundanz verringern (Daten nicht doppelt speichern)
	- Weniger Speicherbedarf
	- Doppelte können nicht unterschiedlich sein

*/

/*
	Seite:
	8192B (8kB) Größe
	8060B für tatsächliche Daten
	132B für Management Daten
	8 Seiten = 1 Block

	Seiten werden immer 1:1 gelesen

	Maximal 700 Datensätze auf einer Seite haben
	Datensätze müssen komplett auf eine Seiten passen
	Leerer Raum darf existieren, aber sollte minimiert werden
*/

-- dbcc: Database Console Commands
-- showcontig: Zeigt Seiteninformationen über ein Datenbankobjekt -> Seitendichte messen

--
dbcc showcontig('Orders') -- Seitendichte 94.15%

-- Messungen
SET STATISTICS time, IO OFF -- Anzahl der Seiten,
		-- Dauer in ms von CPU-Zeit und der Gesamtausführzeit

SELECT * FROM Orders

-- Ausführungsplan: Routenplan für unser SQL Statement (STRG + M)

CREATE DATABASE SchulungDezember

USE SchulungDezember


-- Absichtlich eine ineffiziente Tabelle
CREATE TABLE M001_Test1
(
	id int identity,
	test char(4100)
)

INSERT INTO M001_Test1
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Test1')
-- 20000 Seiten gelesen, Scandichte von 50,79%


CREATE TABLE M001_Test2
(
	id int identity,
	test varchar(4100)
)

INSERT INTO M001_Test2
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Test2')
-- Seiten: 52, Scandichte 95,01%

SET STATISTICS time, IO OFF
-- Was will ich sehen:
-- logischen Lesevorgänge, CPU Zeit, verstrichene Zeit

-- Alle Datensätze der Tabelle Orders aus dem Jahr 1997

-- logische Lesevorgänge: 23, CPU-Zeit = 16ms, verstrichene Zeit = 69ms
SELECT * FROM Orders WHERE OrderDate LIKE '%1997%'

-- logische Lesevorgänge: 23, CPU-Zeit = 0ms, verstrichene Zeit = 77ms
SELECT * FROM Orders WHERE OrderDate BETWEEN '1.1.1997' AND '31.12.1997'

-- logische Lesevorgänge: 23, CPU-Zeit = 0ms, verstrichene Zeit = 72ms
SELECT * FROM Orders WHERE OrderDate BETWEEN '1.1.1997' AND '31.12.1997 23:59:59.997'

-- logische Lesevorgänge: 23, CPU-Zeit = 15ms, verstrichene Zeit = 56ms
SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997


CREATE TABLE M001_Test3
(
	id int identity,
	test nvarchar(4000)
)

INSERT INTO M001_Test3
VALUES('XYZ')
GO 20000

dbcc showcontig('M001_Test3')
-- Seiten: 60, Seitendichte: 94,70%

-- sys.dm_db_index_physical_stats: Gibt einen Gesamtüberblick über die Seiten der Datenbank
SELECT OBJECT_NAME(OBJECT_ID), *
FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')

/*
	Gute Seitendichte:
	ab 70% = ist es okey
	ab 80% = ist es gut
	ab 90% = ist es sehr gut
*/

SELECT * FROM INFORMATION_SCHEMA.TABLES
SELECT * FROM INFORMATION_SCHEMA.COLUMNS

CREATE TABLE M001_TestFloat
(
	id int identity,
	zahl float
)

INSERT INTO M001_TestFloat
VALUES(2.2)
GO 20000

dbcc showcontig('M001_TestFloat')
-- Seiten: 55, Seitendichte: 94,32%

CREATE TABLE M001_TestDecimal
(
	id int identity,
	zahl decimal(2,1)
)

INSERT INTO M001_TestDecimal
VALUES(2.2)
GO 20000

dbcc showcontig('M001_TestDecimal')
-- Seiten: 47, Seitendichte: 94,61%


CREATE TABLE M001_TestDecimal2
(
	id int identity,
	zahl decimal(2,1)
)

-- Schnelleres Insert
BEGIN TRANSACTION
DECLARE @i int = 0
WHILE @i < 20000
BEGIN
	INSERT INTO M001_TestDecimal2 VALUES(2.2)
	SET @i += 1
end
COMMIT

SELECT * FROM M001_TestDecimal2