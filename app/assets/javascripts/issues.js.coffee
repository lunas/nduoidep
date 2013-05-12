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
    false

  $(".turn_page_right").click (e) ->
    $("#magazine").turn "next"
    false

#  $("#magazine").on "click", ".turn-page-wrapper", (e) ->
#    if window.corner_clicked
#      e.stopImmediatePropagation()
#      return
#    url = $(this).find(".turn-page").css("background-image")
#    src = url.replace("url(", "").replace(")", "")
#    zoom_on()
#    $("#zoomer img").attr "src", src
#    set_position_close_div()
#
#  set_position_close_div = ->
#    zoomer = $("#zoomer")
#    close_div = zoomer.find(".close")
#    top = zoomer.offset().top
#    left = zoomer.offset().left + zoomer.width() - close_div.width() - 20
#    close_div.css("top", top).css "left", left
#
#  zoom_on = ->
#    $('#magazine').hide()
#    $('#zoomer').show()
#  zoom_off = ->
#    $('#zoomer').hide()
#    window.corner_clicked = false;
#    $('#magazine').show()
#
#  $("#zoomer").on "click", ".close a", (e) ->
#    zoom_off()
#    false
#
#  $("#magazine").mouseover(->
#    return if window.corner_clicked
#    $("#magazine").addClass "zoom_in"
#  ).mouseout ->
#    $("#magazine").removeClass "zoom_in"
#    window.corner_clicked = false

