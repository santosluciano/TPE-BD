--Restriccion que permite que las fechas de reserva sean consistentes
ALTER TABLE gr02_reserva ADD CONSTRAINT chk_fecha CHECK(
   fecha_desde < fecha_hasta
);
--INSERT INTO GR02_Reserva(id_reserva,fecha_reserva,fecha_desde,fecha_hasta,tipo,id_dpto,valor_noche,usa_limpieza,tipo_doc,nro_doc)
--    VALUES(8,'2017-12-01','2018-07-01','2018-04-01','Telefonica',1,800,1,1,26243466);
--el nuevo registro para la relación «gr02_reserva» viola la restricción «check» «chk_fecha»
--UPDATE GR02_Reserva SET fecha_desde = '2018-02-02' WHERE id_reserva = 1
--el nuevo registro para la relación «gr02_reserva» viola la restricción «check» «chk_fecha»

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
CREATE OR REPLACE FUNCTION TRFN_GR02_Cantidad_Habitaciones() RETURNS TRIGGER AS $$
BEGIN
	IF(EXISTS (SELECT 1
		FROM gr02_departamento d 
 			JOIN gr02_tipo_dpto td ON (td.id_tipo_depto = d.id_tipo_depto)
 			WHERE d.id_dpto = new.id_dpto AND
		  		td.cant_habitaciones < (SELECT COUNT(*) FROM gr02_habitacion h
								  			WHERE h.id_dpto = d.id_dpto))) THEN
		RAISE EXCEPTION 'La habitacion ya tiene el maximo de habitaciones permitidas';
	END IF;
RETURN new;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION TRFN_GR02_Cantidad_Habitaciones_Tipo() RETURNS TRIGGER AS $$
BEGIN
	IF(EXISTS (SELECT 1
		FROM gr02_departamento d 
 			JOIN gr02_tipo_dpto td ON (td.id_tipo_depto = d.id_tipo_depto)
 			WHERE d.id_tipo_depto = new.id_tipo_depto AND
		  		td.cant_habitaciones < (SELECT COUNT(*) FROM gr02_habitacion h
								  			WHERE h.id_dpto = d.id_dpto))) THEN
		RAISE EXCEPTION 'Hay un departamento con mas habitaciones que el maximo';
	END IF;
RETURN new;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER TR_Cantidad_Habitaciones 
AFTER INSERT OR UPDATE OF id_dpto ON gr02_Habitacion 
FOR EACH ROW  EXECUTE PROCEDURE TRFN_GR02_Cantidad_Habitaciones();

CREATE TRIGGER TR_Cantidad_Habitaciones2
AFTER UPDATE OF id_tipo_depto ON gr02_Departamento
FOR EACH ROW EXECUTE PROCEDURE TRFN_GR02_Cantidad_Habitaciones();

CREATE TRIGGER TR_Cantidad_Habitaciones_tipo
AFTER UPDATE OF cant_habitaciones ON gr02_tipo_dpto
FOR EACH ROW EXECUTE PROCEDURE TRFN_GR02_Cantidad_Habitaciones_Tipo();

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
CREATE OR REPLACE FUNCTION TRFN_GR02_Reserva_Huespedes_No_Propietarios() RETURNS TRIGGER AS $$
BEGIN
	IF(EXISTS (SELECT 1
				FROM gr02_reserva r 
 				LEFT JOIN gr02_huesped_reserva hr ON (hr.id_reserva = r.id_reserva)
 				WHERE EXISTS(SELECT 1 
				 				FROM gr02_departamento d 
				 				WHERE (r.id_reserva = new.id_reserva)
							 		AND (d.id_dpto = r.id_dpto) 
							 		AND ((d.tipo_doc = r.tipo_doc AND d.nro_doc = r.nro_doc) 
				 					OR (d.tipo_doc = hr.tipo_doc AND d.nro_doc = hr.nro_doc))))) THEN
		RAISE EXCEPTION 'No se puede hacer la reserva, un huesped o el que hace la reserva es propietario';
	END IF;
RETURN new;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER TR_GR02_Reserva_No_Propietario 
AFTER INSERT OR UPDATE OF tipo_doc, nro_doc ON gr02_reserva 
FOR EACH ROW EXECUTE PROCEDURE TRFN_GR02_Reserva_Huespedes_No_Propietarios();

CREATE TRIGGER TR_GR02_Huesped_Reserva_No_Propietario 
AFTER INSERT OR UPDATE OF id_reserva ON gr02_huesped_reserva 
FOR EACH ROW EXECUTE PROCEDURE TRFN_GR02_Reserva_Huespedes_No_Propietarios();

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
CREATE OR REPLACE FUNCTION TRFN_GR02_Cantidad_Huespedes() RETURNS TRIGGER AS $$
BEGIN
	IF(EXISTS (SELECT r.* 
	FROM gr02_reserva r
	JOIN gr02_departamento d 
		ON (r.id_dpto = d.id_dpto)
	JOIN gr02_tipo_dpto td 
		ON (td.id_tipo_depto = d.id_tipo_depto)
	WHERE new.id_reserva = r.id_reserva AND 
        td.cant_max_huespedes < (SELECT COUNT(*) 
								   		FROM gr02_huesped_reserva hr
								  		WHERE hr.id_reserva = r.id_reserva))) THEN
		RAISE EXCEPTION 'La cantidad de huespedes excede el maximo de la habitacion';
	END IF;
