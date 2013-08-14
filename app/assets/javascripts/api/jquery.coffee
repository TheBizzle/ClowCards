define(['webjars!jquery-ui.js'], ([]) ->

  _$ = $

  # (String) => jQuery
  $.byID = (id) -> _$('#' + id)

  # Selector enhancements
  $.fn.extend({

    # ((Unit) => Unit) => Unit
    unfocus: (f) -> this.blur.apply(this, arguments)

    # (Unit) => String
    outerHTML: ->  _$(this).clone().wrap('<div></div>').parent().html()

  })

  $.noConflict()

)

