class Option

  constructor: ->

  getOrElse: (x) ->
    if @isEmpty() then x else @get()

  map: (f) =>
    if @isEmpty() then exports.None else new Some(f(@get()))

  flatMap: (f) =>
    if @isEmpty() then exports.None else f(@get())

  filter: (f) =>
    if @isEmpty() or f(@get()) then this else exports.None

  filterNot: (f) =>
    if @isEmpty() or not f(@get()) then this else exports.None

  exists: (f) =>
    not @isEmpty() and f(@get())

  foreach: (f) =>
    if not @isEmpty() then f(@get())

  collect: (f) =>
    if not @isEmpty()
      result = f(@get())
      if result
        new Some(result)
      else
        exports.None
    else
      exports.None

  orElse: (opt) =>
    if @isEmpty() then opt else this

  toArray: =>
    if @isEmpty() then [] else [].append(@get())


class Some extends Option

  constructor: (@_value) ->
    super

  get: ->
    @_value

  isEmpty: ->
    false


class None extends Option

  constructor: ->
    super

  get: ->
    throw new Error("None.get")

  isEmpty: ->
    true


OptionCompanion = {
  from:  (value) -> if value then new Some(value) else @empty
  empty: new None
}


exports.None   = OptionCompanion.empty
exports.Some   = Some
exports.Option = OptionCompanion

