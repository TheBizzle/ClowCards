require.config({
  baseUrl: '/assets/javascripts'
})

define(['adt/iterator', 'adt/option', 'api/underscore'], (Iterator, Opt, _) ->

  None   = Opt.None
  Option = Opt.Option

  iterator = undefined

  refreshIterator = -> iterator = new Iterator([1..100], (xs) ->
    ys = _(xs)
    [ys.head(), ys.tail()]
  )

  bumbleHash =
    (x) ->
      switch x
        when 21 then 9001
        when 89 then -9001
        else         0

  module("Iterator Tests", {
    setup: -> refreshIterator()
  })

  test("next", ->
    deepEqual(iterator.next(), 1)
    deepEqual(iterator.next(), 2)
    deepEqual(iterator.next(), 3)
    deepEqual(iterator.next(), 4)
  )

  test("take", ->
    deepEqual(iterator.take(5),    [1..5])
    deepEqual(iterator.take(2),    [6..7])
    deepEqual(iterator.take(12),   [8..19])
    deepEqual(iterator.take(9001), [20..100])
  )

  test("takeWhile", ->
    deepEqual(iterator.takeWhile((x) => false),     [])
    deepEqual(iterator.takeWhile((x) => x < 10),    [1..9])
    deepEqual(iterator.takeWhile((x) => x is 9001), [])
    deepEqual(iterator.takeWhile((x) => true),      [10..100])
  )

  test("drop", ->
    deepEqual(iterator.drop(5).next(),    6)
    deepEqual(iterator.drop(2).next(),    9)
    deepEqual(iterator.drop(12).next(),   22)
    deepEqual(iterator.drop(9001).next(), undefined)
  )

  test("dropWhile", ->
    deepEqual(iterator.dropWhile((x) => false).next(),     1)
    deepEqual(iterator.dropWhile((x) => x < 10).next(),    10)
    deepEqual(iterator.dropWhile((x) => x is 9001).next(), 11)
    deepEqual(iterator.dropWhile((x) => true).next(),      undefined)
  )

  test("isEmpty", ->
    deepEqual(iterator.                           isEmpty(), false)
    deepEqual(iterator.filter((x) -> x < 5).      isEmpty(), false)
    deepEqual(iterator.filter((x) -> x < 20).     isEmpty(), false)
    deepEqual(iterator.drop(2).                   isEmpty(), false)
    deepEqual(iterator.dropWhile((x) -> x < 90).  isEmpty(), false)
    deepEqual(iterator.dropWhile((x) -> x < 9001).isEmpty(), true)
  )

  test("filter", ->
    deepEqual(iterator.clone().filter((x) -> x % 2 == 0).       toArray(), x for x in [2..100] by 2)
    deepEqual(iterator.clone().filter((x) -> x > 20 and x < 60).toArray(), [21..59])
    deepEqual(iterator.clone().filter((x) -> x < 20 or x > 60). toArray(), [1..19].concat([61..100]))
    deepEqual(iterator.clone().filter((x) -> false).            toArray(), [])
    deepEqual(iterator.clone().filter((x) -> true).             toArray(), [1..100])
  )

  test("filterNot", ->
    deepEqual(iterator.clone().filterNot((x) -> x % 2 == 0).       toArray(), x for x in [1..100] by 2)
    deepEqual(iterator.clone().filterNot((x) -> x > 20 and x < 60).toArray(), [1..20].concat([60..100]))
    deepEqual(iterator.clone().filterNot((x) -> x < 20 or x > 60). toArray(), [20..60])
    deepEqual(iterator.clone().filterNot((x) -> false).            toArray(), [1..100])
    deepEqual(iterator.clone().filterNot((x) -> true).             toArray(), [])
  )

  test("foreach", ->
    sum = 0
    iterator.clone().foreach((x) -> sum += x)
    deepEqual(sum, _([1..100]).foldl(((acc, x) -> acc + x), 0))
  )

  test("map", ->

    i0 = iterator
    i1 = i0.map((x) -> x + 3)
    i2 = i1.map((x) -> x * 4)
    i3 = i2.map((x) -> x / 4)
    i4 = i3.map((x) -> x + "!")

    deepEqual(i1.toArray(),   [4..103])
    deepEqual(i2.toArray(),   x for x in [16..412] by 4)
    deepEqual(i3.toArray(),   [4..103])
    deepEqual(i4.toArray(), _([4..103]).map((x) -> x + "!"))

  )

  test("find", ->
    deepEqual(iterator.clone().find((x) -> true),                   Option.from(1))
    deepEqual(iterator.clone().find((x) -> false),                  None)
    deepEqual(iterator.clone().find((x) -> x % 2 is 0),             Option.from(2))
    deepEqual(iterator.clone().find((x) -> x % 10 is 0 and x > 50), Option.from(60))
    deepEqual(iterator.clone().find((x) -> x is 9001),              None)
    deepEqual(iterator.clone().find((x) -> x > 10),                 Option.from(11))
  )

  test("maxBy", ->
    deepEqual(iterator.clone().maxBy((x) -> 1),                 100)
    deepEqual(iterator.clone().maxBy((x) -> x),                 100)
    deepEqual(iterator.clone().maxBy((x) -> -x),                1)
    deepEqual(iterator.clone().maxBy((x) -> (x + "").length),   100)
    deepEqual(iterator.clone().maxBy((x) -> -Math.abs(x - 50)), 50)
    deepEqual(iterator.clone().maxBy((x) -> bumbleHash(x)),     21)
  )

  test("minBy", ->
    deepEqual(iterator.clone().minBy((x) -> 0),                 1)
    deepEqual(iterator.clone().minBy((x) -> x),                 1)
    deepEqual(iterator.clone().minBy((x) -> -x),                100)
    deepEqual(iterator.clone().minBy((x) -> (x + "").length),   1)
    deepEqual(iterator.clone().minBy((x) -> -Math.abs(x - 50)), 100)
    deepEqual(iterator.clone().minBy((x) -> bumbleHash(x)),     89)
  )

  test("sortBy", ->

    down   = (y for y in [50..1])
    up     = (z for z in [51..100])
    zipped = _(_(down).zip(up)).foldl(((acc, x) -> acc.concat(x)), []).reverse()

    bumbledSubtarget = _([1..100]).filter((x) -> not (x is 21 or x is 89))
    bumbledTarget    = [89].concat(bumbledSubtarget).append(21)

    deepEqual(iterator.clone().sortBy((x) -> x),                 [1..100])
    deepEqual(iterator.clone().sortBy((x) -> -x),                [100..1])
    deepEqual(iterator.clone().sortBy((x) -> (x + "").length),   [1..100])
    deepEqual(iterator.clone().sortBy((x) -> -Math.abs(x - 50)), zipped)
    deepEqual(iterator.clone().sortBy((x) -> bumbleHash(x)),     bumbledTarget)

  )

  test("groupBy", ->

    arr1    = iterator.clone().groupBy((x) -> x)
    target1 = _([1..100]).foldl(((acc, x) -> acc[x] = [x]; acc), {})

    arr2    = iterator.clone().groupBy((x) -> (x + "").length)
    target2 = { 1: [1..9], 2: [10..99], 3: [100] }

    arr3    = iterator.clone().groupBy(bumbleHash)
    target3 = { '-9001': [89], 0: _([1..100]).filter((x) -> not (x is 21 or x is 89)), 9001: [21] }

    deepEqual(arr1, target1)
    deepEqual(arr2, target2)
    deepEqual(arr3, target3)

  )

  test("toArray", ->
    deepEqual(iterator.clone().toArray(),            [1..100])
    deepEqual(iterator.clone().drop(20).toArray(),   [21..100])
    deepEqual(iterator.clone().drop(9001).toArray(), [])
  )

  test("Mixed Ops", ->

    source1 = iterator.clone().map((x) -> x * 3).filter((x) -> x % 2 is 1).filterNot((x) -> x < 10).map((x) -> x - 2).next()
    target1 = 13

    source2 = iterator.clone().map((x) -> x + 1).drop(10).filter((x) -> (x + "").length is 3).toArray()
    target2 = [100..101]

    source3 = iterator.clone().filter((x) -> x % 2 is 0).drop(20).map((x) -> x * 10).take(10)
    target3 = _(x for x in [420..1000] by 20).take(10)

    deepEqual(source1, target1)
    deepEqual(source2, target2)
    deepEqual(source3, target3)

  )

)
