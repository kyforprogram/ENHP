/*global $*/
$(function() {
  $('.inner').hide();
  $('#accordion p').click(function(){
    $(this).next().slideToggle();
    $('#accordion p').not($(this)).next().slideUp();
  });
});