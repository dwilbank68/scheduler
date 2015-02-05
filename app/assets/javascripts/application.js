// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap

//= require moment
//= require best_in_place
//= require jquery_ujs

// for the clock in the nav bar - http://www.tcpweb.com.br/JS-Clock/
//= require jsclock-0.8.min

// for the countdown in all the units - http://keith-wood.name/countdown.html
//= require jquery.plugin.min.js
//= require jquery.countdown.min

// for the country flag input in the user update form
//= require data
//= require intlTelInput

//= require jquery.transit.min
//= require_tree .

$(document).ready(function() {

    $('#overlay').hide();
    $('#user-edit-form').hide();
    $('.best_in_place').best_in_place();

    // for closing forms with esc key
    $(document).keyup(function(e) {
        if(e.which == 27) {
            $('#blur-layer').removeClass('blur-in');
            $('#blur-layer').addClass('blur-out');
            $('#overlay').fadeOut();
            $('.unit_user_form').fadeOut();
            $('#user-edit-form').fadeOut();
        }
    });


});

