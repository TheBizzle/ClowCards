Lib = exports.BizzleLib

# This is a kind of funky Iterator structure, which can mutate some item that it's iterating stuff out of
# A more-functional version is forthcoming //@
# Once `iterate` returns `undefined`, the Iterator is considered terminated
class Iterator

  state = undefined
  f     = undefined
  atEnd = false

  # Takes an initial state (`state_`), and a function for iterating over that state (`f_`)
  # `f_` should be a function that takes a single argument (`state_`) and returns some value (`undefined` only when iteration is complete)
  # For the rest of this file, assume that `state` is of type `T`, and `f` is of type `(T) => U`
  constructor: (state_, f_) ->
    state = state_
    f     = f_

  # () => U
  iterate = =>
    if not atEnd
      x = f(state)
      if x is undefined then atEnd = true
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
          helper(n - 1, Lib.appendTo(acc, x))
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
