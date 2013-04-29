# Assume that `this` is a `Function[T, U]`

# (Function[U, V]) => Function[T, V]
Function::andThen = (g) ->
  f = this
  (x) => g(f.apply(this, arguments))
