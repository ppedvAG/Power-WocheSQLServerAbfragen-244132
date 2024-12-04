USE Northwind

-- Subqueries / Unterabfragen / nested Queries

/*
	- Sie muss eigenst�ndig ausf�hrbar sein (fehlerfrei)
	- K�nnen prinzipiell �berall in eine Abfrage eingebaut werden (wenn es Sinn macht)
	- Abfragen werden "von innen nach au�en" der Reihe nach ausgef�hrt
*/

-- Zeige mir alle Orders, deren Freight Werte �ber dem Durchschnitt liegen
SELECT * FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)

-- 1. Schreiben Sie eine Abfrage, um eine Produktliste 
--(ID, Name, St�ckpreis) mit einem �berdurchschnittlichen Preis zu erhalten.
SELECT ProductID, ProductName, UnitPrice FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice

