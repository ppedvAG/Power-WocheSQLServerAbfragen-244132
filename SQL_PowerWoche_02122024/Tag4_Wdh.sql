/*
	Kompression:
	- Daten verkleinert: CPU-Leistung wird verwendet
	Row Kompression, Page Kompression

	SET STATISTICS time, IO ON/OFF

	Partitionierung:
	- Partitionierte Sicht
	- indizierte Sicht
	- physikalische Partitionierung:
		=> Partitionsfunktion: Legen wir auf das Schema, Grenzbereiche einstellen
		=> Partitionsschema:   Grenzbereiche auf die jeweiligen Dateigruppen legen => Partitionsschema auf Tabelle legen

	Befehl zum Pr�fen der Partition:
	SELECT $partition.[Partitionsfunktion](Spalte)
	SELECT $partition.pf_Zahl(100)

	

	Dateigruppen:
	- Datenbank aufteilen in mehrere Dateien, auf verschiedene Datentr�ger auslagern
	Dateien:
	- .mdf = Hautpfile = PRIMARY
	- .ndf = Weitere Dateien
	- .ldf = LogFiles

	DB Design:
	- Performance von der Datenbank
	 Seiten und Bl�cke
	- Seite: 8 kB = 8192B - 132B Management Daten = 8060B tats�chliche Daten
	- 1 Block = 8 Seiten
	char(4100)

*/