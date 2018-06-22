--Restriccion que permite que las fechas sean consistentes
alter table gr02_reserva add constraint chk_fecha check(
   fecha_desde < fecha_hasta
);
-----------------------------------------------------------------------------------------------------
--Restriccion declarativa que controla que un depto no tenga mas habitaciones que las que permite el mismo
CREATE ASSERTION CK_Cantidad_Habitaciones
CHECK (NOT EXISTS
(SELECT 1
FROM gr02_departamento d 
 	JOIN gr02_tipo_dpto td ON (td.id_tipo_depto = d.id_tipo_depto)
 	WHERE td.cant_habitaciones < (SELECT COUNT(*) FROM gr02_habitacion h
								  		WHERE h.id_dpto = d.id_dpto)));
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

create trigger TR_Cantidad_Habitaciones 
after insert or update of id_dpto on gr02_Habitacion 
for each row  execute procedure fn_cantidad_habitaciones();

create trigger TR_Cantidad_Habitaciones2
after update of id_tipo_depto on gr02_Departamento
for each row execute procedure fn_cantidad_habitaciones();
-----------------------------------------------------------------------------------------
--Restriccion declarativa que controla que la cantidad de huespedes no exceda la cantidad maxima del departamento
CREATE ASSERTION CK_Cantidad_Huespedes
CHECK (NOT EXISTS
(select r.* 
	from gr02_reserva r
	join gr02_departamento d on (r.id_dpto = d.id_dpto)
	join gr02_tipo_dpto td on (td.id_tipo_depto = d.id_tipo_depto)
	where td.cant_max_huespedes < (select count(*) 
								   		from gr02_huesped_reserva hr
								  		where hr.id_reserva = r.id_reserva)));
--Restriccion implementada, tengo que conciderar ademas con otra funcion si cambio el tipo_depto o del depto                                       
create or replace function fn_cantidad_huespedes() returns trigger as $$
begin
	if(exists (select r.* 
	from gr02_reserva r
	join gr02_departamento d on (r.id_dpto = d.id_dpto)
	join gr02_tipo_dpto td on (td.id_tipo_depto = d.id_tipo_depto)
	where new. 
        td.cant_max_huespedes < (select count(*) 
								   		from gr02_huesped_reserva hr
								  		where hr.id_reserva = r.id_reserva))) then
		raise exception 'La cantidad de huespedes excede el maximo de la habitacion';
	end if;
return new;
end; $$ language plpgsql;

create trigger TR_Cantidad_Habitaciones 
after insert or update of id_dpto on gr02_Habitacion 
for each row  execute procedure fn_cantidad_habitaciones();

create trigger TR_Cantidad_Habitaciones2
after update of id_tipo_depto on gr02_Departamento
for each row execute procedure fn_cantidad_habitaciones();