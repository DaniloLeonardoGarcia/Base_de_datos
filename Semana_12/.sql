create database empresa
use empresa

CREATE TABLE empleados (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha_nacimiento DATE,
    puesto VARCHAR(50),
    salario DECIMAL(10,2)
);

CREATE TABLE ventas (
    id_venta INT PRIMARY KEY,
    id_empleado INT,
    fecha_venta DATETIME,
    cantidad INT,
    monto DECIMAL(10,2)
);

INSERT INTO empleados (id, nombre, apellido, fecha_nacimiento, puesto, salario) VALUES
(1, 'Juan', 'Perez', '1995-03-15', 'Vendedor', 1800.50),
(2, 'Maria', 'Lopez', '1998-07-22', 'Asistente', 1200.00),
(3, 'Carlos', 'Ramirez', '1990-11-05', 'Supervisor', 2500.75),
(4, 'Ana', 'Torres', '2000-01-30', 'Vendedor', 1600.00);

INSERT INTO ventas (id_venta, id_empleado, fecha_venta, cantidad, monto) VALUES
(1, 1, '2025-01-10 09:30:00', 45, 1250.00),
(2, 1, '2025-02-15 14:20:00', 120, 3200.50),
(3, 2, '2025-03-05 11:00:00', 30, 800.00),
(4, 3, '2025-02-20 16:45:00', 80, 4500.00),
(5, 4, '2025-03-01 10:15:00', 55, 1400.00);

SELECT nombre, apellido, puesto
FROM empleados
WHERE id IN (SELECT id_empleado 
             FROM ventas 
             WHERE cantidad > 50);

SELECT nombre, apellido
FROM empleados e
WHERE EXISTS (SELECT 1 
              FROM ventas v 
              WHERE e.id = v.id_empleado 
                AND v.cantidad > 50);

SELECT 
    GETDATE() AS FechaActual,
    DAY(GETDATE()) AS Dia,
    MONTH(GETDATE()) AS Mes,
    YEAR(GETDATE()) AS Año,
    DATEADD(DAY, 30, GETDATE()) AS FechaMas30Dias,
    DATEDIFF(DAY, '2025-01-01', GETDATE()) AS DiasTranscurridos;

SELECT 
    nombre,
    fecha_nacimiento,
    DATEDIFF(YEAR, fecha_nacimiento, GETDATE()) AS EdadAprox,
    CONVERT(VARCHAR, fecha_nacimiento, 103) AS FechaNacimientoDDMMYYYY
FROM empleados;

SELECT 
    nombre,
    apellido,
    CONCAT(nombre, ' ', apellido) AS NombreCompleto,
    UPPER(nombre) AS NombreMayus,
    LOWER(apellido) AS ApellidoMinus,
    LEN(nombre) AS LongitudNombre,
    SUBSTRING(nombre, 1, 3) AS PrimerasTresLetras,
    LTRIM(RTRIM(puesto)) AS PuestoLimpio
FROM empleados;

SELECT 
    salario,
    CAST(salario AS INT) AS SalarioEntero,
    CONVERT(VARCHAR, salario, 1) AS SalarioFormateado,
    CONVERT(VARCHAR, GETDATE(), 103) AS FechaDDMMYYYY,
    CONVERT(VARCHAR, GETDATE(), 112) AS FechaYYYYMMDD
FROM empleados;

SELECT 
    CONCAT(e.nombre, ' ', e.apellido) AS NombreCompleto,
    UPPER(e.puesto) AS Puesto,
    
    DATEDIFF(YEAR, e.fecha_nacimiento, GETDATE()) AS Edad,
    CONVERT(VARCHAR, MAX(v.fecha_venta), 103) AS UltimaVenta,
    
    CAST(AVG(v.monto) AS DECIMAL(10,2)) AS PromedioVenta,
    
    CASE WHEN EXISTS (SELECT 1 FROM ventas WHERE id_empleado = e.id AND cantidad > 100) 
         THEN 'Excelente' ELSE 'Regular' END AS Rendimiento

FROM empleados e
LEFT JOIN ventas v ON e.id = v.id_empleado
GROUP BY e.id, e.nombre, e.apellido, e.puesto, e.fecha_nacimiento
ORDER BY Edad DESC;
