require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

# (Object[T]) => Object[T]
define(['r/api/jquery'], ($) ->
  (o) -> $.extend(true, {}, o)
)
