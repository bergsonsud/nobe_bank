// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require maskmoney
//= require materialize-sprockets
//= require turbolinks
//= require_tree .




$(function() {
  $('.value').maskMoney({
    allowNegative: false,
    decimal: ".",
    thousands: ""
  });
});

$(document).on('turbolinks:load', function() {
  $('.dropdown-trigger').dropdown({
    hover: true,
    coverTrigger: false
  });
});

$(document).ready(function() {
  $('.collapsible').collapsible();
});

$('#alert_close').click(function() {
  $("#alert_box").fadeOut("slow", function() {});
});
