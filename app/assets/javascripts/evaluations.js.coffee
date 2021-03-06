# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $ ->
#   $("#evaluations th a, #evaluations .pagination a").on 'click', ->
#     $.getScript(this.href)
#     return false
# 
#   $("#evaluations_search").submit ->
#     $.get(this.action, $(this).serialize(), null, 'script')
#     return false

$ ->
  $(".spinner").hide()

  $("body").on 'click', '#evaluations .head_row a, #evaluations .pagination a', ->
    $.getScript(this.href)
    return false

  typingTimer = 0
  doneTypingInterval = 500
  prevSearch = ""

  $("#evaluations_search input").keyup ->
    clearTimeout typingTimer
    typingTimer = setTimeout doneTyping, doneTypingInterval

  $("#evaluations_search input").keydown ->
    clearTimeout typingTimer

  doneTyping = ->
    $("#search_box, #title").removeClass("center")
    $("#search_nav").addClass('show')
    $(".alert").addClass('hide')
    if($("#search_box").val() != prevSearch)
      prevSearch = $("#search_box").val()
      $("#evaluations").fadeToggle("fast", ->
        $(".spinner").show()
      )
      $.get($("#evaluations_search").attr('action'), $('#evaluations_search').serialize(), ->
        $("#evaluations").fadeToggle("fast",->
          $(".spinner").hide()
        )
      , 'script')
      return false

  $("body").on 'click', '.button-group-item', ->
    # $("#search_box").val('')
    search_text = $("#search_box").val()
    $(".button-group-item").toggleClass('active')
    console.log this.href
    $.getScript(this.href+"&search="+search_text)
    return false

  $("#evaluations_search").submit ->
    return false

  $("body").on 'click', '.div_table .course_eval_row', ->
    id = $(this).data('id')
    console.log this.href
    main_column = $(".button-group-item.active").text()
    subtable_div = $(this).parent().find('div.professor_rows');
    url = document.URL+'/ajax?id='+id+'&main_column='+main_column
    if !$.trim(subtable_div.html()).length
      $.getScript(url, ->
        subtable_div.slideToggle()
      )
    else
      subtable_div.slideToggle()

  sortByTerm = (a,b) ->
    yearA = a[0].split(" ")[1]
    yearB = b[0].split(" ")[1]
    if yearA < yearB
      return -1
    if yearA > yearB
      return 1
    termA = a[0].split(" ")[0]
    termB = b[0].split(" ")[0]
    if termA == termB
      return 0
    if termA == "Fall"
      return 1
    return -1

  $("body").on 'click', '.professor_row_link', ->
    chart_id = $(this).data('chart-id')
    chart_data = $(this).data('chart-data')
    legend_id = $(this).data('legend-id')
    chart_data.sort(sortByTerm)
    ctx = $(chart_id).get(0).getContext("2d")
    labels = []
    course_scores = []
    teacher_scores = []
    $.each chart_data, (index, value)->
      labels.push(value[0])
      course_scores.push(parseFloat(value[1]))
      teacher_scores.push(parseFloat(value[2]))

    data = {
      labels : labels,
      datasets : [
              {
                fillColor : "rgba(143,119,69,0.5)",
                strokeColor : "rgba(143,119,69,1)",
                pointColor : "rgba(143,119,69,1)",
                pointStrokeColor : "#fff",
                data : course_scores,
                title: 'Course Score'
              },
              {
                fillColor : "rgba(151,187,205,0.5)",
                strokeColor : "rgba(151,187,205,1)",
                pointColor : "rgba(151,187,205,1)",
                pointStrokeColor : "#fff",
                data : teacher_scores,
                title: 'Teacher Score'
              }
        ]
    }
    chart = new Chart(ctx).Line(data,{graphMin: 1, graphMax: 5})
    $("#"+legend_id).empty()
    legend(document.getElementById(legend_id),data)


