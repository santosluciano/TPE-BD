<?php
/* Smarty version 3.1.30, created on 2018-06-25 03:33:29
  from "C:\xampp\htdocs\proyectos\bbddtpe\templates\productos.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.30',
  'unifunc' => 'content_5b3046695e7414_23363953',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '887f4124c5f9ba008e8bcda6127e3da663c23011' => 
    array (
      0 => 'C:\\xampp\\htdocs\\proyectos\\bbddtpe\\templates\\productos.tpl',
      1 => 1529890405,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_5b3046695e7414_23363953 (Smarty_Internal_Template $_smarty_tpl) {
?>


<div class="contenedor">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
						<h2> <b>Lista de Productos</b></h2>
					</div>
					<div class="col-sm-6">
						<a href="" class="nuevoProducto btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>&nbsp;Agregar producto</span></a>
					</div>
                </div>
            </div>
            <table class="table table-striped table-hover">
                <thead>





                    <tr>
						<th>Codigo</th>
                        <th>Nombre</th>
                        <th>Precio</th>
						<th>Descripción</th>
                        <th>Categoría</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
						<tr>

							<td>Codigo</td>
							<td>nombre</td>
							<td>precio</td>
							<td>descripcion</td>
							<td>categoria</td>
							<td>
								<a href="editProduct" class="edit" value=""  data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
								<a href="#deleteProduct" class="delete" value="" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
							</td>
						</tr>

                </tbody>
            </table>
			<!-- <div class="clearfix">
        <?php if ($_smarty_tpl->tpl_vars['cantidadProductos']->value == 0) {?>
        <div class="hint-text">Mostrando <b><?php echo $_smarty_tpl->tpl_vars['productoInicial']->value;?>
 a <?php echo $_smarty_tpl->tpl_vars['productoFinal']->value;?>
</b> productos de <b><?php echo $_smarty_tpl->tpl_vars['cantidadProductos']->value;?>
</b> </div>
        <?php } else { ?>
        <div class="hint-text">Mostrando <b><?php echo $_smarty_tpl->tpl_vars['productoInicial']->value+1;?>
 a <?php echo $_smarty_tpl->tpl_vars['productoFinal']->value;?>
</b> productos de <b><?php echo $_smarty_tpl->tpl_vars['cantidadProductos']->value;?>
</b> </div>
        <?php }?>
                <ul class="pagination" value="<?php echo $_smarty_tpl->tpl_vars['cantidadPaginas']->value;?>
">

                  <?php if ($_smarty_tpl->tpl_vars['paginaActual']->value > 1) {?>
                    <li class="page-item"><a class='paginacion' href="productos/<?php echo $_smarty_tpl->tpl_vars['paginaActual']->value-1;?>
">Previous</a></li>
                  <?php } else { ?>
                    <li class="page-item disabled"><a class='paginacion' href="productos/<?php echo $_smarty_tpl->tpl_vars['paginaActual']->value;?>
">Previous</a></li>
                  <?php }?>

                      <?php
$_smarty_tpl->tpl_vars['var'] = new Smarty_Variable(null, $_smarty_tpl->isRenderingCache);$_smarty_tpl->tpl_vars['var']->step = 1;$_smarty_tpl->tpl_vars['var']->total = (int) ceil(($_smarty_tpl->tpl_vars['var']->step > 0 ? $_smarty_tpl->tpl_vars['cantidadPaginas']->value+1 - (1) : 1-($_smarty_tpl->tpl_vars['cantidadPaginas']->value)+1)/abs($_smarty_tpl->tpl_vars['var']->step));
if ($_smarty_tpl->tpl_vars['var']->total > 0) {
for ($_smarty_tpl->tpl_vars['var']->value = 1, $_smarty_tpl->tpl_vars['var']->iteration = 1;$_smarty_tpl->tpl_vars['var']->iteration <= $_smarty_tpl->tpl_vars['var']->total;$_smarty_tpl->tpl_vars['var']->value += $_smarty_tpl->tpl_vars['var']->step, $_smarty_tpl->tpl_vars['var']->iteration++) {
$_smarty_tpl->tpl_vars['var']->first = $_smarty_tpl->tpl_vars['var']->iteration == 1;$_smarty_tpl->tpl_vars['var']->last = $_smarty_tpl->tpl_vars['var']->iteration == $_smarty_tpl->tpl_vars['var']->total;?>
              					<?php if ($_smarty_tpl->tpl_vars['var']->value == $_smarty_tpl->tpl_vars['paginaActual']->value) {?>
                          <li class="page-item active" id="<?php echo $_smarty_tpl->tpl_vars['var']->value;?>
"><a class='paginacion' href="productos/<?php echo $_smarty_tpl->tpl_vars['var']->value;?>
" value="<?php echo $_smarty_tpl->tpl_vars['var']->value;?>
" class="page-link"><?php echo $_smarty_tpl->tpl_vars['var']->value;?>
</a></li>
              					<?php } else { ?>
              						<li class="page-item" id="<?php echo $_smarty_tpl->tpl_vars['var']->value;?>
"><a class='paginacion' href="productos/<?php echo $_smarty_tpl->tpl_vars['var']->value;?>
" value="<?php echo $_smarty_tpl->tpl_vars['var']->value;?>
" class="page-link"><?php echo $_smarty_tpl->tpl_vars['var']->value;?>
</a></li>
                         <?php }?>
                      <?php }
}
?>


                      <?php if ($_smarty_tpl->tpl_vars['paginaActual']->value < $_smarty_tpl->tpl_vars['cantidadPaginas']->value) {?>
                        <li class="page-item"><a class='paginacion' href="productos/<?php echo $_smarty_tpl->tpl_vars['paginaActual']->value+1;?>
">Next</a></li>
                      <?php } else { ?>
                        <li class="page-item disabled"><a class='paginacion' href="productos/<?php echo $_smarty_tpl->tpl_vars['paginaActual']->value;?>
">Next</a></li>
                      <?php }?>
                </ul>
            </div> -->
        </div>
    </div>











	<!-- Delete Product -->

	<div id="deleteProduct" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="eliminar" action="" method="get">
					<div class="modal-header">
						<h4 class="modal-title">Eliminar Producto</h4>
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
						<p>¿Seguro quieres borrar este producto?</p>
						<p class="text-warning"><small>Esta accion no se puede deshacer</small></p>
					</div>
					<div class="modal-footer">
						<input type="button" class="btn btn-default" data-dismiss="modal" value="Cancelar">
						<input type="submit" class="btn btn-danger " value="Eliminar" href="">
					</div>
				</form>
			</div>
		</div>
	</div>
<?php }
}
