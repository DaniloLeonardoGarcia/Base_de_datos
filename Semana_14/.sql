Create database Semana13

USE Semana13;

IF OBJECT_ID('dbo.Cuentas', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Cuentas (
        ID INT PRIMARY KEY,
        Saldo DECIMAL(10,2) NOT NULL DEFAULT 0.00
    );
END

MERGE INTO Cuentas AS target
USING (VALUES (1, 1000.00), (2, 500.00)) AS source (ID, Saldo)
ON target.ID = source.ID
WHEN MATCHED THEN 
    UPDATE SET target.Saldo = source.Saldo
WHEN NOT MATCHED THEN 
    INSERT (ID, Saldo) VALUES (source.ID, source.Saldo);

SELECT * FROM Cuentas;

BEGIN TRANSACTION;

UPDATE Cuentas 
SET Saldo = Saldo - 150.00 
WHERE ID = 1;

UPDATE Cuentas 
SET Saldo = Saldo + 150.00 
WHERE ID = 2;

COMMIT TRANSACTION;

SELECT * FROM Cuentas;

BEGIN TRANSACTION;

UPDATE Cuentas 
SET Saldo = Saldo - 200.00 
WHERE ID = 1;

UPDATE Cuentas 
SET Saldo = Saldo + 200.00 
WHERE ID = 2;

ROLLBACK TRANSACTION;


SELECT * FROM Cuentas;
