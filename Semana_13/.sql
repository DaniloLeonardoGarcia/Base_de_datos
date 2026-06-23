Create database Semana12

USE Semana12;

IF OBJECT_ID('dbo.Empleados', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Empleados (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(50),
        Edad INT,
        Departamento NVARCHAR(50)
    );
END
GO

CREATE OR ALTER FUNCTION dbo.CalcularAreaCirculo (@Radio FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Area FLOAT;
    SET @Area = PI() * @Radio * @Radio;
    RETURN @Area;
END;
GO

CREATE OR ALTER PROCEDURE dbo.InsertarEmpleado
    @Nombre NVARCHAR(50),
    @Edad INT,
    @Departamento NVARCHAR(50)
AS
BEGIN
    INSERT INTO Empleados (Nombre, Edad, Departamento)
    VALUES (@Nombre, @Edad, @Departamento);
    PRINT 'Empleado insertado correctamente: ' + @Nombre;
END;
GO

IF OBJECT_ID('dbo.Cuentas', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Cuentas (
        ID INT PRIMARY KEY,
        Saldo DECIMAL(10,2) NOT NULL DEFAULT 0.00
    );
END
GO

INSERT INTO Cuentas (ID, Saldo) 
VALUES (1, 1000.00), (2, 500.00);
GO

SELECT dbo.CalcularAreaCirculo(5) AS AreaCirculo;
GO

EXEC dbo.InsertarEmpleado 'Juan Pérez', 30, 'Ventas';
EXEC dbo.InsertarEmpleado 'Ana Gómez', 25, 'Marketing';
GO

DECLARE @Edad INT = 25;
IF @Edad >= 18
BEGIN
    PRINT 'La persona es adulta.';
END
ELSE
BEGIN
    PRINT 'La persona es menor de edad.';
END;
GO

DECLARE @Nom NVARCHAR(50), @E INT;

DECLARE cur_empleados CURSOR FOR
SELECT Nombre, Edad FROM Empleados;

OPEN cur_empleados;
FETCH NEXT FROM cur_empleados INTO @Nom, @E;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Empleado: ' + @Nom + ' | Edad: ' + CAST(@E AS NVARCHAR);
    FETCH NEXT FROM cur_empleados INTO @Nom, @E;
END;

CLOSE cur_empleados;
DEALLOCATE cur_empleados;
GO

BEGIN TRANSACTION;

    UPDATE Cuentas SET Saldo = Saldo - 100.00 WHERE ID = 1;
    UPDATE Cuentas SET Saldo = Saldo + 100.00 WHERE ID = 2;
    
    SAVE TRANSACTION Savepoint1;

    UPDATE Cuentas SET Saldo = Saldo - 200.00 WHERE ID = 1;
    UPDATE Cuentas SET Saldo = Saldo + 200.00 WHERE ID = 2;
    
    SAVE TRANSACTION Savepoint2;

    ROLLBACK TRANSACTION Savepoint2;

COMMIT TRANSACTION;
GO

SELECT 'Saldos Finales después de Transacción con Savepoint' AS Mensaje;
SELECT * FROM Cuentas;
GO

SELECT * FROM Empleados;
