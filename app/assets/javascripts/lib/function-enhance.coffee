Function::andThen = (g) ->
  f = this
  (x) => g(f.apply(this, arguments))
