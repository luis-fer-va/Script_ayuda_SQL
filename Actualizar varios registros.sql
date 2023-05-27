-- 1. Crear una tabla tmp, que contendra los registros unicos y los registros a mapear.
create table map_product_line(
	map nvarchar(50)not null,product nvarchar(50)not null);
  
-- 2. Insertar los datos 
insert into map_product_line values(
(Trains,Trenes),
('Motorcycles','Motocicletas'),
('Ships','Barcos'),
('Trucks and Buses','Camiones y Autobuses'),
('Vintage Cars','Automóviles Antiguos'),
('Classic Cars','Automóviles Clásicos');
 
-- 3. Actualizar los datos
update [sales_data_sample]
set STATUS=c.tbl1
from [sales_data_sample] v
join new_status c  on v.tbl2 = c.tbl1;
