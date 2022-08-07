// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.
import $ from 'jquery';
// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

$(document).ready(function(){
    $('.movie-box img').hover(function() {
        $(this).addClass('transition');

    }, function() {
        $(this).removeClass('transition');
    });
});

$(document).on('click', '#icon_right, #icon_left', function() {
  console.log("it should be working")
    if($(this).attr('id') == 'icon_right') {
        $('body').animate({scrollLeft: 1000}, 800);
        } else {
        $('body').animate({scrollLeft: -1000}, 800);
    }
});
