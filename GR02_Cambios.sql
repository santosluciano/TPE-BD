--Restriccion que permite que las fechas sean consistentes
ALTER TABLE gr02_reserva add CONSTRAINT chk_fecha CHECK(
   fecha_desde < fecha_hasta
);
-----------------------------------------------------------------------------------------------------
--Restriccion declarativa que controla que un depto no tenga mas habitaciones que las que permite el mismo
/*CREATE ASSERTION CK_Cantidad_Habitaciones
CHECK (NOT EXISTS
(SELECT 1
FROM gr02_departamento d 
 	JOIN gr02_tipo_dpto td ON (td.id_tipo_depto = d.id_tipo_depto)
 	WHERE td.cant_habitaciones < (SELECT COUNT(*) FROM gr02_habitacion h
								  		WHERE h.id_dpto = d.id_dpto)));*/
--Restriccion implementada
CREATE OR REPLACE FUNCTION TRFN_GR02_cantidad_habitaciones() RETURNS trigger AS $$
BEGIN
	IF(EXISTS (SELECT 1
		FROM gr02_departamento d 
 			JOIN gr02_tipo_dpto td ON (td.id_tipo_depto = d.id_tipo_depto)
 			WHERE d.id_dpto = new.id_dpto AND
		  		td.cant_habitaciones < (SELECT COUNT(*) FROM gr02_habitacion h
								  			WHERE h.id_dpto = d.id_dpto))) THEN
		raise exception 'La habitacion ya tiene el maximo de habitaciones permitidas';
	END IF;
RETURN new;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION TRFN_GR02_cantidad_habitaciones_tipo() RETURNS trigger AS $$
BEGIN
	IF(EXISTS (SELECT 1
		FROM gr02_departamento d 
 			JOIN gr02_tipo_dpto td ON (td.id_tipo_depto = d.id_tipo_depto)
 			WHERE d.id_tipo_depto = new.id_tipo_depto AND
		  		td.cant_habitaciones < (SELECT COUNT(*) FROM gr02_habitacion h
								  			WHERE h.id_dpto = d.id_dpto))) THEN
		raise exception 'Hay un departamento con mas habitaciones que el maximo';
	END IF;
RETURN new;
END; $$ LANGUAGE plpgsql;

CREATE trigger TR_Cantidad_Habitaciones 
AFTER OR INSERT OF of id_dpto ON gr02_Habitacion 
for each row  execute procedure fn_cantidad_habitaciones();

CREATE trigger TR_Cantidad_Habitaciones2
AFTER UPDATE OF id_tipo_depto ON gr02_Departamento
for each ROW EXECUTE procedure fn_cantidad_habitaciones();

CREATE trigger TR_Cantidad_Habitaciones_tipo
AFTER UPDATE OF cant_habitaciones ON gr02_tipo_dpto
for each ROW EXECUTE procedure fn_cantidad_habitaciones_tipo();

--FALTA EN CASO DE ACTUALIZAR CANT_HABITACIONES EN TIPO_DPTO
------------------------------------------------------------------------------------------------
--Restriccion declarativa que controla que tanto la persona que realiza la reserva como los huéspedes no sea el propietario del departamento
/*CREATE ASSERTION CK_Cantidad_Habitaciones
CHECK (NOT EXISTS
(SELECT 1
	FROM gr02_reserva r 
 	JOIN gr02_huesped_reserva hr ON (hr.id_reserva = r.id_reserva)
 	WHERE exists(select 1 
				 	from gr02_departamento d 
				 	where (d.id_dpto = r.id_dpto) and ((d.tipo_doc = r.tipo_doc and d.nro_doc = r.nro_doc) 
				 		OR (d.tipo_doc = hr.tipo_doc and d.nro_doc = hr.nro_doc))))); 
*/
--Restriccion implementada                                       
CREATE OR REPLACE FUNCTION TRFN_GR02_reserva_huespedes_no_propietarios() RETURNS trigger AS $$
BEGIN
	IF(EXISTS (SELECT 1
				FROM gr02_reserva r 
 				LEFT JOIN gr02_huesped_reserva hr ON (hr.id_reserva = r.id_reserva)
 				WHERE EXISTS(SELECT 1 
				 				FROM gr02_departamento d 
				 				WHERE (r.id_reserva = new.id_reserva)
							 		AND (d.id_dpto = r.id_dpto) 
							 		AND ((d.tipo_doc = r.tipo_doc and d.nro_doc = r.nro_doc) 
				 					OR (d.tipo_doc = hr.tipo_doc and d.nro_doc = hr.nro_doc))))) THEN
		raise exception 'No se puede hacer la reserva, un huesped o el que hace la reserva es propietario';
	END IF;
