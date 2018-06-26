-- tables
-- Table: GR02_Comentario
CREATE TABLE GR02_Comentario (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    id_reserva bigint  NOT NULL,
    fecha_hora_comentario date  NOT NULL,
    comentario varchar(2048)  NOT NULL,
    estrellas int  NOT NULL,
    CONSTRAINT PK_GR02_Comentario PRIMARY KEY (tipo_doc,nro_doc,id_reserva,fecha_hora_comentario)
);

-- Table: GR02_Costo_Depto
CREATE TABLE GR02_Costo_Depto (
    id_dpto int  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    precio_noche decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR02_Costo_Dpto PRIMARY KEY (id_dpto,fecha_desde)
);

-- Table: GR02_Departamento
CREATE TABLE GR02_Departamento (
    id_dpto int  NOT NULL,
    descripcion varchar(80)  NOT NULL,
    superficie decimal(10,2)  NOT NULL,
    id_tipo_depto int  NOT NULL,
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    precio_noche decimal(10,2)  NOT NULL,
    costo_limpieza decimal(10,2)  NOT NULL,
    ciudad varchar(80) NOT NULL, --se agrego la columna ciudad, para saber de donde ese el dpto
    CONSTRAINT PK_GR02_Departamento PRIMARY KEY (id_dpto)
);

-- Table: GR02_Estado_Luego_Ocupacion_Reserva
CREATE TABLE GR02_Estado_Luego_Ocupacion_Reserva (
    fecha int  NOT NULL,
    id_reserva bigint  NOT NULL,
    comentario varchar(2048)  NOT NULL,
    CONSTRAINT PK_GR02_Estado_Luego_Ocupacion PRIMARY KEY (fecha,id_reserva)
);

-- Table: GR02_Habitacion
CREATE TABLE GR02_Habitacion (
    id_dpto int  NOT NULL,
    id_habitacion int  NOT NULL,
    posib_camas_simples int  NOT NULL,
    posib_camas_dobles int  NOT NULL,
    posib_camas_kind int  NOT NULL,
    tv boolean  NOT NULL,
    sillon int  NOT NULL,
    frigobar boolean  NOT NULL,
    mesa boolean  NOT NULL,
    sillas int  NOT NULL,
    cocina boolean  NOT NULL,
    CONSTRAINT PK_GR02_Habitacion PRIMARY KEY (id_dpto,id_habitacion)
);

-- Table: GR02_Huesped
CREATE TABLE GR02_Huesped (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    CONSTRAINT PK_GR02_Huesped PRIMARY KEY (tipo_doc,nro_doc)
);

-- Table: GR02_Huesped_Reserva
CREATE TABLE GR02_Huesped_Reserva (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    id_reserva bigint  NOT NULL,
    CONSTRAINT PK_GR02_Huesped_reserva PRIMARY KEY (tipo_doc,nro_doc,id_reserva)
);

-- Table: GR02_Pago
CREATE TABLE GR02_Pago (
    fecha_pago timestamp  NOT NULL,
    id_reserva bigint  NOT NULL,
    id_tipo_pago int  NOT NULL,
    comentario varchar(80)  NULL,
    importe decimal(10,2)  NOT NULL,
    CONSTRAINT PK_GR02_Pago PRIMARY KEY (fecha_pago,id_reserva,id_tipo_pago)
);

-- Table: GR02_Persona
CREATE TABLE GR02_Persona (
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    apellido varchar(80)  NOT NULL,
    nombre varchar(80)  NOT NULL,
    fecha_nac date  NOT NULL,
    e_mail varchar(80)  NOT NULL,
    CONSTRAINT PK_GR02_Persona PRIMARY KEY (tipo_doc,nro_doc)
);

-- Table: GR02_Reserva
CREATE TABLE GR02_Reserva (
    id_reserva bigint  NOT NULL,
    fecha_reserva date  NOT NULL,
    fecha_desde date  NOT NULL,
    fecha_hasta date  NOT NULL,
    tipo varchar(15)  NOT NULL,
    id_dpto int  NOT NULL,
    valor_noche decimal(10,2)  NOT NULL,
    usa_limpieza smallint  NOT NULL,
    tipo_doc int  NOT NULL,
    nro_doc decimal(11,0)  NOT NULL,
    CONSTRAINT PK_GR02_Reserva PRIMARY KEY (id_reserva)
);

