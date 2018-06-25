<?php
include_once 'config/db-config.php';

 class Model
  {
    protected $db;

    function __construct()
    {
      try {
        $this->db = new PDO('pgsql:host='.DB_HOST.';'
        .'dbname='.DB_NAME.''
        , DB_USER, DB_PASSWORD);
        $this->db->exec('SET search_path to unc_249048');

      }
      catch (PDOException $e)
      {
        echo $e;

        // buildDDBBfromFile();
      }
    }
  }
//   function buildDDBBfromFile() {
//    try {
//      $connection = new PDO('mysql:host='.DB_HOST, DB_USER, DB_PASSWORD);
//      $connection->exec('CREATE DATABASE IF NOT EXISTS '.DB_NAME);
//      $connection->exec('USE '. DB_NAME);
//      $queries = loadSQLSchema();
//      $connection->exec($queries);
//    } catch (PDOException $e) {
//      echo $e;
//    }
//  }

//    function loadSQLSchema()
//    {
//      $file = fopen(DB_FILE, "r");
//      $getSentencias = "";
//      while(! feof($file))
//      {
//        $getSentencias .= fgets($file);
//      }
//      fclose($file);
//      return $getSentencias;
//    }
?>
