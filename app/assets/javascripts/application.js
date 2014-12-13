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
//= require turbolinks
//= require bootstrap

//= require moment
//= require bootstrap-datetimepicker
//= require pickers

//= require_tree .

//$(document).ready(function() {
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

    //////////countdown end //////////////

//    $('#local').text(localTime);
//    var finished = new Date(localTime.getTime() + (durMinutes*1000*60));
//    var completedHours = finished.getHours();
//    var completedMinutes = finished.getMinutes();
//    if (completedMinutes < 10) { completedMinutes = '0'+completedMinutes}
//    var completedSeconds = finished.getSeconds();
//    if (completedSeconds < 10) { completedSeconds = '0'+completedSeconds}
//
//    $('.complete .hours').text(completedHours);
//    $('.complete .minutes').text(completedMinutes);
//    $('.complete .secs').text(completedSeconds);
//});

////////////////// queue flyout //////////////////

//$("#show-queue").mouseenter(function(){
//    console.log('mouseenter');
//    $(this).closest('div').siblings($('section')).fadeTo(500,1);
//});
//
//$("#show-queue").mouseleave(function(){
//    console.log('mouseleave');
//    $(this).closest('div').siblings($('section')).fadeTo(500,0);
//});
