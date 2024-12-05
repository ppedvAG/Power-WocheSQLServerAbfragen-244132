/*
	Dateigruppen:
	Datenbank aufteilen auf mehrere Dateien, und verschiedene Datentr�ger in weiterer Folge
	[PRIMARY]: Hauptgruppe, existiert immer, enth�lt standardm��ig alle Dateien

	Das Hauptfile hat die Endung .mdf
	Weitere Files haben die Endung .ndf
	Log Files haben die Endung .ldf
*/

USE SchulungDezember

/*
	Rechtsklick auf die DB => Eigenschaften
	Dateigruppen
		- Hinzuf�gen, Name vergeben
	Dateien
		- Hinzuf�gen, Name vergeben, Maximale Gr��e, Pfad, Dateinamen
*/

CREATE TABLE M002_FG
(
	id int identity,
	test char(4100)
)

INSERT INTO M002_FG
VALUES('YYY')
GO 20000

-- Wie verschiebe ich eine Tabelle auf eine andere Dateigruppe?
-- Neu erstellen, Datenverschieben, alte Tabelle l�schen
CREATE TABLE M002_FG_Aktiv
(
	id int identity,
	test char(4100)
) ON Aktiv


INSERT INTO M002_FG_Aktiv
SELECT * FROM M002_FG

--> Identity entfernen per Designer und danach wieder hinzuf�gen
--> Extras => Optionen => Designer => 
-- Speichern von �nderungen verhindern, 
-- die die Neuerstellung der Tabelle erfordern (hacken rausnehmen)

SELECT * from M002_FG_Aktiv

-- Salamitaktik
-- Ziel: Gro�e Tabellen in kleinere Tabellen aufteilen
-- mit partitionierte Sicht

CREATE TABLE M002_Umsatz
(
	datum date,
	umsatz float
)

-- Perfomante Datens�tze inserten
BEGIN TRANSACTION
DECLARE @i int = 0
WHILE @i < 100000
BEGIN
	INSERT INTO M002_Umsatz VALUES
	(DATEADD(DAY, FLOOR(RAND() *1095), '01.01.2021'), RAND() * 1000)
	SET @i += 1
END 
COMMIT
	
SELECT * FROM M002_Umsatz 
ORDER BY datum DESC


CREATE TABLE M002_Umsatz2021
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2021
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2021
------------------------------------------------------
CREATE TABLE M002_Umsatz2022
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2022
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2022
------------------------------------------------------
CREATE TABLE M002_Umsatz2023
(
	datum date,
	umsatz float
)

INSERT INTO M002_Umsatz2023
SELECT * FROM M002_Umsatz WHERE YEAR(datum) = 2023

-- Indizierte Sicht
-- View, welche nur auf die Unterliegenden Tabellen greift, welche auch ben�tigt werden

CREATE VIEW UmsatzGesamt
AS
SELECT * FROM M002_Umsatz2021
UNION ALL
SELECT * FROM M002_Umsatz2022
UNION ALL
SELECT * FROM M002_Umsatz2023

SELECT * FROM UmsatzGesamt
WHERE datum BETWEEN '01.01.2021' AND '31.12.2021'
