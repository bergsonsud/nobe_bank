$(document).ready(function() {
  $('.modal').modal();
});

$(function() {
  $('#btn').on('click', function() {
    $('#modal1').modal('close');
  });
});


$(function() {
  $('.modal-trigger').on('click', function() {
    $('#modal1').modal('open');
  });
});
