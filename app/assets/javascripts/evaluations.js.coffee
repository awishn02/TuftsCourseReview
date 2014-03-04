# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $ ->
#   $("#evaluations th a, #evaluations .pagination a").on 'click', ->
#     $.getScript(this.href);
#     return false;
# 
#   $("#evaluations_search").submit ->
#     $.get(this.action, $(this).serialize(), null, 'script');
#     return false;

$ ->
  $("body").on 'click', '#evaluations .head_row a, #evaluations .pagination a', ->
    $.getScript(this.href);
    return false;

  $("#evaluations_search input").keyup ->
    $("#search_box, #title").removeClass("center");
    $("#search_nav").addClass('show');
    if($(this).val().length > 1 || $(this).val() == "")
      $.get($("#evaluations_search").attr('action'), $('#evaluations_search').serialize(), null, 'script');
      return false;

  $("#evaluations_search").submit ->
    return false

  $("body").on 'click', '.div_table .course_eval_row', ->
    # $("div.professor_rows").slideUp();
    $(this).parent().find('div.professor_rows').slideToggle();


