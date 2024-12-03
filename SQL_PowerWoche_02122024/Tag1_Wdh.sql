-- SELECT, ORDER BY, TOP X

/*
	SELECT: w�hlt eine oder mehrere Spalten aus einer Tabelle

	ORDER BY: Ordnet die Spalte
	ASC: Ascending = aufsteigend
	DESC: Descending = absteigend

	TOP X: Gibt die obersten X Zeilen aus der Tabelle aus


	WHERE: Datens�tzen filtern
	IN & BETWEEN
	Operatoren: =, !=, <, >, <=, >=

	LIKE: Ungenauere Filterung
	(keine Vergleichsoperatoren, stattdessen LIKE)
	Wildcards: 
	% = Beliebige Zeichen danach oder davor
	_ = Nur ein Zeichen
	^ = Nicht-Fall = "[^123]"
	[] = Alles was in den Klammern ist, ist g�ltig
	Sonderf�lle:
	Prozentfiltern: '%[%]%'
	Hochkommer:		'%['']%'


	UNION: F�hrt mehrere Abfragen vertikal ein
	Datentypen m�ssen gleich sein, Spaltenanzahl muss 
	UNION macht ein automatisches DISTINCT

	Datentypen:
	char, varchar, nvarchar, nchar, int, smallint, bigint, tinyint,
	float, decimal(x, y), date, datetime, datetime2, geography, smalldatetime, time

	JOINS:
	Left/Right Join, Inner Join,  Full Outer Join, Self Join, Cross join

	Views: 
	Eine Ansicht �ber eine Abfrage
	- Sicherheit: User nur Rechte vergeben die er haben darf
	- Automatisieren von Code (zum teil)
	- Aktuelle Daten weil Abfrage immer abgerufen wird
	- Komplexere Abfragen reinspeichern
*/