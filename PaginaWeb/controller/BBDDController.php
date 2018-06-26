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
      $dpto = isset($_POST['id_dpto']) ? $_POST['id_dpto']: 0;
      $anio = isset($_POST['anio']) ? $_POST['anio']: 0;
      $mes = isset($_POST['mes']) ? $_POST['mes']: 0;
      $cantidadDias = cal_days_in_month(CAL_GREGORIAN, (int)$mes, (int)$anio);
      $estadoFechas = array();

      for ($i = 0; $i <$cantidadDias; $i++) {
        $fecha = $anio . '-' . $mes. '-'.($i+1);
        $estado = $this->model->getEstado($fecha, $dpto);
        $estadoFechas[$i] = array('estado'=>$estado['estado'], 'dia'=>($i+1));
      }
      $this->view->showResultado($estadoFechas);
    }
  }
?>
