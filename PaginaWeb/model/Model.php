<?php
  class Model
  {
    protected $db;

    function __construct()
    {
      try {
        $this->db = new PDO('mysql:host='.DB_HOST.';'
        .'dbname='.DB_NAME.';charset=utf8'
        , DB_USER, DB_PASSWORD);
      } catch (PDOException $e) {
        "Hay problemas para conectarse a la base de datos";
        die();
      }
    }
  }
 ?>
