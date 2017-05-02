clear_results = ->
  $('.results').addClass('hide')
  $('#result tbody').html('')

name_compress_visibility = ->
  if $('#forms_script_name').val().trim() == ''
    $('#compress').addClass('hide')
# TODO: need proxy_rb_pac >0.5.4 see commit d8e3d73
#  else
#    $('#compress').removeClass('hide')

url_clear_visibility = ->
  if $('#forms_script_url').val().trim() == ''
    $('#clear').addClass('hide')
  else
    $('#clear').removeClass('hide')

all_visibility = ->
 url_clear_visibility()
 name_compress_visibility()

# allow access from other scripts
window.all_visibility = -> all_visibility()

# at startup
$ ->
  all_visibility()

$('#form').on 'click', '#compress', (event) ->
  $('#forms_script_action').val(@id)

$('#form').on 'click', '#url', (event) ->
  $('#forms_script_action').val(@id)

$('#form').on 'change', '#forms_script_name', (event) ->
  clear_results()

$('#form').on 'change', '#forms_script_ip', (event) ->
  clear_results()

$('#form').on 'change', (event) ->
  all_visibility()

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
  url_clear_visibility()

$('#form').on 'click', '#reset', (event) ->
  event.preventDefault()
  clear_results()

$('#form').on 'click', '#clear', (event) ->
  event.preventDefault()
  $('#forms_script_url').val('')
  url_clear_visibility()
