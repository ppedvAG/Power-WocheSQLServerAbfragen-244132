USE Northwind

/*
	Inner JOIN:
	=> Wenn du nur übereinstimmende Daten aus beiden Tabellen brauchst.

	Left Join:
	=> Wenn du alle Daten aus der linken Tabelle brauchst (inkl. übereinstimmende)

	Right Join:
	=> Wenn du alle Daten aus der Rechten Tabelle brauchst (inkl. übereinstimmende)

	Full Join:
	=> Wenn du alle Daten aus beiden Tabellen brauchst, egal ob sie übereinstimmen


*/

-- Die Customers und Orders Tabelle in ein Ergebnisfenster ausgeben
SELECT * FROM Customers
SELECT * FROM Orders

/*
	JOIN Syntax:

	SELECT * FROM A
	INNER JOIN B ON A.KeySpalte = B.KeySpalte

*/

SELECT * FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID

-- Ausgabe von Spalten mit JOINs
SELECT CompanyName, Customers.CustomerID, Orders.* FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Germany'

-- JOIN zwischen: Customers - Orders - [Order Details]
SELECT * FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID

-- Übungen:
-- 1. Welche Produkte (ProductName) hat "Leverling" bisher verkauft?
SELECT ProductName, LastName FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
JOIN Products ON Products.ProductID = [Order Details].ProductID
WHERE Employees.LastName = 'Leverling'

-- 2. Wieviele Bestellungen haben Kunden aus Argentinien aufgegeben? 
SELECT * FROM Orders
JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Argentina'

-- 3. Was war die größte Bestellmenge (Quantity) von Chai Tee (ProductName = 'Chai')?
SELECT TOP 1 * FROM [Order Details]
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE ProductName = 'Chai'
ORDER BY Quantity DESC

-- BONUS: Alle Bestellungen (Orders) bei denen ein Produkt verkauft wurde, das nicht mehr gefuehrt wird
-- (Discontinued = 1 in Products)
SELECT * FROM Orders
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE Discontinued = 1

-- 4. Alle Produkte (ProductNames) aus den Kategorien "Beverages" und "Produce"
-- (CategoryName in Categories)
SELECT * FROM Products
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE CategoryName IN ('Beverages', 'Produce')

-- 5. Alle Produkte der Category "Beverages" (Tabelle Categories)
SELECT * FROM Products
JOIN Categories ON Categories.CategoryID = Products.CategoryID
WHERE CategoryName  = 'Beverages'

------------------------------------------
-- OUTER Joins: left/right und FULL OUTER JOIN

-- LEFT:
-- Alle Datensätze aus der Linken Tabelle, auch wenn es keine passende Verknüpfung gibt
SELECT * FROM Orders as o
LEFT JOIN Customers as cus ON o.CustomerID = cus.CustomerID
-- Bestellungen, die von keinem Kunden getätigt wurde

-- RIGHT:
-- Alle Datensätze aus der Rechten Tabelle, auch wenn es keine passende Verknüpfung gibt
-- Kunden, die noch nicht bestellt haben
SELECT * FROM Orders as o -- Z.189 & Z.502
RIGHT JOIN Customers as cus ON o.CustomerID = cus.CustomerID

-- FULL OUTER:
-- Kunden ohne Bestellungen und Bestellungen ohne Kunden werden angezeigt
SELECT * FROM Orders
FULL OUTER JOIN Customers ON Orders.CustomerID = Customers.CustomerID

-- JOIN "invertieren", d.h keine Schnittmenge anzeigen, durch filtern nach Null
SELECT * FROM Orders as o 
RIGHT JOIN Customers as cus ON o.CustomerID = cus.CustomerID
WHERE o.OrderID IS NULL

-- CROSS JOIN: Erstellt karthesischen Produkt zweier Tabellen (A x B)
SELECT * FROM Orders CROSS JOIN Customers -- (91 x 830)

-- SELF JOIN
SELECT E1.EmployeeID, E1.LastName as Vorgesetzter, E2.EmployeeID, E2.LastName as Angestellter
FROM Employees as E1
JOIN Employees as E2 ON E1.EmployeeID = E2.ReportsTo