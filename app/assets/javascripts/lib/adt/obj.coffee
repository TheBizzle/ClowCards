# This class represents a wrapper around `Object`s, with some methods for doing things non-stupidly
class Obj

  # The type of `@_obj` will be taken to be `Object[T, U]`
  # Thus, this class will be referred to as `Obj[T, U]`
  constructor: (@_obj) ->

  # () => Object[T, U]
  value: =>
    @_obj

  # (T) => U
  get: (x) =>
    @_obj[x]

  # (T, U) => Obj[T, U]
  append: (x, y) =>
    @_withNew((out) => out[x] = y)

  # (T) => Obj[T, U]
  without: (x) =>
    @_withNew((out) => delete out[x])

  # ((T, U) => Boolean) => Obj[T, U]
  filter: (f) =>
    @_morph((out, k, v) => if not f(k, v) then delete out[k])

  # ((T, U) => Boolean) => Obj[T, U]
  filterNot: (f) =>
    @filter((x) -> not f.apply(this, arguments))

  # ((T) => Boolean) => Obj[T, U]
  filterKeys: (f) =>
    @_morph((out, k, v) => if not f(k) then delete out[k])

  # ((T, U) => [V, W]) => Obj[V, W]
  map: (f) =>
    @_comprehend(
      (out, k, v) =>
        [key, value, []] = f(k, v)
        delete out[k]
        out[key] = value
    )

  # () => Array[Array[T, U]]
  toArray: (f) =>
    for k, v of @_obj
      [k, v]

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

  # ((Obj[T, U], T, U) => Obj[V, W]) => Obj[V, W]
  _comprehend: (f) =>
    @_withNew(
      (out) =>
        for k, v of out
          f(out, k, v)
    )

  # ((Obj[T, U], T, U) => Unit) => Obj[V, W]
  _morph: (f) =>
    @_withNew(
      (out) =>
        for k, v of out
          f(out, k, v)
        out
    )

    # ((V) => X) => Obj[T, U]
  _withNew: (f) =>
    out = $.extend(true, {}, @_obj)
    f(out)
    new Obj(out)

exports.Obj = Obj
