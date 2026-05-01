create database colegio

use colegio

create table area(
id int primary key,
nombreAreaa varchar(50)
)

create table docente(
id int primary key,
nombre varchar(50),
DNI int,
salario decimal(10,2),
area int
foreign key (area) references area(id)
)

insert into area(id, nombreAreaa) values 
(10, 'Matematicas'),
(20, 'Ciencias'),
(30, 'Sociales');

insert into docente(id, nombre, DNI, salario, area) values 
(1, 'Carlos Apaza', 74616521, 3500.00,10),
(2, 'Martin Paz', 76425341, 4000.00, 30),
(3, 'Raquel Medina', 64536421, 3700.00, 20);

insert into area(id, nombreAreaa) values (40, 'Artes');
insert into docente(id, nombre, DNI, salario, area) values (4, 'Ana Ramos', 75621314, 3200.00, NULL);

SELECT d.nombre, a.nombreAreaa
FROM docente d
INNER JOIN area a ON d.area = a.id;

SELECT d.nombre, a.nombreAreaa
FROM docente d
LEFT JOIN area a on d.area = a.id;

SELECT d.nombre, a.nombreAreaa
FROM docente d
RIGHT JOIN area a on d.area = a.id;

SELECT d.nombre, a.nombreAreaa
FROM docente d
LEFT JOIN area a on d.area = a.id;

SELECT d.nombre, a.nombreAreaa
FROM docente d
CROSS JOIN area a;

SELECT d.nombre, a.nombreAreaa
FROM docente d
FULL JOIN area a on d.area=a.id;






