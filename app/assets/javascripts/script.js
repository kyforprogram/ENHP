/*global $*/
$(function() {
  $('.inner').hide();
  $('#accordion p').click(function(){
    $(this).next().slideToggle();
    $('#accordion p').not($(this)).next().slideUp();
  });
  var doc0= document.getElementById("hello_world");  
  doc0.innerHTML= "p Hello world テキストを表示します。"; 
});