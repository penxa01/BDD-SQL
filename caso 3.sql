CREATE TABLE obras
	(
    	Co INT NOT NULL  PRIMARY KEY,
    	Descrip VARCHAR(50),
   	 Direc VARCHAR(50),
   	 Zona VARCHAR(50),
   	 EmpCon VARCHAR(50)
   	 
	);

Insert into obras values
(100,'Construccion de Barrio','Av. José Ignacio de la Roza Oeste 2174','Santa Lucia','FyF'),
(200,'Departamentos','Av. Rioja 2174 (s)','Rawson','CREAR'),
(300,'Barrio','Av. Libertador 774 (e)','Rivadavia','CREAR'),
(400,'Mantenimiento Parque de Mayo','25 de Mayo 650 (o)','Capital','PEPE S.A.'),
(500,'Hotel 5 Estrellas','Santiago 64 (o)','Zonda','CONSTRUIR S.A.')
;

CREATE TABLE Materiales
	(
    	Cm INT NOT NULL  PRIMARY KEY,
    	Descrip VARCHAR(50),
   	 Precio INT    
   	 
	);

Insert into Materiales values
(10,'Arena',700),
(20,'Cal',6000),
(30,'Hierro',10000),
(40,'Tornillos',1),
(50,'Tuercas',4),
(60,'Arandelas',3),
(70,'Pintura',420),
(80,'Herramienta: Amoladora',4000),
(90,'Herramienta: Destornillador',350),
(100,'Puerta',3250),
(110,'Cemento Avellaneda',3685)
;

CREATE TABLE Ferreterias
	(
    	Cuit INT NOT NULL  PRIMARY KEY,
    	Nom VARCHAR(50),
   	 Direc VARCHAR(50),
   	 Zona VARCHAR(50),
   	 Tel INT
   	 
	);

Insert into Ferreterias values
(10289,'Ferreteria Cordoba','Av. Cordoba 44 (e)','Capital','4282169'),
(13263,'La cosita del coso','Mendoza 15(s)','Rawson','4452132'),
(20277,'Ferre San Juan','Av. Cordoba 44 (e)','Chimbas','4272169'),
(10267,'Todo para la Construccion','Santa Fe 68(o)','Caucete','4219974'),
(2246,'MR S.A','Av. Rawson 84 (n)','Capital','4682989')
;

CREATE TABLE Pedidos
	(
    	Co INTEGER NOT NULL,
   	 Cm INTEGER NOT NULL,
   	 Cuit INTEGER NOT NULL,
   	 Fecha DATE NOT NULL,
   	 Cant INTEGER,
   	 primary key(Co,Cm,Cuit,Fecha),
   	 constraint fk_obra FOREIGN KEY (Co) REFERENCES Obras(Co),
   	 constraint fk_material FOREIGN KEY (Cm) REFERENCES Materiales(Cm),
   	 constraint fk_ferreteria FOREIGN KEY (Cuit) REFERENCES Ferreterias(Cuit)    
	);

Insert into Pedidos values
(100,40,10289,'2020/12/05',100),
(100,40,10289,'2018/04/22',600),
(200,50,13263,'2019/06/05',400),
(300,10,2246,'2020/12/05',300),
(200,70,10267,'2020/02/13',10),
(200,30,20277,'2020/02/13',5000),
(400,100,20277,'2020/10/06',250),
(300,50,2246,'2020/05/16',238),
(300,20,2246,'2020/05/16',45),
(300,20,2246,'2020/05/13',10),
(100,50,2246,'2020/04/16',45),
(400,10,2246,'2020/01/13',10),
(200,40,13263,'2019/06/05',400),
(300,40,2246,'2020/04/05',300),
(500,40,10289,'2020/05/15',300),
(400,40,10289,'2020/05/15',300)
;

--1. Muestre, a través de una consulta, los materiales (descripción) pedidos el día 06/06/2020.
select * 
	FROM materiales 
	natural join (select cm from pedidos where fecha = date('2020/06/06')) 
