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

--Relacion uno a muchos

CREATE TABLE curso(
    id INT PRIMARY KEY,
    nombreCurso VARCHAR(100) NOT NULL,
    creditos INT,
    horario VARCHAR(50),
    docente INT,
    FOREIGN KEY (docente) REFERENCES docente(id)
);

INSERT INTO curso(id, nombreCurso, creditos, horario, docente) VALUES 
(101, 'Algebra I', 4, 'Lunes y Miércoles 8:00', 1),
(102, 'Geometria Analitica', 3, 'Martes y Jueves 10:00', 1),
(201, 'Historia del Peru', 3, 'Lunes y Miércoles 11:00', 2),
(301, 'Biologia General', 4, 'Martes y Jueves 8:00', 3),
(302, 'Quimica Organica', 4, 'Viernes 14:00', 3),
(401, 'Artes Plasticas', 2, 'Miércoles 15:00', 4),
(501, 'Educacion Fisica', 2, 'Lunes 16:00', NULL); 

SELECT 
    d.nombre AS Docente,
    a.nombreAreaa AS Area,
    c.nombreCurso AS Curso,
    c.creditos
FROM docente d
LEFT JOIN area a ON d.area = a.id
LEFT JOIN curso c ON d.id = c.docente
ORDER BY d.nombre, c.nombreCurso;

SELECT 
    d.nombre AS Docente,
    COUNT(c.id) AS Total_Cursos,
    SUM(c.creditos) AS Total_Creditos
FROM docente d
LEFT JOIN curso c ON d.id = c.docente
GROUP BY d.nombre;
