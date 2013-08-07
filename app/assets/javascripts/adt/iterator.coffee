# Currently, this structure is very similar in operation to a `State` monad
# Once `iterate` returns `undefined`, the `Iterator` is considered to have reached the end of iteration
define(['api/prototypes', 'adt/option', 'api/underscore']
     , ( [],               Opt,          _) ->

  Option = Opt.Option
  None   = Opt.None

  class Iterator

    # Takes an initial state (_state: T), and a function for iterating over that state (_f: (T) => [U, T])
    # `_f` should be a function that takes a single argument (`_state`) and returns `[x, newState]`,
    # where `x` is some value, or `undefined` only when iteration is complete.
    constructor: (@_state, @_f) ->
      @_atEnd     = false
      @_cached    = undefined # Kinda gross, but... okay (necessary for `dropWhile`; nice for `takeWhile`)
      @_manipList = new ManipList([])

    # () => U
    _iterate: =>

      iterationFunc = =>

        [x, s, []] = @_f(@_state)
        @_state = s

        if not x?
          @_atEnd = true
          x
        else
          @_manipList.processArg(x).getOrElse(-> iterationFunc())

      if @_cached?
        x = @_cached
        @_cached = undefined
        x
      else if not @_atEnd
        iterationFunc()
      else
        undefined

    # () => U
    next: =>
      _(@take(1)).head()

    # (Int) => Array[U]
    take: (n) =>
      helper = (n, acc) =>
        if n <= 0
          acc
        else
          x = @_iterate()
          if not x?
            acc
          else
            helper(n - 1, acc.append(x))
      helper(n, [])

    # ((U) => Boolean) => Array[U]
    takeWhile: (g) =>
      helper = (acc, g) =>
        x = @_iterate()
        if not x? or not g(x)
          @_cached = x
          acc
        else
          helper(acc.append(x), g)
      helper([], g)

    # (Int) => Iterator[T, U]
    drop: (n) =>
      @take(n)
      this

    # ((U) => Boolean) => Iterator[T, U]
    dropWhile: (g) =>
      @takeWhile(g)
      this

    # () => Boolean
    isEmpty: =>
      @_atEnd

    # ((U) => Boolean) => Iterator[T, U]
    filter: (g) =>
      copy = @clone()
      copy._manipList = copy._manipList.append(new FilterManip(g))
      copy

    # ((U) => Boolean) => Iterator[T, U]
    filterNot: (g) =>
      @filter((x) -> not g.apply(this, arguments))

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
      copy._atEnd     = @_atEnd
      copy._cached    = @_cached
      copy._manipList = @_manipList
      copy

    # ((U) => V) => Iterator[T, V]
    map: (g) =>
      copy = @clone()
      copy._manipList = copy._manipList.append(new MapManip(g))
      copy

    # ((U) => Boolean) => Option[U]
    find: (g) =>

      checkState = =>
        x = @next()
        if not @isEmpty()
          checkG(x)
        else
          None

      checkG = (x) =>
        if g(x)
          Option.from(x)
        else
          checkState()

      checkState()

    # ((U) => Boolean) => U
    maxBy: (g) =>
      arr = @toArray()
      _(arr).max(g)

    # ((U) => Boolean) => U
    minBy: (g) =>
      arr = @toArray()
      _(arr).min(g)

    # ((U) => Boolean) => Array[U]
    sortBy: (g) =>
      arr = @toArray()
      _(arr).sortBy(g)

    # ((U) => String) => Object[Array[U]]
    groupBy: (g) =>
      arr = @toArray()
      _(arr).groupBy(g)

    # () => Array[U]
    toArray: =>
      @takeWhile((x) => true)


  class ManipList

    # _arr: Array[Manipulator]
    constructor: (@_arr) ->

    # The `Z` here is the output type of the last `MapManip` that gets executed in the chain
    # (T) => Option[Z]
    processArg: (arg) =>
      _(@_arr).foldl(((acc, manipulator) -> manipulator.manip(acc)), Option.from(arg))

    # (Manipulator) => ManipList
    append: (manipulator) =>
      new ManipList(@_arr.append(manipulator))


  class Manipulator

    # _f: (T) => U
    constructor: (@_f) ->

    # (Option[T]) => Option[V]
    manip: (argOpt) => argOpt


  class FilterManip extends Manipulator

    # _f: (T) => Boolean
    constructor: (_f) ->
      super(_f)

    # (Option[T]) => Option[T]
    manip: (argOpt) => argOpt.flatMap((arg) => if @_f(arg) then Option.from(arg) else None)


  class MapManip extends Manipulator

    # _f: (T) => U
    constructor: (_f) ->
      super(_f)

    # (Option[T]) => Option[U]
    manip: (argOpt) => argOpt.map((arg) => @_f(arg))


  Iterator

)
