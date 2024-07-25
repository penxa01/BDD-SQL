-- Tabla Competidor
CREATE TABLE Competidor (
    cuil INTEGER NOT NULL PRIMARY KEY,
    nya VARCHAR(30),
    sexo VARCHAR(30),
    telc VARCHAR(30),
    twitter VARCHAR(30),
    cantseg INTEGER
);
-- Tabla Lugar
CREATE TABLE Lugar (
    codL INTEGER NOT NULL PRIMARY KEY,
    nombre VARCHAR(30),
    altura INTEGER,
    pais VARCHAR(30),
    latitud DECIMAL(9,6),
    longitud DECIMAL(9,6)
);
-- Tabla Competencia con clave foránea a Lugar
CREATE TABLE Competencia (
    num INTEGER NOT NULL PRIMARY KEY,
    codL INTEGER NOT NULL,
    fechai DATE,
    nombre VARCHAR(30),
    dificultad INTEGER CHECK (dificultad BETWEEN 1 AND 6),
    FOREIGN KEY (codL) REFERENCES Lugar(codL) ON DELETE CASCADE
);
-- Tabla Participa con claves foráneas a Competidor y Competencia
CREATE TABLE Participa (
    cuil INTEGER NOT NULL,
    num INTEGER NOT NULL,
    cumbre VARCHAR(30),
    PRIMARY KEY (cuil, num),
    FOREIGN KEY (cuil) REFERENCES Competidor(cuil) ON DELETE CASCADE,
    FOREIGN KEY (num) REFERENCES Competencia(num) ON DELETE CASCADE
);

-- Insertar datos en la tabla Competidor
INSERT INTO Competidor (cuil, nya, sexo, telc, twitter, cantseg) VALUES
(12345678, 'Juan Perez', 'Masculino', '123-456-7890', '@juanp', 1500),
(87654321, 'Maria Gomez', 'Femenino', '098-765-4321', '@mariag', 2000),
(11223344, 'Carlos Lopez', 'Masculino', '111-222-3333', '@carlosl', 1200),
(44332211, 'Ana Martinez', 'Femenino', '444-333-2211', '@anam', 1800),
(55667788, 'Luis Fernandez', 'Masculino', '555-666-7788', '@luisf', 1400),
(66778899, 'Pedro Alvarez', 'Masculino', '666-777-8899', '@pedroa', 1700),
(99887766, 'Jose Ramirez', 'Masculino', '999-888-7766', '@joser', 1600),
(33445566, 'Martin Gutierrez', 'Masculino', '333-444-5566', '@marting', 1100),
(22334455, 'Roberto Diaz', 'Masculino', '222-333-4455', '@robertod', 1300),
(88990077, 'Andres Lopez', 'Masculino', '888-999-0077', '@andresl', 1250);

-- Insertar datos en la tabla Lugar con el código 2600 incluido
INSERT INTO Lugar (codL, nombre, altura, pais, latitud, longitud) VALUES
(100, 'Montaña Everest', 8849, 'Nepal', 27.9875, 86.9250),
(200, 'Monte Kilimanjaro', 5895, 'Tanzania', -3.0674, 37.3556),
(300, 'Monte Fuji', 3776, 'Japón', 35.3606, 138.7274),
(400, 'Aconcagua', 6962, 'Argentina', -32.6532, -70.0109),
(500, 'Mont Blanc', 4810, 'Francia', 45.8326, 6.8652),
(2600, 'Los Alpes', 4808, 'Francia/Italia/Suiza', 45.8326, 6.8652), -- Código 2600 para Los Alpes
(600, 'Himalaya', 8849, 'Nepal/China', 27.9875, 86.9250);

-- Insertar datos en la tabla Competencia con ajustes en los códigos de lugar y nuevas competencias
INSERT INTO Competencia (num, codL, fechai, nombre, dificultad) VALUES
(1, 100, '2024-07-01', 'Escalada Everest', 6),
(2, 200, '2024-08-15', 'Subida Kilimanjaro', 5),
(3, 300, '2024-09-20', 'Desafío Fuji', 4),
(4, 400, '2024-10-05', 'Aconcagua Challenge', 5),
(5, 500, '2024-11-10', 'Mont Blanc Expedition', 3),
(6, 2600, '2023-06-01', 'Los Alpes Summer Climb', 3),     -- Competencia en Los Alpes en 2023
(7, 2600, '2023-12-15', 'Los Alpes Winter Climb', 4),     -- Otra competencia en Los Alpes en 2023
(8, 600, '2023-03-21', 'Himalaya Base Camp Trek', 4),    -- Competencia en Himalaya en 2023
(9, 400, '2021-02-20', 'Aconcagua Winter Ascent', 6),    -- Competencia en Aconcagua en 2021
(10, 400, '2021-11-30', 'Aconcagua Spring Climb', 5);    -- Otra competencia en Aconcagua en 2021


-- Insertar datos en la tabla Participa con códigos de lugar ajustados y competencias actualizadas
INSERT INTO Participa (cuil, num, cumbre) VALUES
-- Competencia 1: Escalada Everest
(12345678, 1, 'Sí'),
(11223344, 1, 'Sí'),
(55667788, 1, 'Sí'),
(66778899, 1, 'Sí'),
(99887766, 1, 'Sí'),

