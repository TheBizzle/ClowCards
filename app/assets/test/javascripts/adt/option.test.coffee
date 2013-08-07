require.config({
  baseUrl: '/assets/javascripts'
})

define(['adt/option'], (Opt) ->

  Option = Opt.Option
  Some   = Opt.Some
  None   = Opt.None

  someStr = "apples"
  some    = Option.from(someStr)

  module("Option Tests")

  test("Option.from", ->
    deepEqual(Option.from(3),         new Some(3))
    deepEqual(Option.from("apples"),  some)
    deepEqual(Option.from(null),      None)
    deepEqual(Option.from(undefined), None)
  )

  test("Option.empty", ->
    deepEqual(Option.empty, None)
  )

  test("Some.constructor", ->
    deepEqual(new Some(3).        get(),     3)
    deepEqual(new Some(3).        isEmpty(), false)
    deepEqual(new Some(undefined).get(),     undefined)
    deepEqual(new Some(undefined).isEmpty(), false)
  )

  test("getOrElse", ->

    deepEqual(some.getOrElse(() -> "dingus"), someStr)
    deepEqual(None.getOrElse(() -> "dingus"), "dingus")

    deepEqual( some.getOrElse(() -> throw new Error("TEST FAILED")),   someStr)
    raises((-> None.getOrElse(() -> throw new Error("TEST SUCCESS"))), Error)

  )

  test("map", ->
    deepEqual(some.map((x) -> x + "!"),  new Some(someStr + "!"))
    deepEqual(some.map((x) -> x.length), new Some(someStr.length))
    deepEqual(None.map((x) -> x + "!"),  None)
    deepEqual(None.map((x) -> x.length), None)
  )

  test("flatMap", ->
    deepEqual(some.flatMap((x) -> Option.from(x + "!")),  new Some(someStr + "!"))
    deepEqual(some.flatMap((x) -> Option.from(x.length)), new Some(someStr.length))
    deepEqual(some.flatMap((x) -> None),                  None)
    deepEqual(None.flatMap((x) -> Option.from(x + "!")),  None)
    deepEqual(None.flatMap((x) -> Option.from(x.length)), None)
  )

  test("filter", ->
    deepEqual(some.filter((x) -> true),  some)
    deepEqual(some.filter((x) -> false), None)
    deepEqual(None.filter((x) -> true),  None)
    deepEqual(None.filter((x) -> false), None)
  )

  test("filterNot", ->
    deepEqual(some.filterNot((x) -> true),  None)
    deepEqual(some.filterNot((x) -> false), some)
    deepEqual(None.filterNot((x) -> true),  None)
    deepEqual(None.filterNot((x) -> false), None)
  )

  test("exists", ->
    deepEqual(some.exists((x) -> true),  true)
    deepEqual(some.exists((x) -> false), false)
    deepEqual(None.exists((x) -> true),  false)
    deepEqual(None.exists((x) -> false), false)
  )

  test("foreach", ->

    someCounter = 0
    some.foreach((x) -> someCounter += 10)
    deepEqual(someCounter, 10)

    noneCounter = 0
    None.foreach((x) -> noneCounter += 10)
    deepEqual(noneCounter, 0)

  )

  test("collect", ->
    deepEqual(some.collect((x) -> x + "!"),                                       new Some(someStr + "!"))
    deepEqual(some.collect((x) -> x.length),                                      new Some(someStr.length))
    deepEqual(some.collect((x) -> if x is   "apples" then "derp" else undefined), new Some("derp"))
    deepEqual(some.collect((x) -> if x is "crapples" then "derp" else undefined), None)
    deepEqual(None.collect((x) -> x + "!"),                                       None)
    deepEqual(None.collect((x) -> x.length),                                      None)
  )

  test("orElse", ->
    deepEqual( some.orElse(() -> None),                                    some)
    deepEqual( some.orElse(() -> Option.from("derptown")),                 some)
    deepEqual( some.orElse(() -> throw new Error("You have messed up!")),  some)
    deepEqual( None.orElse(() -> None),                                    None)
    deepEqual( None.orElse(() -> Option.from("derptown")),                 new Some("derptown"))
    raises((-> None.orElse(() -> throw new Error("You have messed up!"))), Error)
  )

  test("toArray", ->
    deepEqual(some.toArray(), [someStr])
    deepEqual(None.toArray(), [])
  )

  test("get", ->
    deepEqual( some.get(),  someStr)
    raises((-> None.get()), Error)
  )

  test("isEmpty", ->
    deepEqual(some.isEmpty(), false)
    deepEqual(None.isEmpty(), true)
  )

)

