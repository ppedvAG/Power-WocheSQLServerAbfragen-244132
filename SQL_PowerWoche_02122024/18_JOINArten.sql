-- JOIN

/*
	SQL Server versucht aus einer Reihe von Ausf�hrungspl�nen,
	die er vorab ermittelt den g�nstigsten herauszufinden

	Meist stimmt dies, Allerdings kann man "Auff�lligkeiten" entdecken
		
		- unter anderem tauchen "Sortieroperatoren" auf, obwohl kein 
		order by zu finden ist. Das kann an den JOIN Methoden liegen


	inner hash join
	Es wird eine Hashtabelle zu ermitteln der �bereinstimmenden 
	JOIN Spalten der Tabellen
	Gilt bei gro�en Tabellen, leicht parallelisierbar

	inner merge join
	beide Tabellen werden jeweils einmal durchsucht (gleichzeitig)
	das kann aber nur funktionieren wenn sie Sortiert sind
	(entweder durch CLustered Index oder Sortier Operator)

	inner loop join
	kleine Tabelle wird zeilenweise durchlaufen 
	=> wird in der gr��eren Tabelle nach dem Wert gesucht


*/

SELECT * FROM Customers
INNER HASH JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT * FROM Customers
INNER MERGE JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT * FROM Customers
INNER LOOP JOIN Orders ON Customers.CustomerID = Orders.CustomerID