-- Competencia 4: Aconcagua Challenge
(12345678, 4, 'Sí'),
(11223344, 4, 'Sí'),
(33445566, 4, 'Sí'),
(22334455, 4, 'Sí'),
(88990077, 4, 'Sí'),

-- Competencia 6: Los Alpes Summer Climb
(12345678, 6, 'Sí'),
(11223344, 6, 'Sí'),
(55667788, 6, 'Sí'),
(66778899, 6, 'Sí'),
(99887766, 6, 'Sí'),

-- Competencia 8: Himalaya Base Camp Trek
(12345678, 8, 'Sí'),
(11223344, 8, 'Sí'),
(55667788, 8, 'Sí'),
(66778899, 8, 'Sí'),
(99887766, 8, 'Sí'),

-- Competencia 9: Aconcagua Winter Ascent
(12345678, 9, 'Sí'),
(11223344, 9, 'Sí'),
(55667788, 9, 'Sí'),
(66778899, 9, 'Sí'),
(99887766, 9, 'Sí'),

-- Otras participaciones
(12345678, 2, 'Sí'),
(12345678, 3, 'Sí'),
(12345678, 5, 'No'),
(12345678, 7, 'Sí'),
(11223344, 2, 'No'),
(11223344, 3, 'Sí'),
(11223344, 5, 'Sí'),
(11223344, 7, 'Sí');

-- Participaciones de mujeres
insert into Participa (cuil, num, cumbre) VALUES
(87654321, 1, 'Sí'), -- Competencia 1: Escalada Everest
(44332211, 5, 'Sí'), -- Competencia 5: Mont Blanc Expedition
(87654321, 7, 'Sí'); -- Competencia 7: Los Alpes Winter Climb
(44332211, 8, 'Sí'); -- Competencia 8: Himalaya Base Camp Trek
	
--NOTA: Sintaxis de la funcion extract: extract(<Year/Month/Day>from<nombrecolumna>).
--EJEMPLOS DE USO:
--SELECT EXTRACT(YEAR FROM fechai) AS year FROM Competencia; // Devuelve el año de cada fecha en la columna fechai.
--SELECT * FROM Competencia WHERE EXTRACT(YEAR FROM fechai) = 2023; // Selecciona todas las filas donde la columna fechai es del año 2023.
--SELECT EXTRACT(MONTH FROM fechai) AS month, COUNT(*) FROM Competencia GROUP BY month; // Cuenta cuántos registros hay para cada mes, agrupando por el mes extraído de la columna fechai.


--1. Para el lugar con código 2600 , competencias (nombre) que se realizaron junto a la cantidad de participantes.
select c1.nombre,count(*)
from participa natural join(
	select *
	from competencia
	where codl='2600'
) as c1
group by c1.nombre;
--2. Competencias (nombre y dificultad) realizadas en Los Alpes en el 2023.
select nombre,dificultad
from competencia natural join(
	select codl
	from lugar
	where nombre='Los Alpes'
)
where extract(year from fechai)=2023;
--
select competencia.nombre,dificultad
from competencia join lugar
on competencia.codl=lugar.codl
where lugar.nombre='Los Alpes' and extract(year from competencia.fechai)=2023;
--3. Competencias (todos los datos) en las que participaron solamente hombres.
select *
from competencia
	except
select *
from competencia
where num in(
	select distinct num
	from participa
	where cuil in(
		select cuil
		from competidor
		where sexo='Femenino'
	)
)
order by num asc;
--
select *
from competencia
where num not in(
	select num
	from competencia
	where num in(
		select distinct num
		from participa
		where cuil in(
			select cuil
			from competidor
			where sexo='Femenino'
		)
	)
)
order by num asc;
--4. Competidores (todos los datos) que escalaron el Himalaya pero no escalaron el Aconcagua.
select *
from competidor
where cuil in(
	select cuil
	from participa
	where num in(
		select num
		from competencia natural join(
			select codl
			from lugar
			where nombre='Himalaya'
		)
	)
	except
	select cuil
	from participa
	where num in(
		select num
		from competencia natural join(
			select codl
			from lugar
			where nombre='Aconcagua'
		)
	)
);
--5. Competencias (todos los datos) en las que hicieron cumbre como mínimo 5 hombres.
select competencia.num
from competencia natural join(
	select cuil,num
	from participa
	where cumbre='Sí' and participa.cuil in(
		select cuil
		from competidor
		where sexo='Masculino'
	) 
) as s1
group by competencia.num 
having count(s1.cuil)>=5;
--
select *
from competencia 
where num in(
	select num
	from participa natural join competidor
	where cumbre='Sí' and sexo='Masculino' 
	group by num 
	having count(distinct participa.cuil)>=5
);
--6. Cantidad de lugares en los que se realizaron competencias con dificultad 3.
select count(*)
from lugar natural join(
	select distinct codl
	from competencia
	where dificultad=3
)
--
select count(*)
from competencia
where dificultad=3
--7. Twitter de los competidores que han participado en todas las competencias realizadas en el año 2021.
-- Twitter de los competidores que no han participado en ninguna de las competencias realizadas en el año 2021.
select twitter
from competidor A -- Tabla que muestro
where not exists(
	select *
	from competencia B -- Tabla todos
	where extract(year from fechai)=2021 and not exists(
		select *
		from participa C1 -- Tabla vinculante
		where B.num=C1.num and A.cuil=C1.cuil
	)
);