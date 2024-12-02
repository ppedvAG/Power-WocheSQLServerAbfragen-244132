USE Northwind

-- LIKE: Für ungenaue Filterung/Suche können wir dann LIKE verwenden
-- (statt Vergleichsoperatoren)

SELECT ContactTitle FROM Customers
WHERE ContactTitle = 'Owner'

-- Wildcard
-- %-Zeichen: Beliebige Symbol, beliebig viele davon
SELECT ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Owner%'

SELECT ContactName, ContactTitle from customers
WHERE ContactTitle LIKE '%Manager'

-- "_"-Zeichen: EIN beliebiges Symbol
SELECT CompanyName FROM Customers
WHERE CompanyName LIKE '_l%'

-- "[]"-Zeichen: Alles was in den Klammern ist, ist ein gültiges Symbol
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[012345]%'

-- "[a-z]" oder gegenteil mit ^ [^a-z]
SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[0-5]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[^123]%'

SELECT PostalCode FROM Customers
WHERE PostalCode LIKE '[1-3 a-g]%'

-- Sonderfälle: % '
SELECT * FROM Customers
WHERE CompanyName LIKE '%['']%'

SELECT * FROM Customers
WHERE CompanyName LIKE '%[%]%'

-- Übung:
-- 1. Alle ShipPostalCodes anzeigen lassen die mit 0, 2 oder 4 beginnen in der Tabelle "Orders"
SELECT ShipPostalCode FROM Orders
WHERE ShipPostalCode LIKE '[024]%'