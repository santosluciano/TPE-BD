<?php
/* Smarty version 3.1.30, created on 2018-06-25 22:58:28
  from "C:\xampp\htdocs\proyectos\bbddtpe\templates\departamentos.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.30',
  'unifunc' => 'content_5b315774491a96_79466365',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '4e956f626362df0095a235219e27941112f32c21' => 
    array (
      0 => 'C:\\xampp\\htdocs\\proyectos\\bbddtpe\\templates\\departamentos.tpl',
      1 => 1529959881,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_5b315774491a96_79466365 (Smarty_Internal_Template $_smarty_tpl) {
?>


<div class="contenedor">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6 tituloDepartamentos">
						<h2> <b>Lista de Departamentos</b></h2>
					</div>

                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>

                    <tr>
						            <th>ID</th>
                        <th>Descripción</th>
                        <th>Superfice</th>
						            <th>Precio Noche</th>
                        <th>Precio Limpieza</th>
                        <th>Ciudad</th>

                    </tr>
                </thead>
                <tbody>

                  <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['departamentos']->value, 'departamento');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['departamento']->value) {
?>


						<tr>

							<td><?php echo $_smarty_tpl->tpl_vars['departamento']->value['id_dpto'];?>
</td>
							<td><?php echo $_smarty_tpl->tpl_vars['departamento']->value['descripcion'];?>
</td>
							<td><?php echo $_smarty_tpl->tpl_vars['departamento']->value['superficie'];?>
</td>
							<td><?php echo $_smarty_tpl->tpl_vars['departamento']->value['precio_noche'];?>
</td>
							<td><?php echo $_smarty_tpl->tpl_vars['departamento']->value['costo_limpieza'];?>
</td>
              <td><?php echo $_smarty_tpl->tpl_vars['departamento']->value['ciudad'];?>
</td>
              <td>
                <a href="<?php echo $_smarty_tpl->tpl_vars['departamento']->value['id_dpto'];?>
" class="verDepartamento"><i class="material-icons" title="Ver fechas">&#xe417;</i></a>
              </td>

						</tr>
            <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl);
?>


                </tbody>
            </table>

        </div>
    </div>
<?php }
}
