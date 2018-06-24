--Restriccion que permite que las fechas sean consistentes
alter table gr02_reserva add constraint chk_fecha check(
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
create or replace function fn_cantidad_habitaciones() returns trigger as $$
begin
	if(exists (select 1
		FROM gr02_departamento d 
 			JOIN gr02_tipo_dpto td ON (td.id_tipo_depto = d.id_tipo_depto)
 			WHERE d.id_dpto = new.id_dpto and
		  		td.cant_habitaciones < (SELECT COUNT(*) FROM gr02_habitacion h
								  			WHERE h.id_dpto = d.id_dpto))) then
		raise exception 'La habitacion ya tiene el maximo de habitaciones permitidas';
	end if;
return new;
end; $$ language plpgsql;

create or replace function fn_cantidad_habitaciones_tipo() returns trigger as $$
begin
	if(exists (select 1
		FROM gr02_departamento d 
 			JOIN gr02_tipo_dpto td ON (td.id_tipo_depto = d.id_tipo_depto)
 			WHERE d.id_tipo_depto = new.id_tipo_depto and
		  		td.cant_habitaciones < (SELECT COUNT(*) FROM gr02_habitacion h
								  			WHERE h.id_dpto = d.id_dpto))) then
		raise exception 'Hay un departamento con mas habitaciones que el maximo';
	end if;
return new;
end; $$ language plpgsql;

create trigger TR_Cantidad_Habitaciones 
after insert or update of id_dpto on gr02_Habitacion 
for each row  execute procedure fn_cantidad_habitaciones();

create trigger TR_Cantidad_Habitaciones2
after update of id_tipo_depto on gr02_Departamento
for each row execute procedure fn_cantidad_habitaciones();

create trigger TR_Cantidad_Habitaciones_tipo
after update of cant_habitaciones on gr02_tipo_dpto
for each row execute procedure fn_cantidad_habitaciones_tipo();

--FALTA EN CASO DE ACTUALIZAR CANT_HABITACIONES EN TIPO_DPTO
------------------------------------------------------------------------------------------------
--Restriccion declarativa que controla que tanto la persona que realiza la reserva como los huéspedes no sea el propietario del departamento
/*CREATE ASSERTION CK_Cantidad_Habitaciones
CHECK (NOT EXISTS
(SELECT *
	FROM gr02_reserva r 
 	JOIN gr02_huesped_reserva hr ON (hr.id_reserva = r.id_reserva)
 	WHERE exists(select 1 
				 	from gr02_departamento d 
				 	where (d.id_dpto = r.id_dpto) and ((d.tipo_doc = r.tipo_doc and d.nro_doc = r.nro_doc) 
				 		OR (d.tipo_doc = hr.tipo_doc and d.nro_doc = hr.nro_doc))))); 
*/


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
create or replace function fn_cantidad_huespedes() returns trigger as $$
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

create or replace function fn_cantidad_huespedes_max() returns trigger as $$
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

create trigger TR_Cantidad_huespedes 
after insert or update of id_reserva on gr02_huesped_reserva 
for each row  execute procedure fn_cantidad_huespedes();

create trigger TR_Cantidad_huespedes2 
after update of id_dpto on gr02_reserva
for each row  execute procedure fn_cantidad_huespedes();

create trigger TR_Cantidad_huespedes_max1 
after update of id_tipo_depto on gr02_departamento
for each row  execute procedure fn_cantidad_huespedes_max();

create trigger TR_Cantidad_huespedes_max2
after update of cant_max_huespedes on gr02_tipo_dpto
for each row  execute procedure fn_cantidad_huespedes_max();

-------------------------------------------------------------------------------------------------
--VISTAS
--Devuelve un listado con los departamentos ordenados por ciudad y por mejor rating (estrellas)
CREATE VIEW DEPTO_CIUDAD_RATING  AS
  SELECT d.*,avg(c.estrellas) as rating
	FROM GR02_Departamento d
	JOIN GR02_Reserva r ON (r.id_dpto = d.id_dpto)
	JOIN GR02_Huesped_Reserva hr ON (hr.id_reserva = r.id_reserva)
	JOIN GR02_Comentario c ON (c.id_reserva = hr.id_reserva)
	GROUP BY d.id_dpto	
	ORDER BY ciudad,rating desc

