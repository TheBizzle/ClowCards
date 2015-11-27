hidden_exports.api_jquery = null

exports.api_jquery =
  (->
    if hidden_exports.api_jquery isnt null
      hidden_exports.api_jquery
    else
      hidden_exports.api_jquery =
        (->

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

        )()
      hidden_exports.api_jquery
  )
