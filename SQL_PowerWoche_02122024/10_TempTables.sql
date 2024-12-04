USE Northwind

/*
	-- Temporäre Tabellen / Temp Tables / #Tables
*/
/*
	- SELECT INTO #TableName => Ergebnisse werden in eine Temporäre Tabelle geschrieben
	- existiert nur innerhalb meiner Session (Skriptfenster / Query)
	- werden in Systemdatenbanken => tempdb => Temp Tables abgespeichert
	- TempTables sind sehr schnell aber nicht aktuell => Ergebnisse werden nur einmal generiert
	- mit einem # = "lokal"
	- mit zwei ## = "global"
*/

-- Erstellen
SELECT * INTO ##TempTable
FROM Customers
WHERE Country = 'Germany'

-- Temporäre Tabelle aufrufen
SELECT * FROM ##TempTable

-- manuell löschen TempTable
DROP TABLE #TempTable

--1. Hat „Andrew Fuller“ (Employee) schonmal Produkte der Kategorie 
--„Seafood“ (Categories) verkauft?
--Wenn ja, wieviel Lieferkosten sind 
--dabei insgesamt entstanden (Freight)?
--Das ganze mit Temporaere Tabellen machen
SELECT SUM(Freight) as Lieferkosten
INTO #TempTable
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE LastName = 'Fuller' AND CategoryName = 'Seafood'

SELECT * FROM #TempTable
