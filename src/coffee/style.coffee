#要素に背景を指定
$('[data-background]').each () ->
  $(@).css
    backgroundImage:'url(' + $(@).attr('data-background') + ')'
    
#カーソル移動
nextpage = () ->
  st = $('html, body').scrollTop()
  if p = (() ->
    for elm in $('body > section')
      if $(elm).offset().top - 1 > st
        return $(elm).offset().top
    0
  )()
    $('html, body').animate({ scrollTop: p }, 500) 
    false
prevpage = () ->
  st = $('html, body').scrollTop()
  if p = (() ->
    $elm = null
    for elm in $('body > section')
      if $(elm).offset().top + 1 > st
        return if $elm? then $elm.offset().top else 0
      $elm = $(elm)
    0
  )()
    $('html, body').animate({ scrollTop: p }, 500) 
    false
$(document).keydown (e) ->
  switch e.which
    when 40 then nextpage()
    when 38 then prevpage()