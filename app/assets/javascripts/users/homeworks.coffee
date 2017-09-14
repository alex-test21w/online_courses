$(document).ready ->
  $('#lesson-homewroks-index #state').change ->
    states = ['approved', 'rejected']
    homework_state = $(this).val()
    url = $(this).parents('tr').find('#show-homework').attr('href')

    $.ajax
      type: 'PUT',
      url: url,
      data: { state: homework_state }