RETURN new;
END; $$ LANGUAGE plpgsql;

CREATE trigger TR_GR02_reserva_no_propietario 
AFTER INSERT OR UPDATE of tipo_doc, nro_doc ON gr02_reserva 
for each row  execute procedure fn_reserva_huespedes_no_propietarios();

CREATE trigger TR_GR02_huesped_reserva_no_propietario 
after insert or update of id_reserva on gr02_huesped_reserva 
for each row  execute procedure fn_reserva_huespedes_no_propietarios();

-----------------------------------------------------------------------------------------
--Restriccion declarativa que controla que la cantidad de huespedes no exceda la cantidad maxima del departamento
/*CREATE ASSERTION CK_Cantidad_Huespedes
CHECK (NOT EXISTS
(select r.* 
	from gr02_reserva r
	join gr02_departamento d on (r.id_dpto = d.id_dpto)
	join gr02_tipo_dpto td on (td.id_tipo_depto = d.id_tipo_depto)
	where td.cant_max_huespedes < (select count(*) 
								   		from gr02_huesped_reserva hr
								  		where hr.id_reserva = r.id_reserva)));*/

--Restriccion implementada, tengo que conciderar ademas con otra funcion si cambio el tipo_depto o del depto                                       
create or replace function TRFN_GR02_cantidad_huespedes() returns trigger as $$
begin
	if(exists (select r.* 
	from gr02_reserva r
	join gr02_departamento d on (r.id_dpto = d.id_dpto)
	join gr02_tipo_dpto td on (td.id_tipo_depto = d.id_tipo_depto)
	where new.id_reserva = r.id_reserva and 
        td.cant_max_huespedes < (select count(*) 
								   		from gr02_huesped_reserva hr
								  		where hr.id_reserva = r.id_reserva))) then
		raise exception 'La cantidad de huespedes excede el maximo de la habitacion';
	end if;
return new;
end; $$ language plpgsql;

create or replace function TRFN_GR02_cantidad_huespedes_max() returns trigger as $$
begin
	if(exists (select r.* 
	from gr02_reserva r
	join gr02_departamento d on (r.id_dpto = d.id_dpto)
	join gr02_tipo_dpto td on (td.id_tipo_depto = d.id_tipo_depto)
	where new.id_tipo_depto = td.id_tipo_depto and 
        td.cant_max_huespedes < (select count(*) 
								   		from gr02_huesped_reserva hr
								  		where hr.id_reserva = r.id_reserva))) then
		raise exception 'La cantidad de huespedes de una reserva excede el maximo';
	end if;
return new;
end; $$ language plpgsql;

create trigger TR_GR02_Cantidad_huespedes 
after insert or update of id_reserva on gr02_huesped_reserva 
for each row  execute procedure fn_cantidad_huespedes();

create trigger TR_GR02_Cantidad_huespedes2 
after update of id_dpto on gr02_reserva
for each row  execute procedure fn_cantidad_huespedes();

create trigger TR_GR02_Cantidad_huespedes_max1 
after update of id_tipo_depto on gr02_departamento
for each row  execute procedure fn_cantidad_huespedes_max();

create trigger TR_GR02_Cantidad_huespedes_max2
after update of cant_max_huespedes on gr02_tipo_dpto
for each row  execute procedure fn_cantidad_huespedes_max();

