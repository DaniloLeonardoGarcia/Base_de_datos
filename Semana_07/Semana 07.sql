create database Deudas

use Deudas

create table deuda(
deudor varchar(50),
mes varchar(50),
monto int 
)


insert into deuda(deudor,mes,monto) values
('William', 'Enero', 500),
('Diego', 'Abril', 300),
('David', 'Febrero', 450);

update deuda
set monto= 700
where deudor='William';

delete from deuda
where deudor = 'Diego';

Select *
from(
	select deudor, mes, monto
	from deuda
) as fuente 
pivot(
sum(monto)
for mes in([Enero],[Febrero],[Abril])
)as pivotTable;
