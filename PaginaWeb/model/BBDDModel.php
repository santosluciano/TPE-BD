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

    public function getEstado($fecha, $dpto){

      $salida = $this->db->prepare("SELECT * FROM FN_GR02_Departamento_Estado(?) WHERE id_dpto=?");
      $salida->execute([$fecha, $dpto]);
      return $salida->fetch();
    }
  }
?>
