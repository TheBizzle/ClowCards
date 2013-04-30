# This class represents a wrapper around `Object`s, with some methods for doing things non-stupidly
# The type of the wrapped `Object` will be taken to be `Object[T, U]`

class Obj

  constructor: (@_obj) ->

  # () => Object[T, U]
  value: ->
    @_obj

  # (T) => U
  get: (x) ->
    @_obj[x]

  # (T, U) => Obj[Object[T, U]]
  append: (x, y) ->
    @_withNew((out) -> out[x] = y)

  # (T) => Obj[Object[T, U]]
  without: (x) ->
    @_withNew((out) -> delete out[x])

  # (Int) => T
  fetchKeyByIndex: (n) ->
    Object.keys(@_obj)[n]

  # (Int) => U
  fetchValueByIndex: (n) ->
    key = @fetchKeyByIndex()
    @_obj[key]

  # () => Int
  size: ->
    _(@_obj).size()

    # ((V) => X) => Obj[Object[T, U]]
  _withNew: (f) ->
    out = $.extend(true, {}, @_obj)
    f(out)
    new Obj(out)

exports.Obj = Obj
