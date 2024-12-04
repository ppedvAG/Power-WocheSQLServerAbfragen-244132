USE Northwind
GO
-- Stored Procedures / gespeicherte Prozeduren

/*
	- Gespeicherte SQL Anweisungen (Nicht nur SELECT, sondern auch alles andere)
	- Arbeiten mit Variablen
*/

CREATE PROCEDURE spOrderID @OrderID INT
AS
SELECT * FROM Orders
WHERE OrderID = @OrderID
GO

-- Prozedur ausführen
EXEC spOrderID 10253
GO

-- Prozedur INSERT
CREATE PROCEDURE spNeuerKunde
@CustomerID char(5), @CompanyName varchar(40),
@Country varchar(30), @City varchar(30)
AS
INSERT INTO Customers (CustomerID, CompanyName, Country, City)
VALUES (@CustomerID, @CompanyName, @Country, @City)
GO

EXEC spNeuerKunde ALDIS, PPEDVAG, Deutschland, Burghausen
EXEC spNeuerKunde ALDIS, 'PPEDV AG', Deutschland, Burghausen

SELECT * FROM Customers
GO
-- Default Werte:
CREATE PROCEDURE spKundenFilter
@Country varchar(50) = 'Germany',
@City varchar(50) = 'Berlin'
AS
SELECT * FROM Customers WHERE Country = @Country
AND City = @City

EXEC spKundenFilter France, Paris
GO
-- 1. Erstelle eine Procedure, der man als Parameter eine OrderID übergeben kann.
-- Bei Ausführung soll der Rechnungsbetrag dieser Order ausgegeben werden 
-- SUM(Quantity * UnitPrice + Freight) = RechnungsSumme.
CREATE PROCEDURE sp_RechnungsSumme @OrderID INT
AS
SELECT Orders.OrderID, SUM(Quantity * UnitPrice + Freight) as RechnungsSumme
FROM Orders JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
WHERE Orders.OrderID = @OrderID
GROUP BY Orders.OrderID

EXEC sp_RechnungsSumme 10248


-- Für Samuel:
-- 1. Wieviel Umsatz haben wir in jedem Geschäftsjahr insgesamt gemacht?
SELECT DATEPART(YEAR, OrderDate) as Geschäftsjahr,
SUM(SummeBestPosi) as GesamtUmsatz FROm vRechnungsDaten
GROUP BY DATEPART(YEAR, OrderDate)
ORDER BY Geschäftsjahr

-- 2. Wieviel Umsatz haben wir in Q1 1998 mit Kunden aus den USA gemacht?
SELECT SUM(SummeBestPosi) AS GesamtUmsatz FROM vRechnungsDaten
WHERE Country = 'USA' AND DATEPART(YEAR,OrderDate) = 1998
AND DATEPART(QUARTER, OrderDate) = 1