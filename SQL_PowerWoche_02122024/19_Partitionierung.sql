/*
	Partitionierung:
	Aufteilung in "mehrere" Tabellen
	Einzelne Tabellen bleiben bestehen, aber intern werden die Daten partitioniert

	Anforderungen:
	Partitionsfunktion: Stellt die Bereiche dar (0-100, 101-200, 201-Ende)
	Partitionsschema: Weist die einzelnen Partitionen auf Dateigruppen zu
*/

-- 0-100-200-Ende
CREATE PARTITION FUNCTION pf_Zahl(int) AS
RANGE LEFT FOR VALUES (100, 200)

-- Für ein Partitionsschema muss immer eine extra Dateigruppe existieren
CREATE PARTITION SCHEME sch_ID as
PARTITION pf_Zahl TO (P1, P2, P3)


-- Dateigruppen erstellen
ALTER DATABASE SchulungDezember ADD FILEGROUP P1

-- Datei erstellen
ALTER DATABASE SchulungDezember 
ADD FILE 
(
	NAME = 'P1',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLKURS\MSSQL\DATA\P1_Datei.ndf',
	SIZE = 8192KB,
	FILEGROWTH = 65536KB
)
TO FILEGROUP P1

-- Partitionsschema auf die Tabelle legen
CREATE TABLE M003_Test
(
	id int identity,
	zahl float
) ON sch_ID(id)

-- Befüllen der Tabelle
BEGIN TRAN
DECLARE @i INT = 0;
WHILE @i < 1000
BEGIN
	INSERT INTO M003_Test VALUES (RAND() * 1000)
	SET @i += 1
END 
COMMIT

-- Nichts besonderes zu sehen
SELECT * FROM M003_Test

-- Übersicht über die Partition verschaffen
SELECT OBJECT_NAME(OBJECT_ID), * FROM sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED')

-- Partition prüfen ob sie funktioniert
SELECT $partition.pf_Zahl(50)
SELECT $partition.pf_Zahl(150)
SELECT $partition.pf_Zahl(250)

SELECT * FROM sys.filegroups
SELECT * FROM sys.allocation_units

-- Pro Datensatz die Partition + Filgroup anhängen
SELECT * FROM M003_Test as t
JOIN
(
	SELECT name, ips.partition_number
	FROM sys.filegroups as fg 

	JOIN sys.allocation_units  as au
	on fg.data_space_id = au.data_space_id

	JOIN sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED') as ips
	ON ips.hobt_id = au.container_id

	WHERE OBJECT_NAME(ips.object_id) = 'M003_Test'
) x
ON $partition.pf_Zahl(t.id) = x.partition_number

-- Erstellt eine Aufteilung in den Bereichen 
-- Bereiche:
/*
	01.01.2021 - 31.12.2021
	01.01.2022 - 31.12.2022
	01.01.2023 - 31.12.2023
*/
-- Partitionsschema, partitionsfunktion erstellen

CREATE PARTITION FUNCTION pf_Datum(Date) as
RANGE LEFT FOR VALUES('31.12.2021', '31.12.2022', '31.12.2023')

CREATE PARTITION SCHEME sch_Datum AS
PARTITION pf_Datum TO (Datum1, Datum2, Datum3, Datum4)

CREATE TABLE DatumPartition
(
	Datum date,
	Umsatz float
) ON sch_Datum(Datum)

INSERT INTO DatumPartition
SELECT * FROM UmsatzGesamt

SELECT MIN(Datum), MAX(Datum), partition_number FROM DatumPartition t
JOIN
(
	SELECT name, ips.partition_number
	FROM sys.filegroups fg --Name

	JOIN sys.allocation_units au
	ON fg.data_space_id = au.data_space_id

	JOIN sys.dm_db_index_physical_stats(DB_ID(), 0, -1, 0, 'DETAILED') ips
	ON ips.hobt_id = au.container_id

	WHERE OBJECT_NAME(ips.object_id) = 'DatumPartition'
) x
ON $partition.pf_Datum(t.datum) = x.partition_number
GROUP BY partition_number
