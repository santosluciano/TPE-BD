<?php
  include_once 'libs/Smarty.class.php';

  class View
  {
    protected $smarty;

    function __construct()
    {
      $this->smarty = new smarty();
      $this->smarty->assign('titulo', 'Berna Deco');
      $this->smarty->assign('base_sitio', HOME);
    }
  }
?>