-- Table: GR02_Tipo_Dpto
CREATE TABLE GR02_Tipo_Dpto (
    id_tipo_depto int  NOT NULL,
    cant_habitaciones int  NOT NULL,
    cant_banios int  NOT NULL,
    cant_max_huespedes int  NOT NULL,
    CONSTRAINT PK_GR02_Tipo_Dpto PRIMARY KEY (id_tipo_depto)
);

-- Table: GR02_Tipo_Pago
CREATE TABLE GR02_Tipo_Pago (
    id_tipo_pago int  NOT NULL,
    nombre varchar(80)  NOT NULL,
    CONSTRAINT PK_GR02_Tipo_pago PRIMARY KEY (id_tipo_pago)
);

CREATE TABLE GR02_Tipo_doc(
    id_tipo_doc SERIAL,
    nombre varchar(3) NOT NULL,     
    CONSTRAINT PK_GR02_Tipo_doc PRIMARY KEY (id_tipo_doc)
);

-- foreign keys
-- Reference: FK_Comentario_Huesped_Reserva (table: GR02_Comentario)
ALTER TABLE GR02_Comentario ADD CONSTRAINT FK_GR02_Comentario_Huesped_Reserva
    FOREIGN KEY (tipo_doc, nro_doc, id_reserva)
    REFERENCES GR02_Huesped_Reserva (tipo_doc, nro_doc, id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_CostoDepto_Departamento (table: GR02_Costo_Depto)
ALTER TABLE GR02_Costo_Depto ADD CONSTRAINT FK_GR02_CostoDepto_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR02_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Departamento_Persona (table: GR02_Departamento)
ALTER TABLE GR02_Departamento ADD CONSTRAINT FK_GR02_Departamento_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR02_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Departamento_Tipo_Dpto (table: GR02_Departamento)
ALTER TABLE GR02_Departamento ADD CONSTRAINT FK_GR02_Departamento_Tipo_Dpto
    FOREIGN KEY (id_tipo_depto)
    REFERENCES GR02_Tipo_Dpto (id_tipo_depto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Estado_Luego_Ocupacion_Reserva (table: GR02_Estado_Luego_Ocupacion_Reserva)
ALTER TABLE GR02_Estado_Luego_Ocupacion_Reserva ADD CONSTRAINT FK_GR02_Estado_Luego_Ocupacion_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR02_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Habitacion_Departamento (table: GR02_Habitacion)
ALTER TABLE GR02_Habitacion ADD CONSTRAINT FK_GR02_Habitacion_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR02_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Huesped_Persona (table: GR02_Huesped)
ALTER TABLE GR02_Huesped ADD CONSTRAINT FK_GR02_Huesped_Persona
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR02_Persona (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Huesped_Reserva_Huesped (table: GR02_Huesped_Reserva)
ALTER TABLE GR02_Huesped_Reserva ADD CONSTRAINT FK_GR02_Huesped_Reserva_Huesped
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR02_Huesped (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Huesped_Reserva_Reserva (table: GR02_Huesped_Reserva)
ALTER TABLE GR02_Huesped_Reserva ADD CONSTRAINT FK_GR02_Huesped_Reserva_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR02_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Pago_Reserva (table: GR02_Pago)
ALTER TABLE GR02_Pago ADD CONSTRAINT FK_GR02_Pago_Reserva
    FOREIGN KEY (id_reserva)
    REFERENCES GR02_Reserva (id_reserva)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Pago_Tipo_Pago (table: GR02_Pago)
ALTER TABLE GR02_Pago ADD CONSTRAINT FK_GR02_Pago_Tipo_Pago
    FOREIGN KEY (id_tipo_pago)
    REFERENCES GR02_Tipo_Pago (id_tipo_pago)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Reserva_Departamento (table: GR02_Reserva)
ALTER TABLE GR02_Reserva ADD CONSTRAINT FK_GR02_Reserva_Departamento
    FOREIGN KEY (id_dpto)
    REFERENCES GR02_Departamento (id_dpto)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: FK_Reserva_Huesped (table: GR02_Reserva)
ALTER TABLE GR02_Reserva ADD CONSTRAINT FK_GR02_Reserva_Huesped
    FOREIGN KEY (tipo_doc, nro_doc)
    REFERENCES GR02_Huesped (tipo_doc, nro_doc)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

ALTER TABLE GR02_Persona ADD CONSTRAINT FK_GR02_Persona_Tipo_Doc
    FOREIGN KEY (tipo_doc)
    REFERENCES GR02_Tipo_Doc (id_tipo_doc)
    NOT DEFERRABLE
    INITIALLY IMMEDIATE
;

--Indices
CREATE INDEX IDX_GR02_Departamento
    ON GR02_Departamento ( ciudad );
CREATE INDEX IDX_GR02_Pago
    ON GR02_Pago ( id_reserva );
CREATE INDEX IDX_GR02_Reserva_Departamento
    ON GR02_Reserva ( id_dpto );


--Insertar Datos
--Tipos Documentos GR02_Tipo_Doc
INSERT INTO GR02_Tipo_Doc(Nombre) Values('DNI');
INSERT INTO GR02_Tipo_Doc(Nombre) Values('LE');
INSERT INTO GR02_Tipo_Doc(Nombre) Values('CI');
INSERT INTO GR02_Tipo_Doc(Nombre) Values('CE');
INSERT INTO GR02_Tipo_Doc(Nombre) Values('CC');
--Tipos Departamentos GR02_Tipo_Depto
INSERT INTO GR02_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) Values(1,2,1,4);
INSERT INTO GR02_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) Values(2,3,2,5);
INSERT INTO GR02_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) Values(3,3,2,6);
INSERT INTO GR02_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) Values(4,4,2,8);
INSERT INTO GR02_Tipo_Dpto(id_tipo_depto,cant_habitaciones,cant_banios,cant_max_huespedes) Values(5,1,1,2);
--Tipo Pago GR02_Tipo_Pago
INSERT INTO GR02_Tipo_Pago(id_tipo_pago, nombre) Values(1, 'Efectivo');
INSERT INTO GR02_Tipo_Pago(id_tipo_pago, nombre) Values(2, 'Credito');
INSERT INTO GR02_Tipo_Pago(id_tipo_pago, nombre) Values(3, 'Debito');
INSERT INTO GR02_Tipo_Pago(id_tipo_pago, nombre) Values(4, 'Transferencia');
INSERT INTO GR02_Tipo_Pago(id_tipo_pago, nombre) Values(5, 'Deposito');
--Personas GR02_Persona
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 36626800, 'Meliendrez', 'Agustin', '1992-05-16', 'ameliendrez@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 36328314, 'Santos', 'Luciano', '1991-08-22', 'luchosan74@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 16713110, 'Santos', 'Gustavo', '1964-05-04', 'gustavo@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 22334502, 'Rodriguez', 'Esteba', '1972-03-11', 'estebanquito@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 26243466, 'Lescano', 'Pablo', '1977-12-08', 'pablitolescano@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 28343466, 'Rodriguez', 'Ariel', '1980-12-08', 'arielrodriguez@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 30243466, 'Ronaldo', 'Cristiano', '1983-12-08', 'cr7@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 32243466, 'Messi', 'Lionel', '1985-9-08', 'pulga@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 24243466, 'Lima', 'Carlos', '1975-12-08', 'limado@gmail.com');
INSERT INTO GR02_Persona(tipo_doc, nro_doc, apellido, nombre, fecha_nac, e_mail) 
    Values(1, 19243466, 'Granado', 'Sandro', '1970-12-08', 'sangrana@gmail.com');       
