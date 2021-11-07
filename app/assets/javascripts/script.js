/*global $*/
$(function() {
  $('.inner').hide();
  $('#accordion p').click(function(){
    $(this).next().slideToggle();
    $('#accordion p').not($(this)).next().slideUp();
  });
  $('.child-inner').hide();
  $('#content1 p').click(function(){
    $(this).next().slideToggle();
    $('#content1 p').not($(this)).next().slideUp();
  });
});