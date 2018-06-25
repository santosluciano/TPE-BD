$(document).ready(function(){
    "use strict";
    callAjax("departamentos");
    let dirNueva;
    let id;

    function callAjax(dir) {
        $.ajax({
            "url" : dir,
            "method" : "GET",
            "data-type" : "HTML",
            "success" : mostrarContenido,
            "error": handleError
        });
    }


    function handleError(xmlhr, r, error) {
        console.log(error);
    }

    function mostrarContenido (data, textStatus, jqXHR) {

        $(".profile-content").html(data);

        $('.verDepartamento').on("click", function (event) {
          event.preventDefault();
          let url = 'fechas/'+$(this).attr('href');
          callAjax(url)
        })

        $('.listaDptos').on("click", function (event) {
          event.preventDefault();
          let url = $(this).attr('href');
          callAjax(url)
        })

        $('.buscar').on('click',function() {
          console.log('entra');
          let id_dpto = $(this).attr('id');
          mostrarDisponibilidad(id_dpto);
        });

        function mostrarDisponibilidad(id_dpto){
           let anio = $('#year').val();
           let mes = $('#month').val();
           let data = 'anio=' + anio + '&mes=' + mes + '&id_dpto=' + id_dpto;
           $.ajax({
               async : true,
               "type":"POST",
               "url": "disponibilidad",
               "data": data,
               "success": mostrarDatos,
               "error": handleError
           });

      		//ajaxMethods(data,'disponibilidad');
      	}

        function mostrarDatos(data){ //ESTO ME LO PASO NICO Y AGUSTIN
          console.log(data);

          let calendario = $('#calendar').fullYearCalendar({
            yearStart: new Date(data[2]),
            yearEnd: new Date(data[3])
          });
          let diasOcupados = [];
          for(let dia in data[1]){
            if(data[1][dia] == 1){
              let fecha = data[0]+'-'+dia;
              diasOcupados.push(fecha);
            }
          }
          for(let i = 0; i < diasOcupados.length; i++){
            calendario.addHoliday({
              type: 'publicHolidays',
              from: diasOcupados[i],
              to: diasOcupados[i]
            });
          }
        }





    }
});