--Departamentos GR02_Departamento
INSERT INTO GR02_Departamento (id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza,ciudad) 
    VALUES(1,'Linda vista al mar',50,1,1,36626800,800,100,'Mar del Plata');
INSERT INTO GR02_Departamento (id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza,ciudad) 
    VALUES(2,'Habitaciones grandes',90,2,1,36328314,1000,150,'Bariloche');
INSERT INTO GR02_Departamento (id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza,ciudad) 
    VALUES(3,'Cocina moderna',80,3,1,16713110,1000,150,'Villa San Carlos');
INSERT INTO GR02_Departamento (id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza,ciudad) 
    VALUES(4,'Comedor grande',120,4,1,22334502,1200,200,'Misiones');
INSERT INTO GR02_Departamento (id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza,ciudad) 
    VALUES(5,'Ideal para estudiantes',40,5,1,26243466,600,70,'Mendoza');
INSERT INTO GR02_Departamento (id_dpto,descripcion,superficie,id_tipo_depto,tipo_doc,nro_doc,precio_noche,costo_limpieza,ciudad) 
    VALUES(6,'Hermosa vista',40,5,1,19243466,700,80,'Mar del Plata');
--Habitaciones GR02_Habitacion
--Habitaciones Departamento 1
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(1,1,2,0,0,true,0,false,false,0,false);
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(1,2,0,1,0,true,1,true,false,1,false);
--Habitaciones Departamento 2    
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(2,1,1,0,1,true,0,false,false,0,false);
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(2,2,0,1,0,true,0,false,false,0,false);
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(2,3,0,0,0,true,1,true,true,5,true);
--Habitaciones Departamento 3            
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(3,1,1,0,1,true,0,false,false,0,false);
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(3,2,1,1,0,true,0,false,false,0,false);
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(3,3,0,0,0,true,1,true,true,6,true);
--Habitaciones Departamento 4
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(4,1,0,0,2,true,0,false,false,0,false);
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(4,2,2,0,0,true,0,false,false,0,false);
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(4,3,0,1,0,true,0,true,false,0,false);
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(4,4,0,0,0,true,2,true,true,8,true);
--Habitaciones Departamento 5
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(5,1,2,0,0,true,1,false,true,3,true);   
--Habitaciones Departamento 6 
INSERT INTO GR02_Habitacion (id_dpto,id_habitacion,posib_camas_simples,posib_camas_dobles,posib_camas_kind,tv,sillon,frigobar,mesa,sillas,cocina)
    VALUES(6,1,2,0,0,true,1,false,true,3,true);  
