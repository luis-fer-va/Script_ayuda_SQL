-- 🧹 1. Si la tabla 'sales_la_roka' ya existe, se elimina para evitar errores al crearla de nuevo
IF OBJECT_ID('dbo.sales_la_roka', 'U') IS NOT NULL
    DROP TABLE dbo.sales_la_roka;
GO

-- 📊 2. Se crea una nueva tabla 'sales_la_roka' con un PIVOT de ventas por mes para los años 2024 y 2025
SELECT
    salesMonth,                         -- Nombre del mes (Ej: Enero, Febrero)
    COALESCE([2024], 0) AS sales_2024, -- Ventas del año 2024 (rellena con 0 si no hay datos)
    COALESCE([2025], 0) AS sales_2025, -- Ventas del año 2025 (rellena con 0 si no hay datos)
    num_mes                            -- Número del mes (1=Enero, 2=Febrero...)
INTO sales_la_roka
FROM (
    SELECT 
        MONTH(Fecha) AS num_mes,           -- Número del mes
        DATENAME(month, Fecha) AS salesMonth, -- Nombre del mes
        Venta,
        YEAR(Fecha) AS Ano                 -- Año de la venta
    FROM dbo.Fact_Ventas 
) AS source
PIVOT (
    SUM(Venta)                            -- Se agregan las ventas
    FOR Ano IN ([2024], [2025])          -- Se reparten en columnas por año
) AS PivotTable;

-- 📈 3. Se crea una tabla temporal con la diferencia entre las ventas de 2025 y 2024
SELECT 
    salesMonth,
    sales_2025,
    sales_2024,
    FORMAT(sales_2025 - sales_2024, '#,##0') AS diff, -- Diferencia formateada con separador de miles
    num_mes
INTO #tmp
FROM dbo.sales_la_roka
ORDER BY num_mes;

-- 👀 4. Visualización final de los datos ordenados cronológicamente por mes
SELECT * FROM #tmp ORDER BY num_mes;
