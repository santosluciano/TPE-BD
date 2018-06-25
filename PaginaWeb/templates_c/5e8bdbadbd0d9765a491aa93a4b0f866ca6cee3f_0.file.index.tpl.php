<?php
/* Smarty version 3.1.30, created on 2018-06-25 23:03:22
  from "C:\xampp\htdocs\proyectos\bbddtpe\templates\index.tpl" */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '3.1.30',
  'unifunc' => 'content_5b31589a321bc9_73717868',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '5e8bdbadbd0d9765a491aa93a4b0f866ca6cee3f' => 
    array (
      0 => 'C:\\xampp\\htdocs\\proyectos\\bbddtpe\\templates\\index.tpl',
      1 => 1529960595,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
    'file:header.tpl' => 1,
    'file:footer.tpl' => 1,
  ),
),false)) {
function content_5b31589a321bc9_73717868 (Smarty_Internal_Template $_smarty_tpl) {
$_smarty_tpl->_subTemplateRender("file:header.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>


<div class="container">
    <div class="row profile">
		<div class="col-md-3">
			<div class="profile-sidebar">
				<!-- SIDEBAR USERPIC -->
				<div class="profile-userpic">
				</div>
				<!-- END SIDEBAR USERPIC -->
				<!-- SIDEBAR USER TITLE -->
				<div class="profile-usertitle">
					<div class="profile-usertitle-name">
						Trabajo Practico Especial
					</div>
					<div class="profile-usertitle-job">
						Basse de Datos
					</div>
				</div>
				<!-- END SIDEBAR USER TITLE -->

				<!-- SIDEBAR MENU -->
				<div class="profile-usermenu">
					<ul class="nav">
						<li class="active">
							<a class="dashboard listaDptos" href="departamentos">
							<span class="glyphicon glyphicon-home"></span>
							DEPARTAMENTOS </a>
						</li>


					</ul>
				</div>
				<!-- END MENU -->
			</div>
		</div>
		<div class="col-md-9">
      <div class="profile-content">

      </div>
		</div>
	</div>
</div>


<?php $_smarty_tpl->_subTemplateRender("file:footer.tpl", $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, $_smarty_tpl->cache_lifetime, array(), 0, false);
?>

<?php }
}
