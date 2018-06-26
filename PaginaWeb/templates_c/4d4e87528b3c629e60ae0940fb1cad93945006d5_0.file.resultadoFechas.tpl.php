<?php
/* Smarty version 3.1.30, created on 2018-06-26 03:48:16
  from "C:\xampp\htdocs\proyectos\bbddtpe\templates\resultadoFechas.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.30',
  'unifunc' => 'content_5b319b60163fd5_79920188',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '4d4e87528b3c629e60ae0940fb1cad93945006d5' => 
    array (
      0 => 'C:\\xampp\\htdocs\\proyectos\\bbddtpe\\templates\\resultadoFechas.tpl',
      1 => 1529977492,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_5b319b60163fd5_79920188 (Smarty_Internal_Template $_smarty_tpl) {
?>
<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th>Dia</th>
            <th>Estado</th>
        </tr>
    </thead>
    <tbody>
      <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['estadoFechas']->value, 'estado');
if ($_from !== null) {
foreach ($_from as $_smarty_tpl->tpl_vars['estado']->value) {
?>
        <tr>
          <td><?php echo $_smarty_tpl->tpl_vars['estado']->value['dia'];?>
</td>
          <td><?php echo $_smarty_tpl->tpl_vars['estado']->value['estado'];?>
</td>
        </tr>
      <?php
}
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl);
?>

    </tbody>
</table>
<?php }
}
