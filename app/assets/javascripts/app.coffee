$('#form').on 'click', '#validate', (event) ->
  $('#forms_script_action').val(@id)

$('#form').on 'click', '#compress', (event) ->
  $('#forms_script_action').val(@id)

$('#form').on 'click', '#url', (event) ->
  $('#forms_script_action').val(@id)

$('#form').on 'change', '#forms_script_name', (event) ->
  $('.results').addClass('hide')
  $('#result tbody').html('')

$('#form').on 'ajax:success', '#url_form', (event, data, status, xhr) ->
  return if data.error
  if $('#forms_script_action').val() == 'compress'
    blob = new Blob [data.response], {type: 'application/x-ns-proxy-autoconfig; charset=utf-8'}
    saveAs(blob, 'compressed_proxy.pac')
  else
    if $('#forms_script_action').val() == 'url'
      $('#result').append("<tr><td>#{entry.url}</td><td>#{entry.result}</td></tr>") for entry in data.response
    $('.results').removeClass('hide')
    $('#form').foundation()
  $('#form .alert').hide()

$('#form').on 'click', '#reset', (event) ->
  event.preventDefault()
  $('.results').addClass('hide')
  $('#result tbody').html('')

$('#form').on 'click', '#clear', (event) ->
  event.preventDefault()
  $('#forms_script_url').val('')
