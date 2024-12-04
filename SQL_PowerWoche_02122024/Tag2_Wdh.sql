-- 1. Ist der Spediteur „Speedy Express“ 
--    über die Jahre durchschnittlich teurer geworden? (Freight pro Jahr)
SELECT CompanyName, DATEPART(YEAR, OrderDate) as Geschäftsjahr , AVG(Freight) as AvgFreight
FROM Orders 
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
WHERE CompanyName = 'Speedy Express'
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)

--SELECT CompanyName, YEAR(ShippedDate) as Jahr, AVG(Freight) as AvgFreight FROM Orders
--JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
--JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
--WHERE CompanyName = 'Speedy Express' AND Freight IS NOT NULL AND ShippedDate IS NOT NULL 
--GROUP BY CompanyName, YEAR(ShippedDate)
--ORDER BY Jahr ASC;

-- 2. Erstellen Sie einen Bericht, der die Gesamtzahl der 
-- Bestellungen nach Kunde seit dem 31. Dezember 1996 anzeigt. 
-- Der Bericht sollte nur Zeilen zurückgeben, 
-- für die die Gesamtzahl der Aufträge größer als 15 ist (5 Zeilen)
SELECT CustomerID, COUNT(OrderID) as Bestellung FROM Orders
WHERE OrderDate > '31.12.1996'
GROUP BY CustomerID
HAVING COUNT(OrderID) > 15
ORDER BY 2 DESC

-- 3. Jahrweiser Vergleich unserer 3. Spediteure: (Shippers Tabelle): 
-- Lieferkosten (Freight) gesamt, Durchschnitt (freight)
-- pro Lieferung und Anzahl an Lieferungen
/*
	Ergebnis in etwa so:
	SpediteurName, Geschäftsjahr, FreightGesamt, FreightAvg, AnzBestellungen
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1996			, xy		   , xy		   , xy
	Sped 1		 ,1996			, xy		   , xy		   , xy
	usw....
*/
SELECT CompanyName as SpediteurName,
DATEPART(YEAR, OrderDate) as Geschäftsjahr,
SUM(Freight) as FreightGesamt,
AVG(Freight) as FreightAvg,
COUNT(*) as AnzBestellungen
FROM Shippers
JOIN Orders ON Orders.ShipVia = Shippers.ShipperID
GROUP BY CompanyName, DATEPART(YEAR, OrderDate)
ORDER BY Geschäftsjahr, FreightAvg


-- BONUS: 
--„Zensiere“ alle Telefonnummern der Kunden (Phone): 
--Es sollen immer nur noch die letzten 4 Ziffern/Symbole angezeigt werden. 
--Alles davor soll mit einem X pro Symbol ersetzt werden.
--Beispiel: Phone „08677 9889 0“; danach „XXXXXXXX89 0“
SELECT STUFF(Phone, 1, LEN(Phone) - 4, REPLICATE('X', LEN(Phone) - 4)) FROM Customers
SELECT REPLICATE('X', LEN(Phone) - 4) + STUFF(Phone, 1, LEN(Phone) - 4, '') FROM Customers