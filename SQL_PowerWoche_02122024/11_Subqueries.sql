USE Northwind

-- Subqueries / Unterabfragen / nested Queries

/*
	- Sie muss eigenständig ausführbar sein (fehlerfrei)
	- Können prinzipiell überall in eine Abfrage eingebaut werden (wenn es Sinn macht)
	- Abfragen werden "von innen nach außen" der Reihe nach ausgeführt
*/

-- Zeige mir alle Orders, deren Freight Werte über dem Durchschnitt liegen
SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)

-- 1. Schreiben Sie eine Abfrage, um eine Produktliste 
--(ID, Name, Stückpreis) mit einem überdurchschnittlichen Preis zu erhalten.
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice

