<?php
  require_once 'model/BBDDModel.php';
  require_once 'view/BBDDView.php';

  class BBDDController extends Controller
  {

    function __construct()
    {
      $this->view = new BBDDView();
      $this->model = new BBDDModel();

    }

    public function showHome()
    {
      $this->view->showHome();
    }

    public function showDepartamentos(){
      $departamentos = $this->model->getDepartamentos();
      $this->view->showDepartamentos($departamentos);
    }

    public function showFechas($id)
    {
      $departamento = $this->model->getDeptoById($id[':id']);
      $this->view->showFechas($departamento);
    }


    public function showDisponibilidad(){


      $dpto = isset($_POST['id_dpto']) ? $_POST['id_dpto']: "";
      $anio = isset($_POST['anio']) ? $_POST['anio']: "";
      $mes = isset($_POST['mes']) ? $_POST['mes']: "";



      //A PARTIR DE ACA ES CODIGO COPIADO DE NICO Y AGUSTIN //


      // $dpto = filter_input(INPUT_POST, 'departamento');
      // $anio = filter_input(INPUT_POST, 'anio');
      // $mes = filter_input(INPUT_POST, 'mes');

      // $fecha_aux = (int)$anio. '-' .$mes;
      //
      // $days_in_month = cal_days_in_month(CAL_GREGORIAN,(int)$mes,(int)$anio);
      //
      // $desde = $anio . '-' . $mes . '-01';
      //
      // $mesSig = ((int)$mes) + 1;
      // if($mesSig == 13){
      //   $mesSig = 1;
      //   $anio = ((int)$anio) + 1;
      // }
      //
      // $hasta = $anio . '-' . $mesSig . '-01';
      //
      // $values = array($dpto, $desde, $hasta, $desde, $hasta);
      //
      //
      // $datos = $this->model->getEstadoDpto($values);
      // $this->organizarDatos($datos, $mes, $days_in_month, $fecha_aux);
    }

    // private function organizarDatos($datos, $mes, $diasMes, $fecha_aux){
    //   $disponibilidad_mes = array();
    //   for($i = 1; $i <= $diasMes; $i++){
    //     $disponibilidad_mes[$i] = 0;
    //   }
    //   if(!empty($datos)){
    //     foreach ($datos as $valor) {
    //       //[0] = año, [1] = mes, [2] = dia
    //       $fecha_desde = explode("-", $valor['fecha_desde']);
    //       $fecha_hasta = explode("-", $valor['fecha_hasta']);
    //       //desde es menor al mes y hasta es mayor - todo el mes ocupado
    //       if((int)$fecha_desde[1] < $mes && (int)$fecha_hasta[1] > $mes){
    //         $dia = 1;
    //         while($dia <= $diasMes){
    //           $disponibilidad_mes[$dia] = 1;
    //           $dia++;
    //         }
    //       //desde y hasta estan en el mes
    //       }else if((int)$fecha_desde[1] == $mes && (int)$fecha_hasta[1] == $mes){
    //         $dia = (int)$fecha_desde[2];
    //         while($dia<= (int)$fecha_hasta[2]){
    //           $disponibilidad_mes[$dia] = 1;
    //           $dia++;
    //         }
    //         //desde esta en el mes pero hasta es uno posterior
    //       }else if((int)$fecha_desde[1] == $mes && (int)$fecha_hasta[1] > $mes){
    //         $dia = (int)$fecha_desde[2];
    //         while($dia<= $diasMes){
    //           $disponibilidad_mes[$dia] = 1;
    //           $dia++;
    //         }
    //         //desde es anterior y hasta es dentro del mes
    //       }else if((int)$fecha_desde[1] < $mes && (int)$fecha_hasta[1] == $mes){
    //         $dia = 1;
    //         while($dia<= (int)$fecha_hasta[2]){
    //           $disponibilidad_mes[$dia] = 1;
    //           $dia++;
    //         }
    //       }
    //     }
    //   }
    //   $mes_start = $fecha_aux . '-' .'01';
    //   $mes_end = $fecha_aux . '-' . $diasMes;
    //   $result = array($fecha_aux, $disponibilidad_mes,$mes_start, $mes_end);
    //   return json_encode($result);
    // }


  }
?>
