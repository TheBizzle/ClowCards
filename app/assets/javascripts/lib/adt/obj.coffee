# This class represents a wrapper around `Object`s, with some methods for doing things non-stupidly
# The type of the wrapped `Object` will be taken to be `Object[T, U]`

class Obj

  obj = undefined

  constructor: (object) ->
    obj = object

  # () => Object[T, U]
  value: ->
    obj

  # (T) => U
  get: (x) ->
    obj[x]

  # (T, U) => Obj[Object[T, U]]
  append: (x, y) ->
    withNew((out) -> out[x] = y)

  # (T) => Obj[Object[T, U]]
  without: (x) ->
    withNew((out) -> delete out[x])

  # (Int) => T
  fetchKeyByIndex: (n) ->
    Object.keys(obj)[n]

  # (Int) => U
  fetchValueByIndex: (n) ->
    key = @fetchKeyByIndex()
    obj[key]

  # () => Int
  size: ->
    _(obj).size()

    # ((V) => X) => Obj[Object[T, U]]
  withNew = (f) ->
    out = $.extend(true, {}, obj)
    f(out)
    new Obj(out)

exports.Obj = Obj
