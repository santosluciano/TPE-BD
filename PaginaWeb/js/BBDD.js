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
      	}

        function mostrarDatos(data){
          $("#calendar").html(data);
        }

    }
});
