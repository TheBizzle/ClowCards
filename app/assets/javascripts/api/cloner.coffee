# (Object[T]) => Object[T]
define(['api/jquery'], ($) ->
  (o) -> $.extend(true, {}, o)
)
