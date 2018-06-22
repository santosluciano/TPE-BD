<?php
  require_once('view/NavigationView.php');
  /**
   *
   */
 class NavigationController extends Controller
  {
    function __construct()
    {
      $this->view = new NavigationView();
    }
    public function index()
    {
      $this->view->mostrarIndex();
    }
    public function inicio()
    {
      $this->view->mostrar_inicio();
    }
  }

 ?>
