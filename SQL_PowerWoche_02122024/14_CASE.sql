USE Northwind

-- CASE - unterscheiden wir definierte F�lle, die die Ausgabe ab�ndern

-- Wenn ein Fall gefunden wurde, dann passiert xyz, wenn nicht dann ist das Ergebnis NULL
SELECT UnitsInStock,
CASE
	WHEN UnitsInStock < 20 THEN 'Muss nachbestellt werden!!'
	WHEN UnitsInStock >= 20 THEN 'Ja das passt!!'
END as Pr�fung
FROM Products

-- Alternativ mit ELSE einen "Notausgang" definieren:
SELECT UnitsInStock,
CASE
	WHEN UnitsInStock < 20 THEN 'Muss nachbestellt werden!!'
	WHEN UnitsInStock >= 20 THEN 'Ja das passt!!'
	ELSE 'Fehler!'
END as Pr�fung
FROM Products

-- UPDATE:
UPDATE Customers
SET City =
CASE
	WHEN Country = 'Germany' THEN 'Berlin'
	WHEN Country = 'France' THEN 'Paris'
	ELSE City
END

-- Case fall muss ins GROUP BY kopiert werden damit das Aggregieren funktioniert
SELECT SUM(UnitsInStock),
CASE
	WHEN UnitsInStock < 20 THEN 'Muss nachbestellt werden!!'
	WHEN UnitsInStock >= 20 THEN 'Ja das passt!!'
	ELSE 'Fehler!'
END as Pr�fung
FROM Products
group by
CASE
	WHEN UnitsInStock < 20 THEN 'Muss nachbestellt werden!!'
	WHEN UnitsInStock >= 20 THEN 'Ja das passt!!'
	ELSE 'Fehler!'
END