hidden_exports.api_cloner = null

exports.api_cloner =
  (->
    if hidden_exports.api_cloner isnt null
      hidden_exports.api_cloner
    else
      hidden_exports.api_cloner =
        (->

          $ = exports.api_jquery()

          # (Object[T]) => Object[T]
          (o) -> $.extend(true, {}, o)

        )()
      hidden_exports.api_cloner
  )
