# Currently, this structure is very similar in operation to a `State` monad
# Once `iterate` returns `undefined`, the Iterator is considered terminated
class Iterator

  # Takes an initial state (_state: T), and a function for iterating over that state (_f: (T) => [U, T])
  # `_f` should be a function that takes a single argument (`_state`) and returns `[x, newState]`,
  # where `x` is some value, or `undefined` only when iteration is complete.
  constructor: (@_state, @_f) ->
    @_atEnd   = false
    @_filters = []
    @_morpher = (x) -> x

  # () => U
  _iterate: =>

    iterationFunc = =>

      [x, s, []] = @_f(@_state)
      @_state = s

      if x is undefined
        @_atEnd = true
        x
      else
        morphed = @_morpher(x)
        if _(@_filters).every((g) -> g(morphed) is true)
          morphed
        else
          iterationFunc()

    if not @_atEnd
      iterationFunc()
    else
      undefined

  # () => U
  next: ->
    _(@take(1)).head()

  # (Int) => Array[U]
  take: (n) =>
    helper = (n, acc) =>
      if (n <= 0)
        acc
      else
        x = @_iterate()
        if x is undefined
          acc
        else
          helper(n - 1, acc.append(x))
    helper(n, [])

  # (Int) => Iterator[T, U]
  drop: (n) =>
    @take(n)
    this

  # () => Boolean
  isEmpty: ->
    @_atEnd

  # ((U) => Boolean) => Iterator[T, U]
  filter: (g) =>
    copy = @clone()
    copy._filters.push(g)
    copy

  # ((U) => Boolean) => Iterator[T, U]
  filterNot: (g) =>
    @filter((x) -> not g.apply(this, arguments))

  # Implementation of this is questionable.  This strictly evaluates the structure,
  # whereas most other similar methods are lazy in their effects.
  # But, if `foreach` doesn't strictly evaluate it, what's the point of `foreach` on `Iterator`?
  # ((U) => V) => Unit
  foreach: (g) =>

    checkState = =>
      x = @next()
      if not @isEmpty()
        performG(x)
      else
        undefined

    performG = (x) =>
      g(x)
      checkState()

    checkState()

  # () => Iterator[T, U]
  clone: =>
    copy = new Iterator(@_state, @_f)
    copy._atEnd   = @_atEnd
    copy._filters = @_filters
    copy

  # ((U) => V) => Iterator[T, V]
  map: (g) =>
    copy          = @clone()
    copy._morpher = copy._morpher.andThen(g)
    copy

  #
  # //@ Everything below is currently undefined
  #

  # ((U) => Boolean) => Option[U]
  find: (g) ->

  # ((U) => Boolean) => U
  maxBy: (g) ->

  # ((U) => Boolean) => U
  minBy: (g) ->

  # ((U) => Boolean) => Array[U]
  sortBy: (g) ->

  # ((U) => V) => Object[V, U]
  groupBy: (g) ->

exports.Iterator = Iterator
