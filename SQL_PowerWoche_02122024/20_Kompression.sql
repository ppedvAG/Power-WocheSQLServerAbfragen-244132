/*
	Kompression

	Daten verkleinern
	--> Weniger Daten werden geladen, weniger Speicherplatz, bessere Performance?
	--> beim komprimieren wird CPU Leistung verwendet

	Zwei verschiedene Typen
	-- Page Compression: 75%
	-- Row Compression: 50%
*/

USE Northwind
SELECT  Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Orders.Freight, Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.Address, Customers.City, 
        Customers.Region, Customers.PostalCode, Customers.Country, Customers.Phone, Orders.OrderID, Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title, [Order Details].UnitPrice, 
        [Order Details].Quantity, [Order Details].Discount, Products.ProductID, Products.ProductName, Products.UnitsInStock
INTO SchulungDezember.dbo.M004_Kompression
FROM    [Order Details] INNER JOIN
        Products ON Products.ProductID = [Order Details].ProductID INNER JOIN
        Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
        Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
        Customers ON Orders.CustomerID = Customers.CustomerID

USE SchulungDezember
INSERT INTO M004_Kompression
SELECT * FROM M004_Kompression
GO 8

SELECT * FROM M004_Kompression

SET STATISTICS TIME, IO ON

-- Ohne Kompression: logische Lesevorgänge: 28417, CPU-Zeit = 1625ms, verstrichene Zeit = 9183ms
SELECT * FROM M004_Kompression

-- Rechtsklick auf Tabelle => Speicher => Komprimierung verwalten

-- Row Kompression
USE [SchulungDezember]
ALTER TABLE [dbo].[M004_Kompression] REBUILD PARTITION = ALL
WITH
(DATA_COMPRESSION = ROW)

-- Row Kompression: logische Lesevorgänge: 15943, CPU-Zeit = 2750ms, verstrichene Zeit = 11464ms
SELECT * FROM M004_Kompression


-- Page Kompression
USE [SchulungDezember]
ALTER TABLE [dbo].[M004_Kompression] REBUILD PARTITION = ALL
WITH
(DATA_COMPRESSION = PAGE)


-- Page Kompression: logische Lesevorgänge: 7652, CPU-Zeit = 3812ms, verstrichene Zeit = 12090ms
SELECT * FROM M004_Kompression

-- Partitionen können auch komprimiert werden
SELECT OBJECT_NAME(OBJECT_ID), * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')
WHERE compressed_page_count != 0

-- Alle Kompressionen ausgeben
SELECT t.name as TableName, p.partition_number as PartitionsNumber, p.data_compression_desc AS Compression
FROM sys.partitions as p
JOIN sys.tables as t on t.object_id = p.object_id