USE Northwind

-- String Funktionen bzw. Text-Datentypen manipulationen

-- LEN gibt die laenge des Strings zurück (Anzahl Charakter) als INT
SELECT CompanyName, LEN(CompanyName) FROM Customers

-- LEFT/RIGHT geben die "linken" bzw. die "rechten" x Zeichen eines Strings zurück
SELECT CompanyName, LEFT(CompanyName, 5) FROM Customers
SELECT CompanyName, RIGHT(CompanyName, 5) FROM Customers

-- SUBSTRING(Spalte, x, y) springt zur Position x in der Spalte und gibt mir y Zeichen aus
SELECT SUBSTRING(CompanyName, 5, 5), CompanyName FROM Customers

-- STUFF(Spalte, x, y, replace) ersetzt y Zeichen eines Strings ab Position x 
-- mit "replace Wert" (optional)
SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers

-- PATINDEX sucht nach "Schema" (wie ein LIKE) in einem String und gibt Position aus,
-- an der das Schema das erste mal gefunden wurde
SELECT PATINDEX('%m%', CompanyName), CompanyName FROM Customers

-- CONCAT fügt mehrere Strings in die Selbe Spalte zusammen
SELECT FirstName + ' ' + LastName FROM Employees
SELECT CONCAT(FirstName, ' ', LastName) as GanzerName FROM Employees

-- Datumsfunktionen
SELECT GETDATE() -- aktuelle Systemzeit mit Zeitstempel

-- Zeitintervalle rausziehen können aus einem Datum
SELECT
DATEPART(YEAR, OrderDate) as Jahr,
DATEPART(QUARTER, OrderDate) as Quartal,
DATEPART(WEEK, OrderDate) AS KW,
DATEPART(WEEKDAY, OrderDate) as Wochentag,
DATEPART(HOUR, OrderDate) AS Stunde
FROM Orders

SELECT MONTH(OrderDate) as Monat, DATEPART(Q, OrderDate) as Quartal FROM Orders

-- Intervallnamen aus einem Datum ziehen
SELECT DATENAME(MONTH, OrderDate), DATENAME(WEEKDAY, OrderDate), DATEPART(WEEKDAY, OrderDate) as Wochentag
FROM Orders

-- Datum addieren/subtrahieren
SELECT DATEADD(DAY, 14, GETDATE())
SELECT DATEADD(DAY, -14, GETDATE())

-- Differenz zwischen 2 Datums
SELECT DATEDIFF(YEAR, '13.02.2005', GETDATE()) -- TT.MM.YYYY
SELECT DATEDIFF(YEAR, '2005-02-13', GETDATE())
SELECT DATEDIFF(YEAR, OrderDate, GETDATE()), OrderDate FROM Orders

SELECT CURRENT_TIMESTAMP  -- Auch Systemzeit

-- Übungen:
-- 1. Alle Bestellungen (Orders) aus Q2 in 1997
SELECT * FROM Orders
WHERE DATEPART(YEAR, OrderDate) = 1997 AND DATEPART(QUARTER, OrderDate) = 2

-- 2. Alle Produkte (ProductName) die um Weihnachtem herum (+-10 Tage) in 
--	  1996 verkauft wurden
SELECT ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE OrderDate BETWEEN '14.12.1996' AND '03.01.1997'

-- 3. Alle Bestellungen (Orders) aus den USA (Customers Country) die im Jahr 1997 aufgegeben wurden
SELECT * FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Country = 'USA' AND DATEPART(YEAR, OrderDate) = 1997

-- 4. Welches Produkt (ProductName) hatte die groeßte Bestellmenge (Quantity in OD) im Februar 1998?
SELECT TOP 1 ProductName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
WHERE DATEPART(YEAR, OrderDate) = 1998 AND DATEPART(MONTH, OrderDate) = 2
ORDER BY Quantity DESC

-- 5. Wieviele Bestellungen kamen aus Spain (Customers) in Quartal 2 1997?
--   Sind es mehr oder weniger als aus Frankreich? (2. Abfrage)
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Spain' AND DATEPART(QUARTER, OrderDate) = 2 AND
DATEPART(YEAR, OrderDate) = 1997
UNION ALL
SELECT * FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'France' AND DATEPART(QUARTER, OrderDate) = 2 AND
DATEPART(YEAR, OrderDate) = 1997

-- BONUS: Gab es Bestellungen (OrderID) an Wochenendtagen (OrderDate)?
SELECT OrderID, DATEPART(WEEKDAY, OrderDate) as Wochentag FROM Orders
WHERE DATEPART(WEEKDAY, OrderDATE) IN (6, 7)
ORDER BY Wochentag desc
 

-- Ultra Schwierig!
-- 6. Hatten wir Bestellungen, die wir zu spaet ausgeliefert haben? Wenn 
-- ja, welche OrderIDs waren das und wieviele Tage
-- waren wir zu spaet dran? (Verzoegerung = Unterschied zwischen Shipped 
-- & Required Date in Orders) Tipp: DATEDIFF & ISNULL
/* 
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
OrderID, "TageZuSpaet"
usw...
*/
SELECT OrderID, DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, GETDATE())) as TageZuSpaet
FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ISNULL(ShippedDate, GETDATE())) > 0
ORDER BY TageZuSpaet

--  CAST oder CONVERT, wandeln Datentypen in der Ausgabe um
-- konvertierung von datetime => date
SELECT CAST(OrderDate as date), OrderDate FROM Orders
SELECT CONVERT(date, OrderDate) FROM Orders

-- ISNULL prüft auf NULL Werte und ersetzt diese wenn gewünscht
SELECT ISNULL(Fax, 'Nicht vorhanden!') as KeineFax, Fax FROM Customers

-- Format: Komplexere Konvertierungen mit Format + Unterabfrage!
SELECT FORMAT((SELECT CONVERT(date, '13.02.2005')), 'D', 'de-de')

SELECT Top 5 Freight,
	FORMAT(Freight, 'N', 'de-de'),
	FORMAT(Freight, 'G', 'de-de'),
	FORMAT(Freight, 'C', 'de-de')
FROM Orders


-- REPLACE(x, y, z) => "y" sucht in "x" den String um Ihn mit "z" zu ersetzen
SELECT REPLACE('Hallo Welt!', 'Welt!', 'und Willkommen!')

-- REPLICATE(x, y) => Setze "y" mal die "x" vor die Spalte Phone
SELECT REPLICATE('0', 3) + Phone FROM Customers

-- REVERSE(Spaltenname) => "Hallo" => "ollaH" => Unnötig!
SELECT CompanyName, REVERSE(CompanyName) FROM Customers

-- TRANSLATE(inputString, chars, replace)
-- => Geben einen Inputstring an, wählen die "chars" die im "inputString" ersetzt werden sollen mit "replace"
SELECT TRANSLATE('2*[3+4]/{7-2}', '[]{}', '()()')