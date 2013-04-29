# Function[U, V] => Function[T, V] (assuming that `this` is a Function[T, U])
Function::andThen = (g) ->
  f = this
  (x) => g(f.apply(this, arguments))