--Costos Departamentos GR02_Costo_Depto
INSERT INTO GR02_Costo_Depto (id_dpto,fecha_desde,fecha_hasta,precio_noche)
    VALUES(1,'2018-01-01','2018-12-01',800);
INSERT INTO GR02_Costo_Depto (id_dpto,fecha_desde,fecha_hasta,precio_noche)
    VALUES(2,'2018-01-01','2018-12-01',1000);
INSERT INTO GR02_Costo_Depto (id_dpto,fecha_desde,fecha_hasta,precio_noche)
    VALUES(3,'2018-01-01','2018-12-01',1000);
INSERT INTO GR02_Costo_Depto (id_dpto,fecha_desde,fecha_hasta,precio_noche)
    VALUES(4,'2018-01-01','2018-12-01',1200);
INSERT INTO GR02_Costo_Depto (id_dpto,fecha_desde,fecha_hasta,precio_noche)
    VALUES(5,'2018-01-01','2018-12-01',600);     
INSERT INTO GR02_Costo_Depto (id_dpto,fecha_desde,fecha_hasta,precio_noche)
    VALUES(6,'2018-01-01','2018-12-01',700);            
--Huespedes GR02_Huesped
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 36626800);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 36328314);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 16713110);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 22334502);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 26243466);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 28343466);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 30243466);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 32243466);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 24243466);
INSERT INTO GR02_Huesped(tipo_doc, nro_doc) 
    VALUES(1, 19243466);
--Reservas GR02_Reserva
INSERT INTO GR02_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
    VALUES(1,'2017-12-01','2018-01-01','2018-02-01','Telefonica',1,800,1,1,26243466);
INSERT INTO GR02_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
    VALUES(2,'2017-12-21','2018-01-01','2018-02-01','Personal',2,1000,0,1,22334502);
INSERT INTO GR02_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
    VALUES(3,'2017-12-11','2018-01-01','2018-02-01','Telefonica',3,1000,1,1,36328314);
INSERT INTO GR02_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
    VALUES(4,'2017-11-07','2018-01-01','2018-02-01','E-Mail',4,1200,1,1,16713110);
INSERT INTO GR02_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
    VALUES(5,'2017-12-08','2018-01-01','2018-02-01','E-mail',5,600,0,1,36626800);
INSERT INTO GR02_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
    VALUES(6,'2017-12-08','2018-01-01','2018-02-01','E-mail',6,700,0,1,32243466);
INSERT INTO GR02_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
    VALUES(7,'2018-01-08','2018-02-05','2018-04-01','Telefonica',6,700,0,1,19243466);
