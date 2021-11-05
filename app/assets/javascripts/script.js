/*global $*/
$(function() {
  $('#btn_show').click(function(){
    $('#btn_hide').show();
    $('a#btn_hide').css('width','fit-content')
  });
  $('#btn_hide').click(function(){
    $('#btn_hide').hide();
  });
  $('.inner').hide();
  $('#accordion p').click(function(){
    $(this).next().slideToggle();
    $('#accordion p').not($(this)).next().slideUp();
  });
});