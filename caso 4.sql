create table Sucursal (
    num integer not null constraint pers_pk primary key,
    direcc varchar(30),
    tel varchar(30),
    provincia varchar(30)
);

create table Producto (
    cod integer not null,
    num integer not null,
    nombre varchar(30),
    precio float,
    stock integer,
    primary key(cod,num),
    foreign key(num) references Sucursal(num) on delete cascade
);

create table Ingrediente (
    cod integer not null,
    num integer not null,
    nombre varchar(40) not null,
    kcal float,
    primary key(cod,num,nombre),
    foreign key(cod,num) references Producto(cod,num) on delete cascade
);

CREATE TABLE Factura
(
    num integer not null primary key,
    fecha date,
    calif float
);









CREATE TABLE Detalle
(
    numf integer not null,
    cod integer not null,
    num integer not null,
    precio float,
    cantidad integer,
    primary key(numf,cod,num),
    foreign key(cod,num) references Producto(cod,num) on delete cascade   
);


insert into Sucursal values
    (100,'San Luis 104(E)','264-6555000','San Juan'),
    (101,'Av Libertador 450(O)','264-6345022','San Juan'),
    (200,'Salta 3109(E)','261-6555002','Mendoza'),
    (201,'Caseros 45(S)','261-6555000','Mendoza'),
    (300,'Victoria 489(N)','2652-6555000','San Luis'),
    (301,'Rioja 104(E)','2652-5644001','San Luis'),
    (400,'Estado de Israel(E)','351-5644351','Córdoba');

insert into Producto values
    (1000,100,'Pizza napolitana',560,202),
    (1001,100,'Pizza napolitana especial',660,103),
    (1000,101,'Pizza napolitana',460,89),
    (1001,101,'Pizza napolitana especial',560,67),
    (1000,200,'Pizza napolitana',560,76),
    (1001,200,'Pizza napolitana especial',480,56),
    (1002,201,'Pizza con jamón',680,45),
    (1003,201,'Pizza muzzarella',680,0),
    (1000,300,'Pizza napolitana',569,20),
    (1001,300,'Pizza napolitana especial',669,10),
    (1001,201,'Pizza napolitana especial',669,10),
    (1003,100,'Pizza napolitana especial',669,10),
    (1000,301,'Pizza napolitana',360,9),
    (1001,301,'Pizza especial',660,10),
    (1000,400,'Pizza napolitana',560,14),
    (1001,400,'Pizza napolitana especial',660,13);
   	 
Insert into Ingrediente values
    (1000,100,'Harina',578),
    (1000,100,'Sal',8),
    (1000,100,'Queso napolitano',1009),
    (1001,100,'Harina',578),
    (1001,100,'Sal',8),
    (1001,100,'Queso napolitano',1009),
    (1001,100,'Aceitunas',57),
    (1000,101,'Harina',589),
    (1000,101,'Sal',5),
    (1000,101,'Queso napolitano',1012),
    (1001,101,'Harina',589),
    (1001,101,'Sal',12),
    (1001,101,'Queso napolitano',1022),
    (1000,200,'Harina',589),
    (1000,200,'Sal',5),
    (1000,200,'Queso napolitano',1012),
    (1001,200,'Harina',589),
    (1001,200,'Sal',12),
    (1001,200,'Queso napolitano',2500),
    (1000,300,'Harina',589),
    (1000,300,'Sal',5),
    (1000,300,'Queso napolitano',1012),
    (1001,300,'Harina',799),
    (1001,300,'Sal',7),
    (1001,300,'Queso napolitano',1022),
    (1000,301,'Harina',589),
    (1000,301,'Sal',5),
    (1000,301,'Queso napolitano',1012),
    (1001,301,'Harina',799),
    (1001,301,'Sal',7),
    (1001,301,'Queso napolitano',1008),
    (1000,400,'Harina',492),
    (1000,400,'Sal',7),
    (1000,400,'Queso napolitano',1056),
    (1001,400,'Harina',799),
    (1001,400,'Sal',7),
    (1001,400,'Queso napolitano',1008),
    (1002,201,'Harina',678),
    (1002,201,'Sal',5),
    (1002,201,'Queso muzzarella',1012),
    (1002,201,'Jamó',2096),
    (1003,201,'Harina',799),
    (1003,201,'Sal',6),
    (1003,201,'Queso muzarrella',1008),
    (1003,201,'Aceitunas',1008);

