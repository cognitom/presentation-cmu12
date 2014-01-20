#要素に背景を指定
$('[data-background]').each () ->
  $(@).css
    backgroundImage:'url(' + $(@).attr('data-background') + ')'
    
#カーソル移動
sleeping = false 
nextpage = () ->
  unless sleeping
    st = $('html, body').scrollTop()
    scroll p if p = (() ->
      for elm in $('body > section')
        if $(elm).offset().top - 1 > st
          return $(elm).offset().top
      0
    )()
  false
    
prevpage = () ->
  unless sleeping
    st = $('html, body').scrollTop()
    scroll p if p = (() ->
      $elm = null
      for elm in $('body > section')
        if $(elm).offset().top + 1 > st
          return if $elm? then $elm.offset().top else 0
        $elm = $(elm)
      0
    )()
  false
   
scroll = (p) ->
  sleeping = true
  $('html, body').animate
    scrollTop: p
    500
    'swing'
    ()->sleeping = false
    
$(document).keydown (e) ->
  switch e.which
    when 40 then nextpage()
    when 38 then prevpage()