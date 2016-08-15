(function($) {
  $(document).ready(function(){
    // Header search
    $('#header_search select#id').selectBox();

    // Login form
    $(".options .login").click(function(){
      $("#members_login .login_fields").toggle();
      return false;
    });

    $('ul.select_menu li a.toggle').click(function() {
      $(this).parent().toggleClass('closed').toggleClass('open');
      return false;
    });

    // Front page slideshow
    if ($('#slides')) {
      $('#slides').slidesjs({
        width: 940,
        height: 450,
        play: {
          //active: true,
          auto: true,
          interval: 7000,
          swap: true
        }
      });
    }
  });
})(jQuery.noConflict());
