<?php
    //Librerias incluidas
    include_once 'config/Router.php';
    include_once 'model/Model.php';
    include_once 'view/View.php';
    include_once 'controller/Controller.php';
    include_once 'controller/NavigationController.php';

    $router = new Router();
    //(url, verb, controller, method)
    //Navegacion
    $router->AddRoute("", "GET", "NavigationController", "index");
    $router->AddRoute("home", "GET", "NavigationController", "inicio");

    //Se carga la accion que viene por url y se llama a la funcion url para que genere el array 
    //con el controlador, el metodo y los parametros por url
    $route = $_GET['action'];
    $array = $router->Route($route);

    if(sizeof($array) == 0)
        echo (new NavigationController())->index();
    else
    {
        $controller = $array[0];
        $metodo = $array[1];
        $url_params = $array[2];
        echo (new $controller())->$metodo($url_params);
    }
?>

