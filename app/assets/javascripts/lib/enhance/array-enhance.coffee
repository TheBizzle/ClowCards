# Assume that `this` is an `Array[T]`

# (T) => Array[T]
Array::append = (x) ->
  xss = this.slice(0)
  xss.push(x)
  xss

