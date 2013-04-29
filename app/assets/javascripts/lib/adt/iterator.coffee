# Currently, this structure is very similar in operation to a `State` monad
# Once `iterate` returns `undefined`, the Iterator is considered terminated
class Iterator

  # Assume that `state` is of type `T`, and `f` is of type `(T) => [U, T]`
  state = undefined
  f     = undefined
  atEnd = false

  # Takes an initial state (`state_`), and a function for iterating over that state (`f_`)
  # `f_` should be a function that takes a single argument (`state_`) and returns `[x, newState]`,
  # where `x` is some value, or `undefined` only when iteration is complete.
  constructor: (state_, f_) ->
    state = state_
    f     = f_

  # () => U
  iterate = =>
    if not atEnd
      [x, s, nothing...] = f(state)
      if x is undefined then atEnd = true
      state = s
      x
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
        x = iterate()
        if x is undefined
          acc
        else
          helper(n - 1, acc.append(x))
    helper(n, [])

  # (Int) => Iterator[U]
  drop: (n) =>
    @take(n)
    this

  # () => Boolean
  isEmpty: ->
    atEnd

  #
  # //@ Everything below is currently undefined
  #

  # ((U) => V) => Unit
  foreach: (g) ->

  # ((U) => V) => Iterator[V]
  map:  (g) ->

  # ((U) => V) => Iterator[V]
  collect: (g) ->
    @map.andThen(@filter((x) -> x != undefined))(g)

  # (V) => ((V, U) => V) => V
  foldLeft: (zero) -> (g) ->

  # (V) => ((U, V) => V) => V
  foldRight: (zero) -> g ->

  # ((U) => Boolean) => U
  find: (g) ->

  # ((U) => Boolean) => Boolean
  exists: (g) ->

  # ((U) => Boolean) => Iterator[U]
  filter: (g) ->

  # ((U) => Boolean) => Iterator[U]
  filterNot: (g) =>
    @filter((x) -> not g.apply(this, arguments))

  # ((U) => Boolean) => Boolean
  forall: (g) ->

  # ((U) => Boolean) => Boolean
  contains: (x) ->

  # ((U) => Boolean) => U
  maxBy: (g) ->

  # ((U) => Boolean) => U
  minBy: (g) ->

  # ((U) => Boolean) => Array[U]
  sortBy: (g) ->

  # ((U) => V) => Object[V, U]
  groupBy: (g) ->

exports.Iterator = Iterator
