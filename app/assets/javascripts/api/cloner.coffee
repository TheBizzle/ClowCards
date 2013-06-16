require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(['r/api/jquery'], ($) ->
  (o) -> $.extend(true, {}, o)
)
