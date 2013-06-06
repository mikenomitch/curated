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
//= require backbone.localStorage
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
   $.ajax({
      type: "GET",
      url: "/devise/registrations/new",
      data: {},
        success: function(data) {
          $("#middle_span").html(data);
        }
    }); 
  }
 
  }

function directToUser(){
  if( $("#user_search").val() == "Search for a Mathematical Concept"){
    fauxAlert("Select a Reviewer.");
  }
  else{
    window.location.href="/"+$("#user_search").val();
  }
}