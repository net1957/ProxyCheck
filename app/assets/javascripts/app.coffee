$('#form').on 'click', '#validate', (event) ->
  $('#forms_script_action').val(@id)

$('#form').on 'click', '#compress', (event) ->
  $('#forms_script_action').val(@id)

$('#form').on 'ajax:success', '#top-form', (event, data, status, xhr) ->
  if $('#forms_script_action').val() == 'compress'
    blob = new Blob [data.parse], {type: 'application/x-ns-proxy-autoconfig; charset=utf-8'}
    saveAs(blob, 'compressed_proxy.pac')
  else
    $('#form').foundation()

$('#form').on 'ajax:success', '#url-form', (event, data, status, xhr) ->
  $('#result').append("<tr><td>#{entry.url}</td><td>#{entry.result}</td></tr>") for entry in data
  $('#form').foundation()

$('#form').on 'click', '#reset', (event) ->
  event.preventDefault()
  $('#result tbody').html('')
