require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(['r/lib/enhance/jquery'], ($) ->
  (o) -> $.extend(true, {}, o)
)
