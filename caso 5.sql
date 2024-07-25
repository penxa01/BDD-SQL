create table Persona (
    nom varchar(30) not null constraint pers_pk primary key,
    fechanac date
);
create table Pelicula (
    titulo varchar(40) not null constraint pel_pk primary key,
    estreno date,
	lema varchar(60)
);

CREATE TABLE Actua
    (
        nom varchar(30) NOT NULL,
        titulo varchar(40)  NOT NULL,
        primary key(nom,titulo),
        foreign key(nom) references Persona(nom) on delete cascade,
        foreign key(titulo) references Pelicula(titulo) on delete cascade      
    );
CREATE TABLE Dirige
    (
        nom varchar(30) NOT NULL,
        titulo varchar(40)  NOT NULL,
        primary key(nom,titulo),
        foreign key(nom) references Persona(nom) on delete cascade,
        foreign key(titulo) references Pelicula(titulo) on delete cascade      
    );

create table Sigue (
    seguido varchar(30) not null,
    seguidor varchar(30) not null,
	primary key(seguido,seguidor),
	foreign key(seguido) references Persona(nom) on delete cascade,
    foreign key(seguidor) references Persona(nom) on delete cascade
);

insert into Persona values
        ('Keanu Reeves','1964-03-23'),
        ('Carrie-Anne Moss','1967-03-29'),
        ('Hugo Weaving','1960-03-30'),
        ('Emil Eifrem','1978-10-20'),
		('Al Pacino','1940-10-20'),
		('Charlize Theron','1975-10-20'),
		('Lilly Wachowski','1967-05-27'),
		('Taylor Hackford','1944-08-13'),
		('Paul Blythe','2009-12-13');
insert into Pelicula values
        ('The Matrix','1990-09-13','Welcome to the Real World'),
        ('The Matrix Revolutions','2003-04-19','Everything that has a beginning has an end'),
        ('The Devils Advocate','1997-08-30','Evil has its winning ways');
		
Insert into Actua values
     ('Keanu Reeves','The Matrix'),
     ('Hugo Weaving','The Matrix'),
	 ('Emil Eifrem','The Matrix'),
	 ('Al Pacino','The Matrix'),
	 ('Keanu Reeves','The Matrix Revolutions'),
	 ('Lilly Wachowski','The Matrix Revolutions'),
	 ('Al Pacino','The Matrix Revolutions'),
	 ('Keanu Reeves','The Devils Advocate'),
	 ('Al Pacino','The Devils Advocate');

Insert into Dirige values
     ('Carrie-Anne Moss','The Matrix'),
     ('Hugo Weaving','The Matrix'),
	 ('Keanu Reeves','The Matrix Revolutions'),
	 ('Carrie-Anne Moss','The Matrix Revolutions'),
	 ('Carrie-Anne Moss','The Devils Advocate'),
	 ('Taylor Hackford','The Devils Advocate');
Insert into Sigue values
     ('Keanu Reeves','Hugo Weaving'),
     ('Keanu Reeves','Al Pacino'),
	 ('Emil Eifrem','Lilly Wachowski'),
	 ('Keanu Reeves','Paul Blythe'),
	 ('Al Pacino','Keanu Reeves');

--1. Personas (nombre) que han actuado en más de una película estrenada en el año 1990.
select nom
	from actua natural join pelicula 
	where estreno between '1990-01-01' and '1990-12-31' 
	group by nom 
	having count(nom)>1
--2. Películas (título y lema) en las que han actuado solamente personas que nacieron antes del 1970.
select distinct titulo,lema 
	from pelicula natural join actua natural join persona
	where fechanac<date('1970-01-01')
	except (
	select distinct titulo,lema 
	from pelicula natural join actua natural join persona
	where fechanac>date('1970-01-01'))

select distinct titulo,lema 
	from pelicula natural join actua natural join persona
	where extract (year from fechanac) < 1970
	except (
	select distinct titulo,lema 
	from pelicula natural join actua natural join persona
	where extract (year from fechanac) > 1970)
--3. Personas (todos los datos) que han actuado en todas las películas dirigidas por Carrie-Anne Moss.
select nom,fechanac
	from persona p1
	where not exists (
	select * 
		from (pelicula natural join dirige) d1
		where nom = 'Carrie-Anne Moss' and 
		not exists(
			select * 
			from actua 
			where p1.nom = actua.nom and d1.titulo = actua.titulo))
--4. Obtener el título y fecha de estreno de las películas dirigidas por Keanu Reeves.
select titulo,estreno
	from pelicula natural join dirige 
	where nom = 'Keanu Reeves'
--5. Personas (todos los datos) que han actuado y/o dirigido en las mismas Películas en las que actuó Keanu Reeves.
(select distinct nom,fechanac 
	from actua 
	natural join persona 
	natural join (select titulo 
					from pelicula 
					natural join actua 
					where nom= 'Keanu Reeves') 
					where nom <> 'Keanu Reeves')
union 
	(select distinct nom,fechanac 
		from dirige 
		natural join persona 
		natural join (select titulo 
					from pelicula natural join actua 
					where nom= 'Keanu Reeves')
					where nom <> 'Keanu Reeves')
--6. Personas (nombre) que han actuado en las películas The Matrix y The Matrix Revolutions.
	(select nom 
	from actua 
	where titulo = 'The Matrix') 
intersect
	(select nom 
	from actua
	where titulo ='The Matrix Revolutions')
--7. Persona/s (todos los datos) que ha/n dirigido más películas.
select nom,fechanac
	from persona natural join dirige
	group by nom
	having count(titulo) = (
		select max(total) 
		from (select count(titulo) as total 
			from actua 
			group by nom))
--8. Nombre de la persona junto a la cantidad de películas que ha dirigido.
select nom,count(titulo) 
	from dirige
	group by nom
--9. Personas (todos sus datos) que han participado actuando y dirigiendo la misma película.
select p1.nom,p1.fechanac 
	from persona p1 natural join dirige natural join actua
	where dirige.nom = actua.nom
--10.Título de la película junto a la cantidad de personas que participaron actuando y/o dirigiendo.(consultar)
select titulo,count(*) 
	from(
		select titulo,nom from actua 
		union
		select titulo,nom from dirige
	) group by titulo

