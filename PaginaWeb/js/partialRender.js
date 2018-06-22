$(document).ready(function () {
  //Llamada a ajax cuando se carga o recarga la pagina
  llamada_ajax("home");
  //Partial render comun de la pagina - nav
  $('body').on('click','.partial',function(event){
    event.preventDefault();
    let accion = this.href;
    $('.active').removeClass('active');
    if ($(this).attr('title') === "desplegable"){
      $('.dropdown-marcas').addClass('active');
    }else{
      $(this).parent().addClass('active');
    }
    llamada_ajax(accion);
  });
  //Llamada a ajax
  function llamada_ajax(accion){
    $.ajax({
      url:accion,
      success: function(result) {
        $(".cuerpo").html(result);
      },
      error: function(){
        $(".cuerpo").html("<h1>Error - Request Failed!</h1>");
      }
    });
    cargando();
  }
  //Muestra el gif de cargando en el cuerpo de la pagina
  function cargando() {
    let load = '<i class="fa fa-spinner fa-pulse fa-3x fa-fw carga"></i>';
    $(".cuerpo").html(load);
  }
  //Partial para elementos de la pagina
  $('body').on('click','.partialContain',function(event){
      event.preventDefault();
      let accion = this.href+'/'+$(this).data("value");
      llamada_ajax(accion);
  });
});
