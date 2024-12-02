/*

	Datentypen in SQL: 3 große Gruppen


	1. Charakter/String Datentypen (pro Charakter = 1 Byte)
	char(10)		= 'Hallo     ' = 10 Byte Speicherplatz = UTF-8
	nchar(10)		= 'Hallo     ' = 20 Byte Speicherplatz = UTF-16

	varchar(10)		= 'Hallo'	   = 5 Byte Speicherplatz  = UTF-8
	nvarchar(10)    = 'Hallo'	   = 10 Byte Speicherplatz = UTF-16

	Legacy: text --> mittlerweile VARCHAR(MAX) = bis zu 2 GB groß
	varchar(8000) & nvarchar(4000) sind maximum


	2. Numerischen Datentypen
	tinyint = 8 Bit = 1 Byte = -255 bis +255
	smallint 16 Bit = 2 Byte = -32k bis +32k
	int = 32 Bit = 4 Byte = -2,14Mrd bis +2,14Mrd
	bigint = 64 Bit = 8 Byte = -9,2Tri bis +9,2Tri

	bit = 1 oder 0 (True = 1, False = 0) => Es gibt kein Bool!

	decimal(x, y) = x Ziffern insgesamt, davon sind y Nachkommastellen
	decimal(10,2) = 10 Ziffern insgesamt, davon sind 2 Nachkommastellen
	money = ca. 9,2 Trillion
	smallmoney = ca. 214k

	float(n) = bis 53
	1-24 = 7 Stellen = 4 Byte
	25-53 = 15 Stellen = 8 Byte

	real = 4 Byte


	3. Datum/Zeit Datentypen
	time = hh:mm:ss.nnnnnnn
	date = YYYY-MM-DD
	datetime = date + time in MS = YYYY-MM-DD hh:mm:ss.mmm
	datetime2 = YYYY-MM-DD hh:mm:ss.nnnnnnn
	smalldatetime = bis sekunden = YYYY-MM-DD hh:mm:ss

	Andere:
	XML
	JSON
	geometry
	geography
*/