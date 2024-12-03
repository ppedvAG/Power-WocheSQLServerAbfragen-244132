USE Northwind

-- Aggregatfunktionen: Führt eine Berechnung auf einer Menge von Werten durch und gibt
--					   einen einzigen Wert zurück

-- 5 grundsätzliche Aggregatfunktionen

SELECT
SUM(Freight) AS Summe,
MIN(Freight) AS Minimum,
MAX(Freight) AS Maximum,
AVG(Freight) as Durchschnitt,
COUNT(ShippedDate) as ZähleSpalte, COUNT(*) as ZähleAlles
FROM Orders

-- Ausnahme: COUNT(*) ignoriert keine NULL Werte, Aggregatfunktionen schon

-- AVG selber berechnen
SELECT SUM(Freight) / COUNT(*) FROM Orders

SELECT CustomerID, SUM(Freight) FROM Orders

/*
	GROUP BY - Fasst mehrere Werte in Gruppen zusammen
*/

SELECT CustomerID, Freight FROM Orders
ORDER BY CustomerID

SELECT CustomerID, OrderID, SUM(Freight) FROM Orders
WHERE CustomerID = 'ALFKI'
GROUP BY CustomerID, OrderID

-- Quantity Summe pro ProductName für Produkte der Kategorie 1-4:
SELECT ProductName, SUM(Quantity) AS SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1, 2, 3, 4)
GROUP BY ProductName
ORDER BY SummeStueckZahl

-- Nur die Produkte anzeigen lassen, die über 1000 Quantity haben
SELECT ProductName, SUM(Quantity) AS SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1, 2, 3, 4) AND SUM(Quantity) > 1000
GROUP BY ProductName
ORDER BY SummeStueckZahl

-- Having: funktioniert 1zu1 wie ein WHERE, kann aber gruppierte/aggregierte Werte nachträglich filtern
SELECT ProductName, SUM(Quantity) AS SummeStueckZahl FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE CategoryID IN (1, 2, 3, 4) 
GROUP BY ProductName
HAVING SUM(Quantity) > 1000
ORDER BY SummeStueckZahl

-- Übung
-- 1. Verkaufte Stueckzahlen (Quantity) pro ProduktKategorie (CategoryName) (8 Ergebniszeilen)
SELECT CategoryName, SUM(Quantity) FROM [Order Details]
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Categories ON Categories.CategoryID = Products.CategoryID
GROUP BY CategoryName

-- 2. Wieviele Bestellungen hat jeder Mitarbeiter bearbeitet? (9 Ergebniszeilen)
SELECT LastName, COUNT(OrderID) as Bestellungen FROM Employees
JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY LastName
ORDER BY Bestellungen DESC

-- 3. In welcher Stadt (City) waren „Wimmers gute Semmelknödel“ am beliebtesten (Quantity)?
SELECT TOP 1 City, SUM(Quantity) AS Verkaufsmenge FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE ProductName = 'Wimmers gute SemmelknÃ¶del'
GROUP BY City
ORDER BY Verkaufsmenge DESC


-- 4. Welcher Spediteur (Shippers) war durchschnittlich am günstigsten? (Freight)
SELECT CompanyName, AVG(Quantity) as AvgQuantity,AVG(Freight) as AvgFreight FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
GROUP BY CompanyName
ORDER BY AvgFreight