--Estado luego de la ocupacion de la reserva GR02_Estado_Luego_Ocupacion_Reserva
INSERT INTO GR02_Estado_Luego_Ocupacion_Reserva(fecha, id_reserva,comentario) 
    VALUES(1,1,'En buen estado todo');
INSERT INTO GR02_Estado_Luego_Ocupacion_Reserva(fecha, id_reserva,comentario) 
    VALUES(1,2,'Muy sucio');
INSERT INTO GR02_Estado_Luego_Ocupacion_Reserva(fecha, id_reserva,comentario) 
    VALUES(1,3,'Excelente estado, todo ordenado');
INSERT INTO GR02_Estado_Luego_Ocupacion_Reserva(fecha, id_reserva,comentario) 
    VALUES(1,4,'Limpio pero con una lamparita quemada');
INSERT INTO GR02_Estado_Luego_Ocupacion_Reserva(fecha, id_reserva,comentario) 
    VALUES(1,5,'Silla rota y Mesa con desgaste');
INSERT INTO GR02_Estado_Luego_Ocupacion_Reserva(fecha, id_reserva,comentario) 
    VALUES(1,6,'Todo en orden');
INSERT INTO GR02_Estado_Luego_Ocupacion_Reserva(fecha, id_reserva,comentario) 
    VALUES(1,7,'Impecable y limpio');
--Huesped Reserva GR02_Huesped_Reserva
--19243466 ,24243466,32243466,28343466
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,26243466,1);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,19243466,1);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,24243466,1);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,28343466,1);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,22334502,2);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,28343466,2);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,32243466,2);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,36328314,3);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,16713110,4);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,36626800,5);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,28343466,5);                    
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,28343466,6);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,24243466,6);                    
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,19243466,7);
INSERT INTO GR02_Huesped_Reserva(tipo_doc,nro_doc,id_reserva) 
    VALUES(1,28343466,7);                    
--Comentarios GR02_Comentario
INSERT INTO GR02_Comentario(tipo_doc,nro_doc,id_reserva,fecha_hora_comentario,comentario,estrellas)
    VALUES(1,26243466,1,'2018-02-05','Muy linda vista, estoy muy conforme',5);                
INSERT INTO GR02_Comentario(tipo_doc,nro_doc,id_reserva,fecha_hora_comentario,comentario,estrellas)
    VALUES(1,22334502,2,'2018-02-06','Mucho espacio y muy comodo',5);
INSERT INTO GR02_Comentario(tipo_doc,nro_doc,id_reserva,fecha_hora_comentario,comentario,estrellas)
    VALUES(1,36328314,3,'2018-02-21','Hermoso departamento, muy confortable',4);
INSERT INTO GR02_Comentario(tipo_doc,nro_doc,id_reserva,fecha_hora_comentario,comentario,estrellas)
    VALUES(1,16713110,4,'2018-03-01','Grande y lindo',4);
INSERT INTO GR02_Comentario(tipo_doc,nro_doc,id_reserva,fecha_hora_comentario,comentario,estrellas)
    VALUES(1,36626800,5,'2018-03-11','Muy poco espacio y mala calidad de las cosas',2);
INSERT INTO GR02_Comentario(tipo_doc,nro_doc,id_reserva,fecha_hora_comentario,comentario,estrellas)
    VALUES(1,28343466,6,'2018-03-11','Muy lindo',5);
INSERT INTO GR02_Comentario(tipo_doc,nro_doc,id_reserva,fecha_hora_comentario,comentario,estrellas)
    VALUES(1,19243466,7,'2018-12-11','Me gusto',4);
--Pagos GR02_Pago
INSERT INTO GR02_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
    VALUES('2018-01-01',1,1,'Se abono la totalidad',800);
INSERT INTO GR02_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
    VALUES('2018-01-01',2,2,'Pago Total',1000);
INSERT INTO GR02_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
    VALUES('2018-01-01',3,1,'',1000);
INSERT INTO GR02_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
    VALUES('2018-01-01',4,3,'',1200);
INSERT INTO GR02_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
    VALUES('2018-01-01',5,4,'',600);
INSERT INTO GR02_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
    VALUES('2018-01-01',6,4,'',700);
INSERT INTO GR02_Pago(fecha_pago,id_reserva,id_tipo_pago,comentario,importe)
    VALUES('2018-02-06',7,4,'',700);                
-- End of file.

