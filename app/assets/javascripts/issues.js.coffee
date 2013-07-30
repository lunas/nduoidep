# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
  $("#issue_id").change (event)->
    issue_id = $("#issue_id option:selected").val()
    document.location = "/issues/" + issue_id

  $("#page_nr").change (event)->
    page_nr = $("#page_nr option:selected").val()
    $("#magazine").turn("page", page_nr)
    false

  $(".turn_page_left").click (e) ->
    $("#magazine").turn "previous"
    console.log('.turn_page_left clicked')
    false

  $(".turn_page_right").click (e) ->
    $("#magazine").turn "next"
    false