--Restriccion que permite que las fechas sean consistentes
alter table gr02_reserva add constraint chk_fecha check(
   fecha_desde < fecha_hasta
);
