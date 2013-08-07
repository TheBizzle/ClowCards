# This class represents a wrapper around `Object`s, with some methods for doing things non-stupidly
define(['api/cloner', 'api/prototypes', 'api/underscore']
     , ( Cloner,       [],               _) ->

  class Obj

    # _obj: Object[T]
    constructor: (@_obj) ->

    # () => Object[T]
    value: =>
      @_obj

    # (String) => T
    get: (x) =>
      @_obj[x]

    # (String, T) => Obj[T]
    append: (x, y) =>
      @_withNew((out) => out[x] = y)

    # (String) => Obj[T]
    without: (x) =>
      @_withNew((out) => delete out[x])

    # ((String, T) => Boolean) => Obj[T]
    filter: (f) =>
      @_morph((out, k, v) => if not f(k, v) then delete out[k])

    # ((String, T) => Boolean) => Obj[T]
    filterNot: (f) =>
      @filter((x) -> not f.apply(this, arguments))

    # ((String) => Boolean) => Obj[T]
    filterKeys: (f) =>
      @_morph((out, k, v) => if not f(k) then delete out[k])

    # ((String, T) => [String, U]) => Obj[U]
    map: (f) =>
      @_comprehend(
        (out, k, v) =>
          [key, value, []] = f(k, v)
          delete out[k]
          out[key] = value
      )

    # () => Obj[T]
    clone: =>
      new Obj(Cloner(@_obj))

    # () => Array[Array[String|T]]
    toArray: =>
      for k, v of @_obj
        [k, v]

    # (Int) => String
    fetchKeyByIndex: (n) =>
      Object.keys(@_obj)[n]

    # (Int) => T
    fetchValueByIndex: (n) =>
      key = @fetchKeyByIndex(n)
      @_obj[key]

    # () => Int
    size: =>
      _(@_obj).size()

    # ((Obj[T], String, T) => Obj[U]) => Obj[U]
    _comprehend: (f) =>
      @_withNew(
        (out) =>
          for k, v of out
            f(out, k, v)
      )

    # ((Obj[T], String, T) => Unit) => Obj[T]
    _morph: (f) =>
      @_withNew(
        (out) =>
          for k, v of out
            f(out, k, v)
          out
      )

    # ((Object[T]) => U) => Obj[T]
    _withNew: (f) =>
      out = @clone().value()
      f(out)
      new Obj(out)

)
