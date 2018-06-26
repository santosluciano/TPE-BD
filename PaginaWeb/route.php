<?php
  define('ACTION', 0);
  define('PARAMS', 1);

  include_once 'config/Router.php';
  include_once 'model/Model.php';
  include_once 'view/View.php';
  include_once 'controller/Controller.php';
  include_once 'controller/BBDDController.php';


  $router = new Router();
  //(url, verb, controller, method)

  $router->AddRoute("", "GET", "BBDDController", "showHome");
  $router->AddRoute("departamentos", "GET", "BBDDController", "showDepartamentos");
  $router->AddRoute("fechas/:id", "GET", "BBDDController", "showFechas");
  $router->AddRoute("disponibilidad", "POST", "BBDDController", "showDisponibilidad");

  $route = $_GET['action'];

  $array = $router->Route($route);

  if(sizeof($array) == 0) {
    echo "404";
  }
  else
  {
      $controller = $array[0];
      $metodo = $array[1];
      $url_params = $array[2];
      echo (new $controller())->$metodo($url_params);
  }
?>
