require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

# Assume that `this` is an `Array[T]`
# Kind of gross to depend on Underscore...
define(['r/lib/enhance/underscore'], (_) ->

  # (T) => Array[T]
  Array::append = (x) ->
    xss = this.slice(0)
    xss.push(x)
    xss

  # () => Array[T]
  Array::distinct = ->
    _(this).foldl(
      (acc, x) ->
        if _(acc).any((y) -> y is x) # This the efficiency of this is piss-poor; I wish I had a decent way to make maps in JavaScript...
          acc
        else
          acc.append(x)
    , [])

)

