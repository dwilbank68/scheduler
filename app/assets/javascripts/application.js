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

    //$('.duration-input:visible').on('input', function() {
    //    console.log('oowop');
    //});

    //var unitTemplate = $('#unit-template').innerHTML;
    //console.log("unitTemplate is " + unitTemplate);

    //var winWidth = $(window).width();
    //var winHeight = $(window).height();
    //var machine = $('.machine-container');
    //machine.draggable();
    //machine.offset({ top: 50, left: 100 })
//    var ntop = machine.offset().left / machine.width();
//    var nleft = machine.offset().top / machine.height();
//    var nleft = machine.offset().left / winWidth;
//    var ntop = machine.offset().top / winHeight;
//    console.log(winWidth);
//    console.log(winHeight);
//    console.log(nleft);
//    console.log(ntop);

//    var localTime = new Date();
//    var durMinutes = $('.countdown').attr('data-duration');
//    var durSeconds = durMinutes * 60;
//
//    ///////////// countdown ///////////////
//    var hours, minutes, seconds;
//    var countdownHr = $('.remaining .hours');
//    var countdownMin = $('.remaining .minutes');
//    var countdownSec = $('.remaining .secs');
//
//    var countdown = setInterval(function(){
//        hours = parseInt(durSeconds / 3600);
//        if (hours < 10) { hours = '0'+hours}
//        minutes = parseInt((durSeconds/60) - (hours * 60) );
//        if (minutes < 10) { minutes = '0'+minutes}
//        seconds = parseInt(durSeconds - (minutes * 60) - (hours * 3600));
//        if (seconds < 10) { seconds = '0'+seconds}
//        countdownHr.text(hours);
//        countdownMin.text(minutes);
//        countdownSec.text(seconds);
////        countdown+ ":" + minutes + ":" + seconds);
//        durSeconds -=1;
//        if (durSeconds <= 0) {
//            countdownHr.text("--");
//            countdownMin.text("--");
//            countdownSec.text("--");
//            clearInterval(countdown);
//            return;
//        }
//    },100 );


});