RETURN new;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION TRFN_GR02_Cantidad_Huespedes_Max() RETURNS TRIGGER AS $$
BEGIN
	IF(EXISTS (SELECT r.* 
	FROM gr02_reserva r
	JOIN gr02_departamento d 
		ON (r.id_dpto = d.id_dpto)
	JOIN gr02_tipo_dpto td 
		ON (td.id_tipo_depto = d.id_tipo_depto)
	WHERE new.id_tipo_depto = td.id_tipo_depto AND 
        td.cant_max_huespedes < (SELECT count(*) 
								   		FROM gr02_huesped_reserva hr
								  		WHERE hr.id_reserva = r.id_reserva))) THEN
		raise exception 'La cantidad de huespedes de una reserva excede el maximo';
	END IF;
RETURN new;
END; $$ LANGUAGE plpgsql;

CREATE TRIGGER TR_GR02_Cantidad_Huespedes 
AFTER INSERT OR UPDATE OF id_reserva ON gr02_huesped_reserva 
FOR EACH ROW EXECUTE PROCEDURE TRFN_GR02_Cantidad_Huespedes();

CREATE TRIGGER TR_GR02_Cantidad_Huespedes2 
AFTER UPDATE OF id_dpto ON gr02_reserva
FOR EACH ROW EXECUTE PROCEDURE TRFN_GR02_Cantidad_Huespedes();

CREATE TRIGGER TR_GR02_Cantidad_Huespedes_Max 
AFTER UPDATE OF id_tipo_depto ON gr02_departamento
FOR EACH ROW EXECUTE PROCEDURE TRFN_GR02_Cantidad_Huespedes_Max();

CREATE TRIGGER TR_GR02_Cantidad_Huespedes_Max2
AFTER UPDATE OF cant_max_huespedes on gr02_tipo_dpto
FOR EACH ROW EXECUTE PROCEDURE TRFN_GR02_Cantidad_Huespedes_Max();

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
			IF EXISTS(SELECT 1 
					  	FROM gr02_reserva r
						WHERE consulta.id_dpto = r.id_dpto 
							AND fecha BETWEEN fecha_desde AND fecha_hasta) THEN
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
CREATE OR REPLACE FUNCTION FN_GR02_Departamentos_Disponibles (fecha_inicio DATE,fecha_fin DATE,city VARCHAR) 
	RETURNS TABLE ( id_dpto INTEGER ) 
	AS $$
	DECLARE
		consulta RECORD;
	BEGIN
 		FOR consulta IN(
			SELECT d.id_dpto 
				FROM gr02_departamento d
				WHERE d.ciudad 
					LIKE city AND  
					NOT EXISTS(SELECT 1
							   	FROM GR02_Reserva r 
							   	WHERE r.id_dpto = d.id_dpto 
								   	AND (r.fecha_desde BETWEEN fecha_inicio AND fecha_fin) 
									OR (r.fecha_hasta BETWEEN fecha_inicio AND fecha_fin)))  
 		LOOP
     			id_dpto := consulta.id_dpto ; 
        RETURN NEXT;
 END LOOP;
END; $$ LANGUAGE plpgsql;
--Ejemplo de como llamar a la funcion
--select * from Departamentos_Disponibles('2018-02-02','2018-06-05','Mar del Plata');
--se coloca la fecha_inicio, fecha_hasta, ciudad
-------------------------------------------------------------------------------------------------
--VISTAS
--Devuelva un listado de todos los departamentos del sistema junto con la recaudación 
--de los mismos en los últimos 6 meses.
CREATE VIEW V_GR02_DEPTO_RECAUDACION_6_MESES AS
	SELECT d.*,SUM(p.importe) AS recaudacion  
		FROM GR02_Departamento d
		LEFT JOIN GR02_Reserva r 
			ON (r.id_dpto = d.id_dpto)
		LEFT JOIN GR02_Pago p 
			ON (p.id_reserva = r.id_reserva 
				AND p.fecha_pago >= current_date - interval '6 month')
		GROUP BY d.id_dpto
		ORDER BY d.id_dpto;
--Devuelve un listado con los departamentos ordenados por ciudad y por mejor rating (estrellas)
CREATE VIEW V_GR02_DEPTO_CIUDAD_RATING  AS
  SELECT d.*,avg(c.estrellas) AS rating
	FROM GR02_Departamento d
	JOIN GR02_Reserva r 
		ON (r.id_dpto = d.id_dpto)
	JOIN GR02_Huesped_Reserva hr 
		ON (hr.id_reserva = r.id_reserva)
	JOIN GR02_Comentario c 
		ON (c.id_reserva = hr.id_reserva)
	GROUP BY d.id_dpto	
	ORDER BY ciudad,rating desc;

