// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require backbone
//= require backbone-relational
//= require backbone_rails_sync
//= require backbone_datalink
//= require backbone/curate
//= require chosen-jquery
//= require select2
//= require soundcloud_activator
//= require_tree .

function replaceMiddle(div_name){
  if (div_name == "sign_in"){
    $.ajax({
      type: "POST",
      url: "/users/sign_in",
      data: {},
        success: function(data) {
          $("#middle_span").html(data);
        }
    });
  }
  else{
    if (div_name == "sign_up"){
     $.ajax({
        type: "GET",
        url: "/devise/registrations/new",
        data: {},
          success: function(data) {
            $("#middle_span").html(data);
          }
      }); 
    }else{
      $.ajax({
        type: "GET",
        url: "/devise/registrations/edit",
        data: {},
          success: function(data) {
            $("#middle_span").html(data);
          }
      }); 
    }
  }
 
  }

function directToUser(search_name){
  if (search_name == "user_search"){
    value = $("#user_search").val()
  }
  else{
    value = $("#bottom_search").val()  
  }
  if( value == "Search for a User"){
    fauxAlert("Select a User.");
  }
  else{
    window.location.href="/"+value+"/albums";
  }
}


// -----------------------------------------------
// FLASH-MESSAGES --------------------------------
// -----------------------------------------------
function fauxAlert(message)
{
  $("#flash").html(message);
  $("#flash").show();
  document.getElementById("flash").style.backgroundColor='#222';
    
  timedHideFlashMessages();
}

function fauxRedAlert(message)
{
  $("#flash").html(message);
  $("#flash").show();
  document.getElementById("flash").style.backgroundColor='firebrick';
    
  timedHideFlashMessages();
}

function hideFlashMessages() {
  $("#flash").slideUp();
}
    
function timedHideFlashMessages()
{ 
  // FIX: Try creating two groups. This breaks.
  // Flash messages
  if ($("#flash").length > 0) {
    setTimeout(hideFlashMessages, 3000);
  }
}

$(document).ready(function() {
  timedHideFlashMessages();
});
// -----------------------------------------------
// END-FLASH-MESSAGES --------------------------------
// -----------------------------------------------


// If you want the play buttons to hide whenever you scroll
// $(document).scroll(function(){
//   $(".play_button").hide()
// });

// THE YOUTUBE LOADER

// var div_holder = {
//   name: null,
//   setname: function(div_name){
//     this.name = div_name
//   }
// }

// function playYouTube(div_name){
//   loadIFrameApi();
//   div_holder.setName(div_name);
// }

// function loadIFrameApi(){
//     var tag = document.createElement('script');
//     tag.src = "//www.youtube.com/iframe_api";
//     var firstScriptTag = document.getElementsByTagName('script')[0];
//     firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
//   }

// function onYouTubeIframeAPIReady() {
//   loadFrame();
// }

// function loadFrame(){
//     player = new YT.Player(div_holder.name, {
//       height: '281px',
//       width: '281px',
//       videoId: "PQRJvZBH1gw",
//       playerVars: {
//         autoplay: 1,
//         controls: 1,
//         autohide: 2,
//         modestbranding: 0,
//         rel: 0,
//         fs: 1,
//         showinfo: 0,
//         start: 0,
//         theme: "dark",
//         iv_load_policy: 3,
//         },
//       events: {
//         'onReady': onPlayerReady,
//       }
//     }
//   )
// }

// function onPlayerReady(event) {
//     event.target.playVideo();
// }