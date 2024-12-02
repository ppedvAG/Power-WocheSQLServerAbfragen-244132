-- USE Datenbankname wechselt die angesprochene Datenbank
/*
	Alternativ über das Drop Down Menü
	die richtige DB auswählen
*/	
USE Northwind

SELECT * FROM Customers -- * = alle Spalten werden angezeigt

SELECT CustomerID, CompanyName FROM Customers

-- "Custom" Werte mir ausgeben lassen
SELECT 100, 500, 300, 200

SELECT 'Hallo', 100, 7*8, 5+10

-- SQL ist NICHT case-sensitive, Formatierung spielt keine Rolle, keine Semikolons
SeLEcT			cOuNTrY,

				ComPanynAMe
FrOm			CusTomErs

/*
	SELECT: Gibt Spalten aus einer bestimmten Tabelle zurück
*/

-- ORDER BY: Spalten sortieren
SELECT Country, City FROM Customers
ORDER BY City DESC
-- ORDER BY ist syntaktisch immer am Ende
-- ASC = ascending = aufsteigend
-- DESC = Descending = absteigend

-- Mehrere Spalten gleichzeitig Ordern
SELECT * FROM Customers
ORDER BY City ASC, CompanyName DESC

-- TOP X gibt nur die ersten X Zeilen aus
SELECT TOP 10 * FROM Customers
SELECT TOP 100 * FROM Customers

-- Geht auch mit %-Angaben
SELECT TOP 10 PERCENT * FROM Customers

SELECT TOP 10 * FROM Customers
ORDER BY CustomerID DESC

/*
	WICHTIG!: "BOTTOM" x existiert nicht, ergebnisse einfach umdrehen mit 
	ORDER BY
*/

/*
	Die 20 größten Frachtkosten haben aus der Orders Tabelle
	&
	Die 20 kleinsten Frachtkosten aus der Orders Tabelle
*/

-- größten
SELECT TOP 20 * FROM Orders
ORDER BY Freight DESC

-- kleinsten
SELECT TOP 20 * FROM Orders
ORDER BY Freight

-- Duplikate rausfiltern mit DISTINCT

SELECT DISTINCT Country FROM Customers

SELECT DISTINCT City, Country FROM Customers

-- UNION führt mehrere Ergebnistabellen vertikal in eine Tabelle zusammen
-- UNION macht automatisch ein DISTINCT
-- UNION muss gleiche Spaltenanzahl haben & Datentypen müssen kompatibel sein

SELECT * FROM Customers
UNION
SELECT * FROM Customers

-- UNION ohne DISTINCT
SELECT * FROM Customers
UNION ALL
SELECT * FROM Customers

-- Funktioniert nicht
SELECT 100, 'Hallo'
UNION
SELECT 'Tschüss', 5, 'Hallo'

-- Funktioniert wiederrum schon
SELECT 100, 'Hallo'
UNION
SELECT  5, 'Hallo'

-- Spalten "umbennen" mit Aliase bzw. "as"
SELECT 100 as Zahl, 'Text' as 'Text Begrüßung'

SELECT City as Stadt FROM Customers

-- Aliase für Tabellennamen vergeben (für JOINS)
SELECT * FROM Customers as cus