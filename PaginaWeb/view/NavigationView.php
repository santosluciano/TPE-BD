<?php
  class NavigationView extends View
  {
    function mostrarIndex(){
      $this->smarty->display('templates/index.tpl');
    }
    function mostrar_inicio(){
      return $this->smarty->display('templates/inicio.tpl');
    }
    function mostrarError($error){
      $this->smarty->assign('error',$error);
      return $this->smarty->display('templates/error.tpl');
    }
  }

 ?>
