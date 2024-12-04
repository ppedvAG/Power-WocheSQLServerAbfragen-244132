USE Northwind

-- Variablen allgemein:

DECLARE @OrderID INT = 10250

SELECT * FROM Orders
WHERE OrderID = @OrderID

set @OrderID = 10251

SELECT * FROM Orders
WHERE OrderID = @OrderID

-- WHILE Schleife

DECLARE @Counter INT = 0

WHILE @Counter <= 5
BEGIN
SELECT 'Hallo'
SET @Counter = @Counter + 1
END

-- Endlosschleife, aufpassen auf den Computer:
WHILE 1=1
BEGIN
SELECT 'Hallo'
END