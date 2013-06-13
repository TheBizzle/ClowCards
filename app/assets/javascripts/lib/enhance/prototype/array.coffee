require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

# Assume that `this` is an `Array[T]`
define(->

  # (T) => Array[T]
  Array::append = (x) ->
    xss = this.slice(0)
    xss.push(x)
    xss

)

