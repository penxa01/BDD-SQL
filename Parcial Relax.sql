--Tema 2 - Parcial 2024
-- Tabla Alumno
CREATE TABLE Alumno (
    fcuil CHAR(11) PRIMARY KEY,
    nyAp VARCHAR(100),      -- Nombre y Apellido
    fNac DATE,              -- Fecha de Nacimiento
    domi VARCHAR(200),      -- Domicilio
    tel CHAR(10),           -- Teléfono
    carr VARCHAR(10),       -- Carrera
    NomL VARCHAR(50)        -- Nombre Localidad
);

-- Tabla TipoBeca
CREATE TABLE TipoBeca (
    fcodB INT PRIMARY KEY,  -- Código de Beca
    descr VARCHAR(200),     -- Descripción
    monto DECIMAL(10, 2)    -- Monto
);

-- Tabla Obtuvo
CREATE TABLE Obtuvo (
    fcuil CHAR(11),         -- Clave foránea a Alumno
    fcodB INT,              -- Clave foránea a TipoBeca
    fD DATE,                -- Fecha desde
    fH DATE,                -- Fecha hasta
    PRIMARY KEY (fcuil, fcodB, fD),
    FOREIGN KEY (fcuil) REFERENCES Alumno(fcuil),
    FOREIGN KEY (fcodB) REFERENCES TipoBeca(fcodB)
);

-- Tabla Localidad
CREATE TABLE Localidad (
    NomL VARCHAR(50) PRIMARY KEY,  -- Nombre Localidad
    cantH INT                      -- Cantidad de habitantes
);

-- Insertar datos en Alumno
INSERT INTO Alumno (fcuil, nyAp, fNac, domi, tel, carr, NomL) VALUES
('20345678901', 'Juan Perez', '2000-05-15', 'Calle Falsa 123', '1234567890', 'TUPW', 'Capital'),
('20345678902', 'Ana Garcia', '1999-03-22', 'Av. Siempreviva 742', '0987654321', 'TUPW', 'Rivadavia'),
('20345678903', 'Luis Martinez', '1998-07-10', 'Calle Verde 45', '1230984567', 'LCC', 'Capital'),
('20345678904', 'Maria Lopez', '2001-01-30', 'Calle Azul 67', '1234561234', 'LCC', 'Rivadavia'),
('20345678905', 'Carlos Sosa', '2000-11-22', 'Calle Amarilla 89', '0987656789', 'TUPW', 'Capital');

-- Insertar datos en TipoBeca
INSERT INTO TipoBeca (fcodB, descr, monto) VALUES
(100, 'Fotocopia', 5000),
(200, 'Beca Transporte', 8000),
(300, 'Beca Comedor', 9500),
(400, 'Beca Materiales', 12000);

-- Insertar datos en Obtuvo
INSERT INTO Obtuvo (fcuil, fcodB, fD, fH) VALUES
('20345678901', 100, '2022-01-01', '2022-12-31'),
('20345678901', 100, '2023-01-01', '2023-12-31'),
('20345678901', 200, '2022-01-01', '2022-12-31'),
('20345678902', 100, '2023-01-01', '2023-12-31'),
('20345678903', 300, '2022-01-01', '2022-12-31'),
('20345678904', 400, '2023-01-01', '2023-12-31'),
('20345678904', 200, '2024-01-01', '2024-12-31'),
('20345678905', 100, '2023-01-01', '2023-12-31'),
('20345678905', 200, '2022-01-01', '2022-12-31'),
('20345678905', 300, '2024-01-01', '2024-12-31');

-- Insertar datos en Localidad
INSERT INTO Localidad (NomL, cantH) VALUES
('Capital', 500000),
('Rivadavia', 150000),
('San Juan', 200000);

--Alumno= fcuil, nyAp, fNac, domi, tel, carr (carrera), NomL (nombre localidad),
--TipoBeca= fcodB. descr. monto,
--Obtuvo= fcuil,_codB, fD_(fecha desde), fH (Fecha hasta)
--Localidad= inomL (nombre localidad), cantH(Cantidad de habitantes)

--1. Alumnos (todos los datos) de la carrera TUPW` que accedieron al mismo tipo de beca en más de una ocasión. 
select distinct * 
	from alumno natural join (
	select o1.fcuil 
		from obtuvo o1 join obtuvo o2
		on o1.fcuil =o2.fcuil and o1.fcodB=o2.fcodB and o1.fD <> o2.fD)
	where carr = 'TUPW'	
--2. Alumnos (Cuil, nombre, apellido y fecha de nacimiento) que durante el 2023 no obtuvieron beca de "Fotocopia" (código= 200).
select fcuil,NyAp,fNac 
	from alumno
	where alumno not in(
	select alumno
	from obtuvo natural join alumno
	where fcodB = 200 and fD >='2023-01-01' and fD <='2023-12-31'
	)

select fcuil,NyAp,fNac 
	from alumno natural join obtuvo
	where fcodB = 200 and fD< '2023-01-01' or fD > '2023-12-31'
	except
	select fcuil,NyAp,fNac
	from alumno natural join obtuvo
	where fCodB = 200 and fD >= '2023-01-01' and fD <='2023-12-31'
--3. Alumnos (Cuil) que accedieron a todas las becas (tipos de becas) con monto inferior a 10.000 pesos.
select fcuil 
from alumno
where not exists(
	select * 
	from (TipoBeca natural join obtuvo) t1
	where monto < 10000 and not exists 
		(select * 
		from obtuvo 
		where alumno.fcuil = obtuvo.fcuil 
		and t1.fcodB = obtuvo.fcodB)
	)
--4. Alumnos (Cuil, nombre y apellido) que obtuvieron becas en el año 2022 y también obtuvieron algún tipo de beca en el 2024.
select fcuil,NyAp 
	from alumno natural join obtuvo
	where fD >= '2022-01-01' and fD<= '2022-12-31'
intersect
select fcuil,NyAp 
	from alumno natural join obtuvo
	where fD >= '2024-01-01' and fD<= '2024-12-31'
--5. Obtener un listado que incluya los alumnos (cuil, nombre apellido y localidad donde viven) que viven en Capital y los que viven en Rivadavia.
select fcuil,NyAp,NomL 
	from alumno
	where NomL ='Capital'
union
select fcuil,NyAp,NomL
	from alumno
	where NomL = 'Rivadavia'
--6. Obtener un listado que muestre los tipos de becas (todos los datos) que solo tuvieron beneficiarios de la carrera "LCC".
select TipoBeca.*
	from TipoBeca natural join obtuvo natural join alumno
	where carr = 'LCC'
except
select TipoBeca.* 
	from TipoBeca natural join obtuvo natural join alumno
	where carr <> 'LCC'