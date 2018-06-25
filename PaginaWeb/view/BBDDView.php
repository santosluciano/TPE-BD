<?php
  class BBDDView extends View
  {
    function __construct()
    {
      parent::__construct();
    }

    function showHome()
    {
      $this->smarty->display('templates/index.tpl');
    }

    function showDepartamentos($departamentos)
    {
      $this->smarty->assign('departamentos', $departamentos);
      $this->smarty->display('templates/departamentos.tpl');
    }

    function showFechas($departamento)
    {
      $this->smarty->assign('departamento', $departamento);
      $this->smarty->display('templates/fechas.tpl');
    }

  }
 ?>
