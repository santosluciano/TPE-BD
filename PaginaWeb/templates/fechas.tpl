<div class="contenedor">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6 tituloDepartamentos">
						<h2> <b>Departamento - {$departamento['id_dpto']}</b></h2>
					</div>
          <div class="col-sm-6">
            <a href="departamentos" class="listaDptos btn btn-info"><span class="glyphicon glyphicon-arrow-left"></span><span> &nbsp; Lista Departamentos</span></a>
          </div>

                </div>
            </div>

            <div class="row">
      <div class="col-md-6">
        <div class="input-group">
          <span class="input-group-btn">
            <button id="{$departamento['id_dpto']}" class="buscar btn btn-default" type="button">Buscar!</button>
          </span>
          <select id="month" class="form-control" name="mes">
            <option value="0">Enero</option>
            <option value="1">Febrero</option>
            <option value="2">Marzo</option>
            <option value="3">Abril</option>
            <option value="4">Mayo</option>
            <option value="5">Junio</option>
            <option value="6">Julio</option>
            <option value="7">Agosto</option>
            <option value="8">Septiembre</option>
            <option value="9">Octubre</option>
            <option value="10">Noviembre</option>
            <option value="11">Diciembre</option>
          </select>
          <input id="year" type="number" min="4" max="4" class="form-control" value="2018" placeholder="Año..">

        </div><!-- /input-group -->
      </div><!-- /.col-lg-6 -->
    </div><!-- /.row -->
    <div class="row">
      <div class="col-md-8">
        <div id="calendar">

        </div>
    </div><!-- /.row -->


        </div>
    </div>
