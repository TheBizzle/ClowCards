f =
  ->

    $ = dependOn("api_jquery")

    # (Object[T]) => Object[T]
    (o) -> $.extend(true, {}, o)

declareModule("api_cloner", f)
