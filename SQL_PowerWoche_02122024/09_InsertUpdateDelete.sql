USE Northwind

/*

	DDL: Data Definition Language
	Was wir bis jetzt hatten: DML = Data Manipulation Language

	-- CREATE / ALTER / DROP

	-- Immer wenn wir Datenbankobjekte bearbeiten gelten diese Befehle
*/

CREATE TABLE PurchasingOrders
(
	ID INT IDENTITY(1, 1) PRIMARY KEY,
	OrderDate date NOT NULL,
	ProductID int NOT NULL
)

SELECT * FROM PurchasingOrders

-- Beziehung zwischen PurchasingOrder und Products anlegen über ProductID
ALTER TABLE PurchasingOrders
ADD FOREIGN KEY (ProductID) REFERENCES Products (ProductID)

-- Neue Spalte hinzufuegen zur bestehenden Tabelle
ALTER TABLE PurchasingOrders
ADD Test INT, Test2 INT

-- Spalte aus der bestehenden Tabelle löschen:
ALTER TABLE PurchasingOrders
DROP COLUMN NeueSpalte, Test, Test2

-- Spalte nach Datentyp ändern:
ALTER TABLE PurchasingOrders
ALTER COLUMN TestDaten FLOAT NULL

-- INSERT - Hinzufügen von Datensätze in eine bestehende Tabelle


SELECT * FROM PurchasingOrders

-- Alle Spalten befuellen
INSERT INTO PurchasingOrders
VALUES (GETDATE(), 5, 2.50)

-- Explizit einzelne Spalten hinzufügen
INSERT INTO PurchasingOrders (OrderDate, ProductID)
VALUES (GETDATE(), 20)

-- Ergebnis einer SELECT-Abfrage können direkt Inserted werden
-- (Datentypen müssen kompatibel sein & Spaltenanzahl müssen übereinstimmen)
INSERT INTO PurchasingOrders
SELECT GETDATE(), 3, 10.25

/*
	DELETE - Löschen von Datensätze in einem Bestehendem Table
*/

SELECT * FROM PurchasingOrders

-- Aufpassen! Ohne WHERE Filter werden ALLE Datensätze gelöscht!
DELETE FROM PurchasingOrders
WHERE ID = 5

-- Primaer/-Fremdschlüsselbeziehungen verhindern das loeschen von Datensaetzen, wenn 
-- andere Datenstätez sonst "ins Leere laufen würden"
DELETE FROM Customers
WHERE CustomerID = 'ALFKI'

-- TRUNCATE
-- TRUNCATE TABLE PurchasingOrders

-- UPDATE - Ändern von Spaltenwerten in einem vorhandenen Datensatz

SELECT * FROM PurchasingOrders

-- TestDaten kann möglicherweise nicht erkannt werden weil der Lokale Cache
-- noch nicht aktualisiert wurde
-- => Bearbeiten => Intellisense => Lokalen Cache aktualisieren
UPDATE PurchasingOrders
SET TestDaten = NULL
WHERE ID = 1

-- Transactions

-- Rettungsanker wenn wir eine Abfrage verhauen..
BEGIN TRANSACTION
UPDATE PurchasingOrders
SET TestDaten = NULL

-- Wenn uns die Abfrage nicht passt, gehen wir zurück zu unserem Speicherstand vor dem
-- ausführen der Transaction
ROLLBACK

-- Übernehmen von unseren Änderungen
COMMIT