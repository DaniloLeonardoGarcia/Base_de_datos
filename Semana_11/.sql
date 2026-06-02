CREATE TABLE Ventas (
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    Vendedor VARCHAR(50),
    Producto VARCHAR(50),
    Monto DECIMAL(10,2),
    Cantidad INT,
    Fecha DATE
);

INSERT INTO Ventas (Vendedor, Producto, Monto, Cantidad, Fecha) VALUES
('Juan', 'Laptop', 1200.00, 2, '2026-01-15'),
('Maria', 'Mouse', 25.00, 10, '2026-01-16'),
('Juan', 'Teclado', 45.00, 5, '2026-01-17'),
('Carlos', 'Laptop', 1150.00, 1, '2026-01-18'),
('Maria', 'Monitor', 350.00, 3, '2026-01-19'),
('Juan', 'Mouse', 30.00, 8, '2026-01-20'),
('Carlos', 'Teclado', 50.00, 4, '2026-01-21'),
('Ana', 'Monitor', 380.00, 2, '2026-01-22'),
('Maria', 'Laptop', 1250.00, 1, '2026-01-23'),
('Carlos', 'Mouse', 28.00, 15, '2026-01-24');

SELECT 
    SUM(Monto) AS TotalVentas,
    AVG(Monto) AS PromedioVenta,
    MAX(Monto) AS VentaMasAlta,
    MIN(Monto) AS VentaMasBaja,
    COUNT(*) AS TotalTransacciones
FROM Ventas;

SELECT 
    Vendedor,
    SUM(Monto) AS TotalVentas,
    COUNT(*) AS CantidadVentas,
    AVG(Monto) AS PromedioPorVenta,
    MAX(Monto) AS MayorVenta
FROM Ventas
GROUP BY Vendedor
ORDER BY TotalVentas DESC;

SELECT 
    Vendedor,
    SUM(Monto) AS TotalVentas,
    COUNT(*) AS CantidadVentas
FROM Ventas
GROUP BY Vendedor
HAVING SUM(Monto) > 1000  
ORDER BY TotalVentas DESC;

SELECT 
    Vendedor,
    Producto,
    SUM(Monto) AS TotalPorProducto,
    SUM(Cantidad) AS UnidadesVendidas
FROM Ventas
GROUP BY Vendedor, Producto
ORDER BY Vendedor, TotalPorProducto DESC;
