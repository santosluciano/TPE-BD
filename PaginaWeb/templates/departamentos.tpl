

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

                  {foreach $departamentos as $departamento}


						<tr>

							<td>{$departamento['id_dpto']}</td>
							<td>{$departamento['descripcion']}</td>
							<td>{$departamento['superficie']}</td>
							<td>{$departamento['precio_noche']}</td>
							<td>{$departamento['costo_limpieza']}</td>
              <td>{$departamento['ciudad']}</td>
              <td>
                <a href="{$departamento['id_dpto']}" class="verDepartamento"><i class="material-icons" title="Ver fechas">&#xe417;</i></a>
              </td>

						</tr>
            {/foreach}

                </tbody>
            </table>

        </div>
    </div>