-------------------------------------------------------------------------------------------------
--SERVICIOS
--Por cada departamento en el sistema, de el estado en una fecha determinada, 
--esto es si el mismo está Ocupado o Libre.
--Se crea una funcion que devuelve una tabla que se fija si en la fecha pasada por parametro 
--el depto esta ocupado o no, si esta ocupado la tabla dira 'ocupado', sino 'libre'
CREATE OR REPLACE FUNCTION FN_GR02_Departamento_Estado (fecha DATE) 
	RETURNS TABLE ( id_dpto INTEGER, estado VARCHAR ) 
	AS $$
	DECLARE
		consulta RECORD;
	BEGIN
 		FOR consulta IN(
			SELECT d.id_dpto 
				FROM gr02_departamento d)  
 		LOOP
			IF exists(SELECT 1 
					  	FROM gr02_reserva r
						WHERE consulta.id_dpto = r.id_dpto and fecha BETWEEN fecha_desde AND fecha_hasta) THEN
     			id_dpto := consulta.id_dpto ; 
    			estado := 'ocupado';
			ELSE
				id_dpto := consulta.id_dpto ; 
    			estado := 'disponible';
			END IF;
        RETURN NEXT;
 END LOOP;
END; $$ LANGUAGE plpgsql;
--Ejemplo de como llamar a la funcion
--select * from Departamento_Estado('2018-04-01');
--Dada una rango de fechas y una ciudad, devuelva una lista de departamentos disponibles
CREATE OR REPLACE FUNCTION FN_GR02_Departamentos_disponibles (fecha_inicio DATE,fecha_fin DATE,city VARCHAR) 
	RETURNS TABLE ( id_dpto INTEGER ) 
	AS $$
	DECLARE
		consulta RECORD;
	BEGIN
 		FOR consulta IN(
			SELECT d.id_dpto 
				FROM gr02_departamento d
				WHERE d.ciudad LIKE city AND  
					NOT EXISTS(SELECT 1
							   	FROM GR02_Reserva r 
							   	WHERE r.id_dpto = d.id_dpto AND (r.fecha_desde BETWEEN fecha_inicio AND fecha_fin) OR (r.fecha_hasta BETWEEN fecha_inicio AND fecha_fin)))  
 		LOOP
     			id_dpto := consulta.id_dpto ; 
        RETURN NEXT;
 END LOOP;
END; $$ LANGUAGE plpgsql;
--Ejemplo de como llamar a la funcion
--select * from Departamentos_disponibles('2018-02-02','2018-06-05','Mar del Plata');
--se coloca la fecha_inicio, fecha_hasta, ciudad
-------------------------------------------------------------------------------------------------
--VISTAS
--Devuelva un listado de todos los departamentos del sistema junto con la recaudación 
--de los mismos en los últimos 6 meses.
CREATE VIEW V_GR02_DEPTO_RECAUDACION_6_MESES AS
	SELECT d.*,SUM(p.importe) as recaudacion  
		FROM GR02_Departamento d
		LEFT JOIN GR02_Reserva r 
			ON (r.id_dpto = d.id_dpto)
		LEFT JOIN GR02_Pago p 
			ON (p.id_reserva = r.id_reserva AND p.fecha_pago >= current_date - interval '6 month')
		GROUP BY d.id_dpto
		ORDER BY d.id_dpto
--Devuelve un listado con los departamentos ordenados por ciudad y por mejor rating (estrellas)
CREATE VIEW V_GR02_DEPTO_CIUDAD_RATING  AS
  SELECT d.*,avg(c.estrellas) as rating
	FROM GR02_Departamento d
	JOIN GR02_Reserva r ON (r.id_dpto = d.id_dpto)
	JOIN GR02_Huesped_Reserva hr ON (hr.id_reserva = r.id_reserva)
	JOIN GR02_Comentario c ON (c.id_reserva = hr.id_reserva)
	GROUP BY d.id_dpto	
	ORDER BY ciudad,rating desc

