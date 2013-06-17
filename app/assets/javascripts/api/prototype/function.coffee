require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

# Assume that `this` is a `Function[T, U]`
# Needs to use `define` (instead of `require`) here for some reason...? --Jason 6/17/13
define(->

  # (Function[U, V]) => Function[T, V]
  Function::andThen = (g) ->
    f = this
    (x) => g(f.apply(this, arguments))

)
