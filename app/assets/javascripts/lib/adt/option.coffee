class Option

  constructor: ->

  # (U) => U (such that U >: T)
  getOrElse: (x) ->
    if @isEmpty() then x else @get()

  # (T) => U
  map: (f) =>
    if @isEmpty() then exports.None else new Some(f(@get()))

  # (T) => Option[U]
  flatMap: (f) =>
    if @isEmpty() then exports.None else f(@get())

  # (T) => Boolean
  filter: (f) =>
    if @isEmpty() or f(@get()) then this else exports.None

  # (T) => Boolean
  filterNot: (f) =>
    if @isEmpty() or not f(@get()) then this else exports.None

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
      if result
        new Some(result)
      else
        exports.None
    else
      exports.None

  # (Option[U]) => Option[U] (such that U >: T)
  orElse: (opt) =>
    if @isEmpty() then opt else this

  # () => Array[T]
  toArray: =>
    if @isEmpty() then [] else [].append(@get())


class Some extends Option

  constructor: (@_value) ->
    super

  # () => T
  get: ->
    @_value

  # () => Boolean
  isEmpty: ->
    false


class None extends Option

  constructor: ->
    super

  # () => T
  get: ->
    throw new Error("None.get")

  # () => Boolean
  isEmpty: ->
    true


OptionCompanion = {

  # (T) => Option[T]
  from: (value) -> if value then new Some(value) else @empty

  # () => None
  empty: new None

}


exports.None   = OptionCompanion.empty
exports.Some   = Some
exports.Option = OptionCompanion

