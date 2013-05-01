# This class represents a wrapper around `Object`s, with some methods for doing things non-stupidly
class Obj

  # The type of `@_obj` will be taken to be `Object[T, U]`
  constructor: (@_obj) ->

  # () => Object[T, U]
  value: =>
    @_obj

  # (T) => U
  get: (x) =>
    @_obj[x]

  # (T, U) => Obj[Object[T, U]]
  append: (x, y) =>
    @_withNew((out) => out[x] = y)

  # (T) => Obj[Object[T, U]]
  without: (x) =>
    @_withNew((out) => delete out[x])

  # ((T, U) => Boolean) => Obj[Object[T, U]]
  filter: (f) =>
    @_morph((out, k, v) => if not f(k, v) then delete out[k])

  # ((T, U) => Boolean) => Obj[Object[T, U]]
  filterNot: (f) =>
    @_morph((out, k, v) => if f(k, v) then delete out[k])

  # ((T) => Boolean) => Obj[Object[T, U]]
  filterKeys: (f) =>
    @_morph((out, k, v) => if not f(k) then delete out[k])

  # ((T, U) => [V, W]) => Obj[Object[V, W]]
  map: (f) =>
    @_comprehend(
      (out, k, v) =>
        [key, value, []] = f(k, v)
        delete out[k]
        out[key] = value
    )

  # ((T, U) => V) => Array[V]
  mapToArray: (f) =>
    clone = $.extend(true, {}, @_obj)
    for k, v of clone
      f(k, v)

  # (Int) => T
  fetchKeyByIndex: (n) =>
    Object.keys(@_obj)[n]

  # (Int) => U
  fetchValueByIndex: (n) =>
    key = @fetchKeyByIndex()
    @_obj[key]

  # () => Int
  size: =>
    _(@_obj).size()

  # ((Obj[Object[T, U]], T, U) => Obj[Object[V, W]]) => Obj[Object[V, W]]
  _comprehend: (f) =>
    @_withNew(
      (out) =>
        for k, v of out
          f(out, k, v)
    )

  # ((Obj[Object[T, U]], T, U) => Unit) => Obj[Object[V, W]]
  _morph: (f) =>
    @_withNew(
      (out) =>
        for k, v of out
          f(out, k, v)
        out
    )

    # ((V) => X) => Obj[Object[T, U]]
  _withNew: (f) =>
    out = $.extend(true, {}, @_obj)
    f(out)
    new Obj(out)

exports.Obj = Obj