Insert into Detalle values
    (3000,1000,100,560,2),
    (3001,1000,100,560,1),
    (3001,1001,100,660,2),
    (3002,1000,101,560,1),
    (3003,1000,100,560,5),
    (3004,1000,200,560,3),
    (3008,1002,201,680,2),
    (3005,1001,300,669,1),
    (3006,1000,301,569,3),
    (3007,1000,400,560,2);
	(3008,1000,301,569,3),
    
Insert into Factura values
    (3000,'2020-02-14',5),
    (3001,'2020-02-14',4.5),
    (3002,'2020-03-23',6),
    (3003,'2020-05-01',4),
    (3004,'2020-05-01',5),
    (3005,'2020-05-25',6),
    (3006,'2020-06-09',4),
    (3007,'2020-02-14',3),
    (3008,'2020-02-14',7);


--1. Sucursales (todos los datos) que vendieron todos los productos que se comercializan en San Luis.
select * 
	from sucursal s1
	where not exists
	(select * 
		from producto 
		natural join sucursal
		where provincia = 'San Luis' and not exists
		(select detalle.num 
			from detalle 
			where producto.cod = detalle.cod and s1.num=detalle.num))	
--2. Provincias donde se venden más de un producto.
select distinct provincia 
	from (sucursal 
			natural join producto) 
			group by num 
			having count(cod)>1
--3. Sucursales (todos los datos) que venden tanto Pizza napolitana como Pizza napolitana especial.
select num,direcc,tel,provincia 
	from (sucursal natural join producto) where nombre ='Pizza napolitana'
intersect
select num,direcc,tel,provincia 
	from(sucursal natural join producto) where nombre ='Pizza napolitana especial'
--4. Productos (nombre y stock) comercializados en las provincias de Cuyo (San Juan, Mendoza y San Luis).
select nombre,stock
	from producto 
	natural join sucursal
	where provincia = 'San Juan' 
	or provincia = 'Mendoza' 
	or provincia='San Luis'
--5. Provincias que no venden Pizza muzzarella.
select distinct provincia
	from sucursal natural join producto
	where nombre <> 'Pizza muzzarella'
	except 
	(select distinct provincia 
		from sucursal natural join producto
		where nombre ='Pizza muzzarella')
--6. Sucursales que no venden el producto ‘Pizza con jamón’.
select num,direcc,tel,provincia
	from sucursal natural join producto
	where nombre <> 'Pizza con jamón'
	except 
	(select num,direcc,tel,provincia
		from sucursal natural join producto
		where nombre = 'Pizza con jamón')
--7. Nombre de productos vendidos en San Juan.
select distinct nombre 
	from producto natural join sucursal
	where provincia = 'San Juan'
--8. Para cada sucursal de la provincia de San Luis, obtener número e importe total facturado.
select num,sum(precio)
	from sucursal natural join detalle 
	where provincia = 'San Luis'
	group by num 
--10. Provincia/s que más facturó durante el 2020.
select provincia
	from ((sucursal natural join detalle) join factura on detalle.numf = factura.num)
	where fecha > date('2020-01-01') and fecha < date('2020-12-31')
	group by provincia
	having sum(precio*cantidad) = (
			select max(total) 
				from (
					select provincia,sum(precio*cantidad) as total 
					from (sucursal natural join detalle) 
					join factura on detalle.numf = factura.num 
					group by provincia))
			
			

