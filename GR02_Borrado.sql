--- Borrado de tablas
DROP TABLE IF EXISTS GR02_Departamento CASCADE;
DROP TABLE IF EXISTS GR02_Habitacion CASCADE;
DROP TABLE IF EXISTS GR02_Tipo_Dpto CASCADE;
DROP TABLE IF EXISTS GR02_Reserva CASCADE;
DROP TABLE IF EXISTS GR02_Comentario CASCADE;
DROP TABLE IF EXISTS GR02_Huesped_Reserva CASCADE;
DROP TABLE IF EXISTS GR02_Huesped CASCADE;
DROP TABLE IF EXISTS GR02_Persona CASCADE;
DROP TABLE IF EXISTS GR02_Tipo_Doc CASCADE;
DROP TABLE IF EXISTS GR02_Pago CASCADE;
DROP TABLE IF EXISTS GR02_Tipo_Pago CASCADE;
DROP TABLE IF EXISTS GR02_Estado_Luego_Ocupacion_Reserva CASCADE;
DROP TABLE IF EXISTS GR02_Costo_Depto CASCADE;
--- Borrado de funciones y funciones triggers
DROP FUNCTION fn_gr02_departamento_estado;
DROP FUNCTION fn_gr02_departamentos_disponibles;
DROP FUNCTION trfn_gr02_cantidad_habitaciones;
DROP FUNCTION trfn_gr02_cantidad_habitaciones_tipo;
DROP FUNCTION trfn_gr02_cantidad_huespedes;
DROP FUNCTION trfn_gr02_cantidad_huespedes_max;
DROP FUNCTION trfn_gr02_reserva_huespedes_no_propietarios;