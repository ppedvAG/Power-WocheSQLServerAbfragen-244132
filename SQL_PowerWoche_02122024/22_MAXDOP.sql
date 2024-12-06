-- MAXDOP

-- Maximum Degree of Parallelism
-- Steuerung der Anzahl Prozessorkerne pro Abfrage
-- Parallelisierung passiert von alleine

-- Kann auf drei ebenen gesetzt werden
-- Abfrage - Datenbank - Server

SET STATISTICS TIME, io ON

SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
-- Diese Abfrage wird parallelisiert durch die Zwei schwarzen Pfeile in dem gelben Kreis
-- Abfrageplan


SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 1)
-- CPU-Zeit = 828ms, verstrichene Zeit = 1663ms

SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 2)
-- CPU-Zeit = 1250ms, verstrichene Zeit = 2161ms

SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 4)
-- CPU-Zeit = 986ms, verstrichene Zeit = 1334ms

SELECT Freight, FirstName, LastName
FROM M005_Index
WHERE Freight > (SELECT AVG(Freight) FROM M005_Index)
OPTION(MAXDOP 8)
-- CPu-Zeit = 952ms, verstrichene Zeit = 1354ms