/*2. Muestre para cada obra (indicando descripción) todos los materiales solicitados (descripción). Deben informarse todas
las obras, más allá que aún no tenga materiales pedidos.*/
select distinct co,p1.descrip,materiales.descrip
	from materiales 
	join (select obras.co,obras.descrip,pedidos.cm 
		from obras left join pedidos on obras.co = pedidos.co) as p1
		on p1.cm = materiales.cm order by co 
--3. Muestre la cantidad total de bolsas de cal que han sido pedidas a la ferretería MR S.A.
select sum(cant) 
	from pedidos 
	natural join materiales 
	natural join ferreterias 
	where Nom ='MR S.A' and descrip = 'Cal'
--4. Muestre la cantidad total de obras que han pedido materiales a la ferretería MR S.A.
select count(distinct co)
	from pedidos natural join ferreterias
	where Nom = 'MR S.A'
--5. Muestre, para cada material pedido a alguna ferretería, el código de material, código de obra y la cantidad total pedida
--(independientemente de la ferretería).
select co,cm,sum(cant) from pedidos group by cm,co

--6. Muestre la descripción de materiales pedidos para alguna obra en una cantidad promedio mayor a 320 unidades.
select distinct descrip 
	from materiales 
	natural join pedidos
	where 320< (select avg(cant) from pedidos)
--7. Muestre el nombre del material menos pedido (en cantidad total).
select descrip 
	from (select descrip,sum(cant) as total 
			from materiales natural join pedidos 
			group by descrip)
			where total = (select min(total)
							from (select descrip,sum(cant) as total
									from materiales natural join pedidos 
									group by descrip))
--8. Muestre la descripción de las obras que no han utilizado pintura.
select descrip
	from obras 
	except 
		select descrip 
			from obras natural join 
			(select co
			from pedidos natural join materiales
			where descrip = 'Pintura')
--9. Muestre el nombre de las obras abastecidas totalmente por la ferretería MR S.A.
select descrip 
	from obras 
	natural join (select co
	from pedidos P1 natural join ferreterias F1 where F1.nom='MR S.A'
	except
		select co
	from pedidos P2 natural join ferreterias F2 where F2.nom<>'MR S.A')
--10. Muestre el nombre de los materiales que han sido pedidos para todas las obras realizadas.
/*En algebra relacional ===>  (pi cm,co pedidos) % (pi co obras)   */
select descrip
	from materiales 
	where not exists
		(select * 
		from obras
		where not exists 
			(select * 
			from pedidos 
			where pedidos.co = obras.co and materiales.cm = pedidos.cm))
--11. Actualice el teléfono de la Ferretería San Ignacio por el número 4312548.
update ferreterias 
	set tel = 4312548 
	where Nom='Ferreteria San Ignacio' 
--12. Elimine el Material con descripción Cemento Avellaneda.
delete 
	from materiales 
	where descrip = 'Cemento Avellaneda'
--13. Especifique la Vista “ObrasCuyoNorte” que contenga Co (código de la obra), Direc(dirección de la obra) y EmpCon
--(empresa constructora) de las obras ubicadas en la zona Santa Lucia.
select co, direc, empcon from obras where zona = 'Santa Lucia'
--14. Especifique la Vista “ObrasMat” que contenga Obra (código de la obra), Empresa (empresa constructora), Material (descripción del material) y CantMat (cantidad de materiales pedidos).
--a. Muestre los datos contenidos en la vista, ordenados según obra (descendente) y material (ascendente).
create view ObrasCuyoNorte as
	select co,empcon,descrip,cant 
		from ((select co,empcon,cant,cm 
				from obras 
				natural join pedidos) 
				natural join materiales) order by co desc, cant asc
--b. Actualice la cantidad de materiales pedidos de las obras incrementándolas en 100.
update pedidos set cant =cant + 100 
