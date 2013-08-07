define(['api/prototypes'], ([]) ->

  # Type Parameter: T (the type that is maybe (or maybe not) wrapped inside of the `Option`)
  class Option

    constructor: ->

    # (() => U) => U (such that U >: T)
    getOrElse: (x) =>
      if @isEmpty() then x() else @get()

    # (T) => U
    map: (f) =>
      if @isEmpty() then NoneObj else new Some(f(@get()))

    # (T) => Option[U]
    flatMap: (f) =>
      if @isEmpty() then NoneObj else f(@get())

    # (T) => Boolean
    filter: (f) =>
      if @isEmpty() or f(@get()) then this else NoneObj

    # (T) => Boolean
    filterNot: (f) =>
      if @isEmpty() or not f(@get()) then this else NoneObj

    # (T) => Boolean
    exists: (f) =>
      not @isEmpty() and f(@get())

    # (T) => Unit
    foreach: (f) =>
      if not @isEmpty() then f(@get())
      return

    # ((V) => U) => Option[U] (such that T >: V)
    collect: (f) =>
      if not @isEmpty()
        result = f(@get())
        if result?
          new Some(result)
        else
          NoneObj
      else
        NoneObj

    # (() => Option[U]) => Option[U] (such that U >: T)
    orElse: (optFunc) =>
      if @isEmpty() then optFunc() else this

    # () => Array[T]
    toArray: =>
      if @isEmpty() then [] else [].append(@get())

  class Some extends Option

    # _value: T
    constructor: (@_value) ->
      super

    # () => T
    get: =>
      @_value

    # () => Boolean
    isEmpty: =>
      false

  class None extends Option

    constructor: ->
      super

    # () => T
    get: =>
      throw new Error("None.get")

    # () => Boolean
    isEmpty: =>
      true

  OptionCompanion = {

    # (T) => Option[T]
    from: (value) -> if value? then new Some(value) else @empty

    # None
    empty: new None

  }

  NoneObj = OptionCompanion.empty

  {
    Some:   Some
    None:   NoneObj
    Option: OptionCompanion
  }

)
