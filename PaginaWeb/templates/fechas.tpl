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
          <div class="col-md-12">
            <div class="input-group">
              <span class="input-group-btn">
                <button id="{$departamento['id_dpto']}" class="buscar btn btn-default" type="button">Buscar!</button>
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
