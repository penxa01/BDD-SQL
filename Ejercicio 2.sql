CREATE TABLE PERS (
    Correo VARCHAR(255),
    NomU VARCHAR(255),
    Nom VARCHAR(255)
);

CREATE TABLE CURSO (
    Nom VARCHAR(255),
    Ch INTEGER
);

CREATE TABLE INSC (
    Correo VARCHAR(255),
    Nom VARCHAR(255),
    Correod VARCHAR(255),
    Nota INTEGER
);

CREATE TABLE DICTA (
    Correo VARCHAR(255),
    Nom VARCHAR(255)
);

CREATE TABLE TEMAS (
    Nom VARCHAR(255),
    Tema VARCHAR(255)
);
-- Insertar datos en la tabla PERS
INSERT INTO PERS (Correo, NomU, Nom)
VALUES
    ('anagarcia32@gmail.com','AnaGarcia131','Ana Garcia'),
    ('pablogomes45@gmail.com','Pablito45','Pablo Gomes'),
    ('rubengonzales104@gmail.com','RubenG10','Ruben Gonzales'),
    ('estefaniaperalta@gmail.com','Estefania22','Estefania Peralta'),
    ('gonzaloramos1978@yahoo.com.ar','GonzaloR78','Gonzalo Ramos');

-- Insertar datos en la tabla CURSO
INSERT INTO CURSO (Nom, Ch)
VALUES
	('Ruby',40),
	('Kotlin I',39),
    ('Javascript I', 50),
    ('Javascript II', 38),
    ('SQL', 25);

-- Insertar datos en la tabla INSC
INSERT INTO INSC (Correo, Nom, Correod, Nota)
VALUES
	('anagarcia56@gmail.com','Python I','gonzaloramos1978@yahoo.com.ar',8),
	('giselleV146@gmail.com','Python I','gonzaloramos1978@yahoo.com.ar',6),
    ('anagarcia56@gmail.com', 'Javascript I', 'pablogomes45@gmail.com', 7),
    ('gisellevasquez201@yahoo.com.ar', 'Javascript I', 'pablogomes45@gmail.com', 8),
    ('gisellevasquez201@yahoo.com.ar', 'Javascript II', 'pablogomes45@gmail.com', 7),
    ('giselleV146@gmail.com', 'Javascript II', 'pablogomes45@gmail.com', 7);

-- Insertar datos en la tabla DICTA
INSERT INTO DICTA (Correo, Nom)
VALUES
	('pablogomes45@gmail.com','Ruby');
    ('pedroibañez@yahoo.com.ar', 'Kotlin I'),
    ('gonzaloramos1978@yahoo.com.ar', 'Python I'),
    ('gonzaloramos1978@yahoo.com.ar', 'SQL'),
    ('pablogomes45@gmail.com', 'Javascript I'),
    ('pablogomes45@gmail.com', 'Javascript II');

-- Insertar datos en la tabla TEMAS
INSERT INTO TEMAS (Nom, Tema)
VALUES
    ('Python I', 'Estructuras de datos'),
    ('Python I', 'Caracteristicas'),
    ('Python II', 'Aplicacion'),
    ('Python II', 'Caracteristicas'),
    ('Javascript I', 'Estructuras de datos'),
    ('Javascript I', 'Estructuras de control'),
    ('Javascript I', 'Aplicacion'),
    ('Javascript I', 'Caracteristicas'),
    ('Javascript II', 'Estructuras de datos'),
    ('Javascript II', 'Estructuras de control'),
    ('Javascript II', 'Aplicacion'),
    ('Javascript II', 'Caracteristicas'),
    ('Kotlin I', 'Estructuras de control'),
    ('Kotlin I', 'Caracteristicas'),
    ('Kotlin II', 'Estructuras de datos'),
    ('Kotlin II', 'Estructuras de control'),
    ('Kotlin II', 'Aplicacion'),
    ('Kotlin II', 'Caracteristicas');

--Consultas

--1. Actualice la carga horaria del curso Ruby por 60
UPDATE CURSO 
	SET Ch = 60 
	where Nom = 'Ruby'
--2. Elimine el curso Ruby I.
DELETE FROM CURSO 
	WHERE Nom = 'Ruby'
--3. Correo y nombre de todas las personas
SELECT Nom,Correo 
	FROM PERS
--4. Cantidad de cursos
SELECT Count(Nom) 
	FROM CURSO
--5. Cantidad de docentes
SELECT Count(Distinct Correo) 
	FROM DICTA

--6. Nota máxima obtenida en el curso ’Python I'
SELECT Nota 
	FROM INSC 
	Where Nom = 'Python I'

--7. Nombre de los cursos ordenados por nombre.
SELECT Nom 
	FROM CURSO 
	ORDER BY Nom
--8. Nombre del curso que tiene una carga horaria superior a la de todos los cursos que dicta “pedroibañez@yahoo.com.ar”.
SELECT C1.Nom 
	FROM CURSO C1 JOIN DICTA D1 ON C1.Nom = D1.Nom WHERE C1.ch > ALL 
	(SELECT C2.ch FROM CURSO C2 JOIN DICTA D2 on C2.Nom = D2.Nom where D2.Correo = 'pedroibañez@yahoo.com.ar')

