create table Alumno(
        cuil integer,
        nya varchar(30),
        fNac date,
        domi varchar(30),
        tel bigint,
        carr varchar(30),
        NomL varchar(30)
);

create table TipoBeca(
        codB integer,
        descr varchar(30),
        monto float
);

create table Obtuvo(
        cuil integer,
        codB integer,
        fD date,
        fH date
);

create table Localidad(
        nomL varchar(30),
        cantH integer
);

INSERT INTO Alumno(cuil, nya, fNac, domi, tel, carr, NomL) VALUES
(123456789, 'Juan Perez', '2000-01-01', 'Calle Falsa 123', 1234567890,
'Ingeniería', 'Localidad1'),
(987654321, 'Maria Rodriguez', '2001-02-02', 'Calle Falsa 456', 0987654321,
'Medicina', 'Localidad2'),
(234567890, 'Pedro Gomez', '2002-03-03', 'Calle Falsa 789', 2345678901,
'Arquitectura', 'Localidad3'),
(345678901, 'Laura Martinez', '2003-04-04', 'Calle Falsa 012', 3456789012,
'Derecho', 'Localidad4'),
(456789012, 'Lucas Sanchez', '2004-05-05', 'Calle Falsa 345', 4567890123,
'Economía', 'Localidad5'),
(567890123, 'Carla Fernandez', '2005-06-06', 'Calle Falsa 678', 5678901234,
'Psicología', 'Localidad6'),
(678901234, 'Miguel Lopez', '2006-07-07', 'Calle Falsa 901', 6789012345,
'Veterinaria', 'Localidad7'),
(789012345, 'Ana Torres', '2007-08-08', 'Calle Falsa 234', 7890123456,
'Odontología', 'Localidad8'),
(890123456, 'Diego Ramirez', '2008-09-09', 'Calle Falsa 567', 8901234567,
'Enfermería', 'Localidad9'),
(901234567, 'Sofia Gonzalez', '2009-10-10', 'Calle Falsa 890', 9012345678,
'Nutrición', 'Localidad10'),
(111111111, 'Alguien','2021-05-24','Calle Falsa 1',848443838,'Nutricion','Rivadavia'),
(222222222, 'Alguien2','2000-04-21','Calle Falsa 2',32733223,'Nutricion','Rivadavia');

-- update Alumno set nomL='Rivadavia' where cuil=123456789

INSERT INTO TipoBeca(codB, descr, monto) VALUES
(1, 'Beca de estudio', 5000.00),
(103, 'Beca de transporte', 2000.00),
(3, 'Beca de comedor', 3000.00),
(100, 'Jardin Materno', 1000.00),
(5, 'Beca de Residencia', 4000.00),
(6, 'Beca de deporte', 6000.00),
(7, 'Beca de idioma', 7000.00),
(8, 'Beca de investigación', 8000.00),
(9, 'Beca de intercambio', 9000.00),
(102, 'Beca de Fotocopia', 10000.00);

INSERT INTO Obtuvo(cuil, codB, fD, fH) VALUES
(123456789, 1, '2022-01-01', '2022-12-31'),
(123456789, 103, '2022-01-01', '2022-12-31'),
(123456789, 3, '2022-01-01', '2022-12-31'),
(123456789, 100, '2022-01-01', '2022-12-31'),
(123456789, 5, '2022-01-01', '2022-12-31'),
(123456789, 6, '2022-01-01', '2022-12-31'),
(123456789, 7, '2022-01-01', '2022-12-31'),
(123456789, 8, '2022-01-01', '2022-12-31'),
(123456789, 9, '2022-01-01', '2022-12-31'),
(123456789, 102, '2022-01-01', '2022-12-31'),
(987654321, 1, '2022-01-01', '2022-12-31'),
(987654321, 3, '2022-01-01', '2022-12-31'),
(234567890, 1, '2022-01-01', '2022-12-31'),
(234567890, 5, '2022-01-01', '2022-12-31'),
(345678901, 1, '2022-01-01', '2022-12-31'),
(345678901, 100, '2022-01-01', '2022-12-31'),
(456789012, 1, '2022-01-01', '2022-12-31'),
(456789012, 6, '2022-01-01', '2022-12-31'),
(567890123, 1, '2022-01-01', '2022-12-31'),
(567890123, 7, '2022-01-01', '2022-12-31'),
(678901234, 1, '2022-01-01', '2022-12-31'),
(678901234, 8, '2022-01-01', '2022-12-31'),
(789012345, 1, '2022-01-01', '2022-12-31'),
(789012345, 9, '2022-01-01', '2022-12-31'),
(890123456, 1, '2022-01-01', '2022-12-31'),
(890123456, 102, '2022-01-01', '2022-12-31'),
(901234567, 1, '2022-01-01', '2022-12-31'),
(901234567, 103, '2022-01-01', '2022-12-31'),
(111111111, 102,'2021-03-21','2021-06-12'),
(222222222, 3,'2021-03-21','2021-06-12'),
(222222222, 5,'2021-03-21','2021-06-12');

INSERT INTO Localidad(nomL, cantH) VALUES
('Localidad1', 10000),
('Localidad2', 20000),
('Localidad3', 30000),
('Localidad4', 40000),
('Localidad5', 50000),
('Localidad6', 60000),
('Localidad7', 70000),
('Localidad8', 80000),
('Localidad9', 90000),
('Localidad10', 100000),
('Rivadavia', 100000);

--1. Alumnos (todos los datos) que accedieron a màs de un tipo de beca (diferentes) durante el 2021
select alumno.* 
	from alumno natural join (
	select cuil from obtuvo where fD >= '2021-01-01' and fD <= '2021-12-31'
	group by cuil having count(codB)>1
	)	
--2. Alumnos (cuil, nombre y apellido, y fecha de nacimiento) que nunca accedieron al tipo de beca "Jardin Materno Infantil" (codigo=100)
select cuil,nya,fNac 
	from alumno natural join obtuvo
	where codB <> 100
except
select cuil,nya,fNac 
	from alumno natural join obtuvo 
	where codB = 100
--3. Alumnos (cuil) de la localidad Rivadavia que accedieron a todos los tipos de beca.
select cuil
from alumno
where NomL = 'Rivadavia' and not exists(
	select * 
	from TipoBeca 
	where not exists (
		select * 
		from obtuvo
		where alumno.cuil =obtuvo.cuil 
		and TipoBeca.codB = obtuvo.codB)
	)
--4. Alumnos (cuil, nombre y apellido) que accedieron a las becas de "Fotocopia" (codigo=102) y/o beca de "Transporte" (codigo=103)
select cuil,nya 
from alumno natural join obtuvo
where codB = 102
	union 
select cuil,nya
from alumno natural join obtuvo 
where codB = 103
--5. Alumnos (todos los datos) que accedieron tanto a la beca de "Comedor (descripción) como a la beca de "'Residencia" (descripción).
select alumno.* 
	from alumno natural join obtuvo natural join TipoBeca 
	where descr = 'Beca de comedor'
intersect 
select alumno.* 
	from alumno natural join obtuvo natural join TipoBeca 
	where descr = 'Beca de Residencia'
--6. Obtener un listado que muestre alumnos (todos los datos) que obtuvieron solamente la beca de Fotocopia (código=102) sin importar el periodo.
select alumno.* 
	from alumno natural join obtuvo
	where codB = 102
except
select alumno.* 
	from alumno natural join obtuvo 
	where codB <>102