-- Limpieza de datos

---Total de registros = 541909
---406.829 registros con CustomerID
---135.080 registros sin CustomerID
;WITH online_retail AS
(
	SELECT [InvoiceNo]
		  ,[StockCode]
		  ,[Description]
		  ,[Quantity]
		  ,[InvoiceDate]
		  ,[UnitPrice]
		  ,[CustomerID]
		  ,[Country]
	  FROM [Portafolio].[dbo].[Online_Retai_Cohorte]
	  WHERE CustomerID != 0
)

---Filtra los registros cuya cantidad y precio unitario sea mayor a 0 para excluir devoluciones
, Cantidad_unidad_precio as
(
		---397.882 registros con catidad y unidad de precio > 0
		select *
		from online_retail
		where Quantity > 0 and UnitPrice > 0
)
,registros_duplicados as
(
	select *,ROW_NUMBER() over (partition by InvoiceNo, StockCode, Quantity order by InvoiceDate)as flag_duplicados
	from Cantidad_unidad_precio
)

---392.667 Regitros limpios
---5.215 datos repetidos 

select * 
into #online_retail_data_clean
from registros_duplicados 
where flag_duplicados = 1

select * from #online_retail_data_clean