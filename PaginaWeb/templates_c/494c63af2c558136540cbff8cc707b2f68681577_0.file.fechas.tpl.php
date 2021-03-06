<?php
/* Smarty version 3.1.30, created on 2018-06-26 03:48:09
  from "C:\xampp\htdocs\proyectos\bbddtpe\templates\fechas.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.30',
  'unifunc' => 'content_5b319b59369fd7_43831504',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '494c63af2c558136540cbff8cc707b2f68681577' => 
    array (
      0 => 'C:\\xampp\\htdocs\\proyectos\\bbddtpe\\templates\\fechas.tpl',
      1 => 1529977682,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_5b319b59369fd7_43831504 (Smarty_Internal_Template $_smarty_tpl) {
?>
<div class="contenedor">
  <div class="table-wrapper">
      <div class="table-title">
          <div class="row">
            <div class="col-sm-6 tituloDepartamentos">
				        <h2> <b>Departamento - <?php echo $_smarty_tpl->tpl_vars['departamento']->value['id_dpto'];?>
</b></h2>
            </div>
            <div class="col-sm-6">
              <a href="departamentos" class="listaDptos btn btn-info"><span class="glyphicon glyphicon-arrow-left"></span><span> &nbsp; Lista Departamentos</span></a>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="input-group">
              <span class="input-group-btn">
                <button id="<?php echo $_smarty_tpl->tpl_vars['departamento']->value['id_dpto'];?>
" class="buscar btn btn-default" type="button">Buscar!</button>
              </span>
              <select id="month" class="form-control" name="mes">
                <option value="01">Enero</option>
                <option value="02">Febrero</option>
                <option value="03">Marzo</option>
                <option value="04">Abril</option>
                <option value="05">Mayo</option>
                <option value="06">Junio</option>
                <option value="07">Julio</option>
                <option value="08">Agosto</option>
                <option value="09">Septiembre</option>
                <option value="10">Octubre</option>
                <option value="11">Noviembre</option>
                <option value="12">Diciembre</option>
              </select>
              <input id="year" type="number" min="4" max="4" class="form-control" value="2018" placeholder="Año..">

            </div><!-- /input-group -->
          </div><!-- /.col-lg-6 -->
        </div><!-- /.row -->
        <div class="row">
          <div class="col-md-12">
            <div id="calendar">
            </div>
          </div>
        </div>
    </div>
  </div>
<?php }
}
