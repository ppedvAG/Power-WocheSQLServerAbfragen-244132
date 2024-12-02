USE Northwind

-- WHERE: filtern Ergebniszeilen
SELECT * FROM Customers
WHERE Country = 'Germany'

SELECT * FROM Customers
WHERE Country = 'Germany '

-- = nach exakten Werten sucht
SELECT * FROM Customers
WHERE Country = ' Germany'

-- alle boolschen Vergleichsoperatoren verwenden
-- (!= bzw. <>, <=, >=, <, >)

SELECT * FROM Orders
WHERE Freight > 500

SELECT * FROM Orders
WHERE Freight < 500

SELECT * FROM Customers
WHERE Country != 'Germany'

-- Kombinieren von WHERE Ausdrücken mit AND oder OR
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

SELECT * FROM Customers
WHERE Country = 'Germany' AND Country = 'France'

SELECT * FROM Customers
WHERE Country = 'Germany' OR Country = 'France'

-- AND = Beide Bedingungen wahr sein
-- OR = Muss eine Bedingung von beiden wahr sein
-- Können beliebig kombiniert werden

-- "Vorsicht" bei Kombination von AND und OR
SELECT * FROM Customers
WHERE (City = 'Paris' OR City = 'Berlin') AND Country = 'Germany'
-- AND "ist stärker bindent" als OR; Notfalls klammern setzen!

SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 500

-- Alternativ mit BETWEEN, Randwerte mit Inbegriffen
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500

SELECT * FROM Customers
WHERE Country = 'Brazil' OR Country = 'Germany'
OR Country = 'France' OR Country = 'Austria'

-- Alternative: IN (Wert1, Wert2, Wert3)
SELECT * FROM Customers
WHERE Country IN ('Brazil', 'Germany', 'France', 'Austria')
-- IN verbindet mehrere OR Bedingungen di sich auf die selbe Spalte aber beziehen

-- Übung:
-- 1. Alle ContactNames die als Title "Owner" haben
SELECT * FROM Customers
WHERE ContactTitle = 'Owner'

-- 2. Alle [Order Details] die ProductID 43 bestellt haben
SELECT * FROM [Order Details]
WHERE ProductID = 43

-- 3. Alle Kunden aus Paris, Berlin, Madrid oder Brasilien
SELECT * FROM Customers
WHERE City IN ('Paris', 'Berlin', 'Madrid') OR Country = 'Brazil'

-- Bonus: Alle Kunden rausbekommen, die keine Fax Nummer haben
SELECT * FROM Customers
WHERE Fax IS NULL