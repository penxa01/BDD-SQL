/*Ejercicio 1

PERS (Personas) = {id, nom, ciudad_idc (identificador de ciudad), edad}

Ciu(Ciudad) = {ciudad_id, ciudad_nom}
*/
/*ITEM A*/
CREATE TABLE PERS(
	id int not null constraint pers_pk primary key,
	nom varchar(20) not null ,
	ciudad_idc int,
	edad int not null,
	foreign key (ciudad_idc) references CIU(ciudad_id) on delete set null on update cascade
	);

CREATE TABLE CIU(
	ciudad_id SERIAL not null constraint ciu_id primary key,
	ciudad_nom varchar(50)not null
);

/*ITEM B*/
CREATE TABLE PERSB(
	id int not null constraint pers_pk primary key,
	nom varchar(20) not null ,
	ciudad_idc int not null,
	edad int not null,
	foreign key (ciudad_idc) references CIUB(ciudad_id) on delete restrict on update cascade
	);
CREATE TABLE CIUB(
	ciudad_id int not null constraint ciu_id primary key,
	ciudad_nom varchar(50)not null
);

INSERT into PERS values
(1,'Pedro Cortes',1,16), 
(2,'Santiago Mas',2, 25),
(3,'Juan Basti',5, 50),
(4,'Andrea Hernández',1,89), 
(5,'Ana Perez',1,30);

INSERT into CIU values
(1,'Galilea'),
(2,'Betsaida'),
(3,'Patmos'),
(4,'Jerusalén'),
(5,'La boca');

delete from ciu where ciudad_id = 1;

