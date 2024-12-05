-- JOIN

/*
	SQL Server versucht aus einer Reihe von Ausführungsplänen,
	die er vorab ermittelt den günstigsten herauszufinden

	Meist stimmt dies, Allerdings kann man "Auffälligkeiten" entdecken
		
		- unter anderem tauchen "Sortieroperatoren" auf, obwohl kein 
		order by zu finden ist. Das kann an den JOIN Methoden liegen


	inner hash join
	Es wird eine Hashtabelle zu ermitteln der übereinstimmenden 
	JOIN Spalten der Tabellen
	Gilt bei großen Tabellen, leicht parallelisierbar

	inner merge join
	beide Tabellen werden jeweils einmal durchsucht (gleichzeitig)
	das kann aber nur funktionieren wenn sie Sortiert sind
	(entweder durch CLustered Index oder Sortier Operator)

	inner loop join
	kleine Tabelle wird zeilenweise durchlaufen 
	=> wird in der größeren Tabelle nach dem Wert gesucht


*/

SELECT * FROM Customers
INNER HASH JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT * FROM Customers
INNER MERGE JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT * FROM Customers
INNER LOOP JOIN Orders ON Customers.CustomerID = Orders.CustomerID