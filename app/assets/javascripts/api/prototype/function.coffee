require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

# Assume that `this` is a `Function[T, U]`
require(->

  # (Function[U, V]) => Function[T, V]
  Function::andThen = (g) ->
    f = this
    (x) => g(f.apply(this, arguments))

)
