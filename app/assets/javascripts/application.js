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
//= require handlebars-v3.0.0
//= require jquery.jeditable.mini
//= require underscore-min
//= require jquery.hotkeys-0.7.9.min
//= require jquery.elastic.source.js
//= require_tree .

$(document).ready(function() {

    $('#overlay').hide();
    $('#user-edit-form').hide();
    $('.best_in_place').best_in_place();
    $('#clock').jsclock(); //http://www.tcpweb.com.br/JS-Clock/

    // for closing forms with esc key
    $(document).keyup(function(e) {
        if(e.which == 27) {
            removeDarkBlurOverlay();
        }
    });


    Handlebars.registerHelper('if_eq', function(a, b, opts) {
        if(a == b) // Or === depending on your needs
            return opts.fn(this);
        else
            return opts.inverse(this);
    });


});

