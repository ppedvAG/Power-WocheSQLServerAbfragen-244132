-- Abfrage Cache l�schen
dbcc freeproccache
USE Northwind

-- Pl�ne in Hashwerte gespeichert werden... 

SELECT * FROM Orders WHERE CustomerID = 'HANAR'

SELECT * FROM orders WHERE customerid = 'HANAR'

SELECT * from Orders WHERE Customerid = 'HANAR'

SELECT * FROM orders where OrderID = 10

SELECT * FROM orders where orderID = 300

SELECT * FROM orders where orderid = 50000

SELECT usecounts, cacheobjtype, [TEXT] FROM
sys.dm_exec_cached_plans p CROSS APPLY
sys.dm_exec_sql_text(plan_handle)
WHERE cacheobjtype = 'Compiled Plan'
AND [text] NOT LIKE '%dm_exec_cached_plans%'

