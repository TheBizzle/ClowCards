f =
  ->

    _$ = jQuery

    # (String) => jQuery
    jQuery.byID = (id) -> _$('#' + id)

    # Selector enhancements
    jQuery.fn.extend({

      # ((Unit) => Unit) => Unit
      unfocus: (f) -> this.blur.apply(this, arguments)

      # (Unit) => String
      outerHTML: ->  _$(this).clone().wrap('<div></div>').parent().html()

    })

    jQuery.noConflict()

declareModule("api_jquery", f)