SELECT DISTINCT Nom FROM CURSO WHERE ch > ALL (
    SELECT ch FROM CURSO WHERE Nom IN 
        (SELECT DISTINCT Nom FROM DICTA WHERE Correo = 'pedroibañez@yahoo.com.ar'));
--9. Personas, docentes o alumnos(todos sus datos) que se llama Rosa
SELECT * 
	FROM PERS 
	WHERE NOM = 'Rosa'
--10. Cursos que tienen una carga horaria superior a la del curso “Kotlin I”, ordenados descendentemente por cantidad dehoras.
SELECT * 
	FROM CURSO C1 
	WHERE ch > (SELECT ch FROM CURSO where Nom = 'Kotlin I')
	ORDER BY ch DESC
--11. Cursos (todos los datos) cuya carga horaria sea superior a las 40 horas reloj.
SELECT * 
	FROM CURSO 
	WHERE ch >= 40
--12. Cursos (todos los datos) cuya carga horaria se encuentre entre 40 y 45 horas reloj.
SELECT * FROM CURSO WHERE ch > 40 and ch<45
--13. Docentes (correo y nombre) que dictan cursos
Select  DISTINCT P1.Correo,P1.Nom 
	FROM DICTA D1 
	JOIN PERS P1 on D1.Correo = P1.Correo
--20. Listado de los cursos (nombre) junto a los datos del docente que los dicta.
Select D1.Nom,P1.Nom,P1.Correo,P1.NomU
FROM PERS P1 join DICTA D1
ON P1.Correo = D1.Correo
--21. Obtenga el curso (todos los datos) junto a los datos de los alumnos inscriptos. Se deben incluir todos los cursos registrados más allá que no tengan alumnos inscriptos.. (Usar OUTER JOIN)
SELECT *
FROM CURSO left outer join INSC
on CURSO.Nom = INSC.Nom
--22. Docentes (todos los datos) que dictan los cursos “Python I”
SELECT PERS.*
FROM PERS join DICTA
on PERS.Correo = DICTA.Correo
where DICTA.Nom = 'Python I'
--23. Docentes (todos los datos) que dictan los cursos “Python II”.
SELECT PERS.*
FROM PERS join DICTA
on PERS.Correo = DICTA.Correo
where DICTA.Nom = 'Python II'
--24. Listado de docentes (correo) que dictan el curso “Python I” y/o “Python II”.
SELECT PERS.Correo
FROM PERS join DICTA
on PERS.Correo = DICTA.Correo
where DICTA.Nom = 'Python I' or DICTA.Nom = 'Python II'
--25. Docentes (correo) que dictan los cursos “Python I” y “Python II”.
SELECT PERS.*
FROM PERS join DICTA
on PERS.Correo = DICTA.Correo
where DICTA.Nom = 'Python I' and DICTA.Nom = 'Python II'
--26. Docentes (todos los datos) que cursaron algún curso de verano.
SELECT PERS.*
FROM PERS join (SELECT INSC.Correo FROM DICTA join INSC on DICTA.Correo = INSC.Correo) AS P2
on PERS.Correo = P2.Correo
--27. Alumnos (todos los datos) que se inscribieron en el curso “Kotlin I”.
SELECT PERS.*
FROM PERS join INSC
on PERS.Correo = INSC.Correo
where INSC.Nom = 'Kotlin I'
--28. Alumnos (todos los datos) que se inscribieron en el curso “Kotlin II”.
SELECT PERS.*
FROM PERS join INSC
on PERS.Correo = INSC.Correo
where INSC.Nom = 'Kotlin II'
--29. Listado de alumnos (correo) que se inscribieron tanto en el curso “Kotlin I” como “Kotlin II”
SELECT PERS.Correo
FROM PERS join DICTA
on PERS.Correo = DICTA.Correo
where DICTA.Nom = 'Kotlin I' or DICTA.Nom = 'Kotlin II'
--30.Alumnos (todos los datos) que aprobaron el curso “Python I” y “Python II”.
SELECT PERS.*
FROM PERS join INSC
on PERS.Correo = INSC.Correo
where INSC.Nom = 'Kotlin I' and INSC.Nom = 'Kotlin II' and INSC.Nota > 6
--31. Alumnos (Correo) que se inscribieron en más de un curso de verano.
SELECT distinct I1.Correo
FROM INSC I1 join INSC I2
ON I1.Correo =I2.Correo and I1.Nom <> I2.Nom
--32. Docentes (correo) que dictan más de un curso.
SELECT distinct D1.Correo
FROM DICTA D1 join DICTA D2
ON D1.Correo =D2.Correo and D1.Nom <> D2.Nom
--33.Docentes (todos los datos) que dictan más de un curso cuya carga horaria sea inferior a 30 horas reloj.(REVISAR)
SELECT P1.*
FROM PERS P1
natural join (SELECT D1.Correo FROM DICTA D1 join (SELECT Nom FROM CURSO Where ch<30) AS C2) AS D2


