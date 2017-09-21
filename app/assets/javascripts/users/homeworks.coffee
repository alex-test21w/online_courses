$(document).ready ->
  $('#lesson-homewroks-index #state').change ->
    states = ['approved', 'rejected']
    homework_state = $(this).val()
    url = $(this).parents('tr').find('#show-homework').attr('href')

    course_id = $('#lesson-homewroks-index #course_homework').val()
    lesson_id = $('#lesson-homewroks-index #lesson_homework').val()
    homework_id = url.substring(url.lastIndexOf('/') + 1)

    $.ajax
      type: 'PUT',
      url: "/users/courses/#{course_id}/lessons/#{lesson_id}/homeworks/#{homework_id}",
      data: { state: homework_state }
