<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th>Dia</th>
            <th>Estado</th>
        </tr>
    </thead>
    <tbody>
      {foreach $estadoFechas as $estado}
        <tr>
          <td>{$estado['dia']}</td>
          <td>{$estado['estado']}</td>
        </tr>
      {/foreach}
    </tbody>
</table>
