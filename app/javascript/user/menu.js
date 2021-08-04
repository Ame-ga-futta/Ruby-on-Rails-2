$(document).on('turbolinks:load', function(){
  $(".header-profile-image").click(function(){
    $(".header-menu").fadeToggle();
  });
});
