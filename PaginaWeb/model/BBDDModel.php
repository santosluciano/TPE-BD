<?php

  class BBDDModel extends Model
  {
    function __construct()
    {
      parent::__construct();
    }

    function getDepartamentos()
    {

      $sentencia = $this->db->prepare("SELECT * FROM gr02_departamento");
      $sentencia->execute();
      $departamentos = $sentencia->fetchAll(PDO::FETCH_ASSOC);
      return $departamentos;
    }

    function getDeptoById($id)
    {
      $sentencia = $this->db->prepare("SELECT * FROM gr02_departamento WHERE id_dpto = ?");
      $sentencia->execute([$id]);
      $departamento = $sentencia->fetch(PDO::FETCH_ASSOC);
      return $departamento;
    }

    public function getEstadoDpto($values){

      $salida = $this->db->prepare("SELECT fecha_desde, fecha_hasta
      FROM gr02_reserva
      WHERE id_dpto = ?
        AND ((fecha_desde >= ? OR fecha_hasta < ?) OR (fecha_desde <= ? AND fecha_hasta >= ?))");
      $salida->execute($values);
      return $salida->fetchAll(PDO::FETCH_ASSOC);
    }
  }
?>
