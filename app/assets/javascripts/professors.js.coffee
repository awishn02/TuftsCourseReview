# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $(".opt_out_link").click ->
    target_id = $(this).data 'target'
    target_opt_out = !$(this).data 'opt_out'
    $.ajax '/professors/'+target_id,
      type: 'PUT'
      contentType: 'application/json'
      dataType: 'json'
      data: JSON.stringify({professor:{opt_out:target_opt_out}})
      success: (data, status, xhr) ->
        window.location.reload()
      error: (xhr, status, error) ->
        console.log 'An error occurred: ' + error
    return false
