require.config({
  paths: {
   'r': '/assets/javascripts'
  }
})

define(['r/adt/obj'], (Obj) ->

  module("Obj Tests")

  test("value", ->

    obj1 = {}
    obj2 = { apples: "crapples" }
    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    obj4 = undefined
    obj5 = null

    deepEqual(new Obj(obj1).value(), obj1)
    deepEqual(new Obj(obj2).value(), obj2)
    deepEqual(new Obj(obj3).value(), obj3)
    deepEqual(new Obj(obj4).value(), obj4)
    deepEqual(new Obj(obj5).value(), obj5)

  )

  test("get", ->

    obj1 = {}
    obj2 = { apples: "crapples" }
    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    obj4 = undefined
    obj5 = null

    deepEqual(new Obj(obj1).get("apples"),  undefined)
    deepEqual(new Obj(obj2).get("apples"),  "crapples")
    deepEqual(new Obj(obj2).get("mapples"), undefined)
    deepEqual(new Obj(obj3).get("apples"),  "crapples")
    deepEqual(new Obj(obj3).get("mapples"), "snapples")

    raises((-> new Obj(obj4).get("apples")), TypeError)
    raises((-> new Obj(obj5).get("apples")), TypeError)

  )

  test("append", ->

    obj1 = {}
    o1   = new Obj(obj1)

    deepEqual(o1.append("apples", "crapples").value(), { apples: "crapples" })
    notDeepEqual(o1.value(),                           { apples: "crapples" })
    notDeepEqual(obj1,                                 { apples: "crapples" })

    obj2 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    o2   = new Obj(obj2)

    deepEqual(o2.append("zapples", "bippity-dapples").value(), { apples: "crapples", mapples: "snapples", brapples: "wapples", zapples: "bippity-dapples" })
    notDeepEqual(o2.value(),                                   { apples: "crapples", mapples: "snapples", brapples: "wapples", zapples: "bippity-dapples" })
    notDeepEqual(obj2,                                         { apples: "crapples", mapples: "snapples", brapples: "wapples", zapples: "bippity-dapples" })

    obj3 = { apples: "crapples" }
    o3   = new Obj(obj3)

    deepEqual(o3.append("apples", "kapples").value(), { apples: "kapples" })
    notDeepEqual(o3.value(),                          { apples: "kapples" })
    notDeepEqual(obj3,                                { apples: "kapples" })

  )

  test("without", ->

    obj1 = {}
    deepEqual(new Obj(obj1).without("shoop da whoop").            value(), obj1)
    deepEqual(new Obj(obj1).without("apples").                    value(), {})
    deepEqual(new Obj(obj1).without("apples").without("brapples").value(), {})

    obj2 = { apples: "crapples" }
    deepEqual(new Obj(obj2).without("shoop da whoop").            value(), obj2)
    deepEqual(new Obj(obj2).without("apples").                    value(), {})
    deepEqual(new Obj(obj2).without("apples").without("brapples").value(), {})

    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(obj3).without("shoop da whoop").            value(), obj3)
    deepEqual(new Obj(obj3).without("apples").                    value(), { mapples: "snapples", brapples: "wapples" })
    deepEqual(new Obj(obj3).without("apples").without("brapples").value(), { mapples: "snapples" })

  )

  test("filter", ->

    obj1 = {}
    deepEqual(new Obj(obj1).filter((x, y) -> true).          value(), obj1)
    deepEqual(new Obj(obj1).filter((x, y) -> false).         value(), {})
    deepEqual(new Obj(obj1).filter((x, y) -> x is "mapples").value(), {})
    deepEqual(new Obj(obj1).filter((x, y) -> x.length < 8).  value(), {})
    deepEqual(new Obj(obj1).filter((x, y) -> y is "wapples").value(), {})
    deepEqual(new Obj(obj1).filter((x, y) -> y.length > 7).  value(), {})

    obj2 = { apples: "crapples" }
    deepEqual(new Obj(obj2).filter((x, y) -> true).          value(), obj2)
    deepEqual(new Obj(obj2).filter((x, y) -> false).         value(), {})
    deepEqual(new Obj(obj2).filter((x, y) -> x is "mapples").value(), {})
    deepEqual(new Obj(obj2).filter((x, y) -> x.length < 8).  value(), { apples: "crapples" })
    deepEqual(new Obj(obj2).filter((x, y) -> y is "wapples").value(), {})
    deepEqual(new Obj(obj2).filter((x, y) -> y.length > 7).  value(), { apples: "crapples" })

    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(obj3).filter((x, y) -> true).          value(), obj3)
    deepEqual(new Obj(obj3).filter((x, y) -> false).         value(), {})
    deepEqual(new Obj(obj3).filter((x, y) -> x is "mapples").value(), { mapples: "snapples" })
    deepEqual(new Obj(obj3).filter((x, y) -> x.length < 8).  value(), { apples: "crapples", mapples: "snapples" })
    deepEqual(new Obj(obj3).filter((x, y) -> y is "wapples").value(), { brapples: "wapples" })
    deepEqual(new Obj(obj3).filter((x, y) -> y.length > 7).  value(), { apples: "crapples", mapples: "snapples" })

  )

  test("filterNot", ->

    obj1 = {}
    deepEqual(new Obj(obj1).filterNot((x, y) -> true).          value(), {})
    deepEqual(new Obj(obj1).filterNot((x, y) -> false).         value(), obj1)
    deepEqual(new Obj(obj1).filterNot((x, y) -> x is "mapples").value(), {})
    deepEqual(new Obj(obj1).filterNot((x, y) -> x.length < 8).  value(), {})
    deepEqual(new Obj(obj1).filterNot((x, y) -> y is "wapples").value(), {})
    deepEqual(new Obj(obj1).filterNot((x, y) -> y.length > 7).  value(), {})

    obj2 = { apples: "crapples" }
    deepEqual(new Obj(obj2).filterNot((x, y) -> true).          value(), {})
    deepEqual(new Obj(obj2).filterNot((x, y) -> false).         value(), obj2)
    deepEqual(new Obj(obj2).filterNot((x, y) -> x is "mapples").value(), { apples: "crapples" })
    deepEqual(new Obj(obj2).filterNot((x, y) -> x.length < 8).  value(), {})
    deepEqual(new Obj(obj2).filterNot((x, y) -> y is "wapples").value(), { apples: "crapples" })
    deepEqual(new Obj(obj2).filterNot((x, y) -> y.length > 7).  value(), {})

    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(obj3).filterNot((x, y) -> true).          value(), {})
    deepEqual(new Obj(obj3).filterNot((x, y) -> false).         value(), obj3)
    deepEqual(new Obj(obj3).filterNot((x, y) -> x is "mapples").value(), { apples: "crapples", brapples: "wapples" })
    deepEqual(new Obj(obj3).filterNot((x, y) -> x.length < 8).  value(), { brapples: "wapples" })
    deepEqual(new Obj(obj3).filterNot((x, y) -> y is "wapples").value(), { apples: "crapples", mapples: "snapples" })
    deepEqual(new Obj(obj3).filterNot((x, y) -> y.length > 7).  value(), { brapples: "wapples" })

  )

  test("filterKeys", ->

    obj1 = {}
    deepEqual(new Obj(obj1).filterKeys((x) -> true).          value(), obj1)
    deepEqual(new Obj(obj1).filterKeys((x) -> false).         value(), {})
    deepEqual(new Obj(obj1).filterKeys((x) -> x is "mapples").value(), {})
    deepEqual(new Obj(obj1).filterKeys((x) -> x.length < 8).  value(), {})

    obj2 = { apples: "crapples" }
    deepEqual(new Obj(obj2).filterKeys((x) -> true).          value(), obj2)
    deepEqual(new Obj(obj2).filterKeys((x) -> false).         value(), {})
    deepEqual(new Obj(obj2).filterKeys((x) -> x is "mapples").value(), {})
    deepEqual(new Obj(obj2).filterKeys((x) -> x.length < 8).  value(), { apples: "crapples" })

    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(obj3).filterKeys((x) -> true).          value(), obj3)
    deepEqual(new Obj(obj3).filterKeys((x) -> false).         value(), {})
    deepEqual(new Obj(obj3).filterKeys((x) -> x is "mapples").value(), { mapples: "snapples" })
    deepEqual(new Obj(obj3).filterKeys((x) -> x.length < 8).  value(), { apples: "crapples", mapples: "snapples" })

  )

  test("map", ->

    obj1 = {}
    deepEqual(new Obj(obj1).map((x, y) -> [x,         y + '!']).  value(), obj1)
    deepEqual(new Obj(obj1).map((x, y) -> [x,         y + '!']).  value(), {})
    deepEqual(new Obj(obj1).map((x, y) -> [undefined, y + '!']).  value(), {})
    deepEqual(new Obj(obj1).map((x, y) -> [x,         undefined]).value(), {})

    obj2 = { apples: "crapples" }
    deepEqual(new Obj(obj2).map((x, y) -> [x,         y      ]).  value(), obj2)
    deepEqual(new Obj(obj2).map((x, y) -> [x,         y + '!']).  value(), { apples: "crapples!" })
    deepEqual(new Obj(obj2).map((x, y) -> [undefined, y + '!']).  value(), { undefined: "crapples!" })
    deepEqual(new Obj(obj2).map((x, y) -> [x,         undefined]).value(), { apples: undefined })

    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(obj3).map((x, y) -> [x,         y      ]).  value(), obj3)
    deepEqual(new Obj(obj3).map((x, y) -> [x,         y + '!']).  value(), { apples: "crapples!", mapples: "snapples!", brapples: "wapples!" })
    deepEqual(new Obj(obj3).map((x, y) -> [undefined, y + '!']).  value(), { undefined: "wapples!" })
    deepEqual(new Obj(obj3).map((x, y) -> [x,         undefined]).value(), { apples: undefined, mapples: undefined, brapples: undefined })

  )

  test("clone", ->

    obj1 = {}
    obj2 = { apples: "crapples" }
    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    obj4 = undefined
    obj5 = null

    deepEqual(new Obj(obj1).clone().value(), obj1)
    deepEqual(new Obj(obj2).clone().value(), obj2)
    deepEqual(new Obj(obj3).clone().value(), obj3)
    deepEqual(new Obj(obj4).clone().value(), {})
    deepEqual(new Obj(obj5).clone().value(), {})

  )

  test("toArray", ->

    obj1 = {}
    obj2 = { apples: "crapples" }
    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    obj4 = undefined
    obj5 = null

    deepEqual(new Obj(obj1).toArray(), [])
    deepEqual(new Obj(obj2).toArray(), [["apples", "crapples"]])
    deepEqual(new Obj(obj3).toArray(), [["apples", "crapples"], ["mapples", "snapples"], ["brapples", "wapples"]])
    deepEqual(new Obj(obj4).toArray(), [])
    deepEqual(new Obj(obj5).toArray(), [])

  )

  test("fetchKeyByIndex", ->

    obj1 = {}
    deepEqual(new Obj(obj1).fetchKeyByIndex(0),    undefined)
    deepEqual(new Obj(obj1).fetchKeyByIndex(2),    undefined)
    deepEqual(new Obj(obj1).fetchKeyByIndex(9001), undefined)

    obj2 = { apples: "crapples" }
    deepEqual(new Obj(obj2).fetchKeyByIndex(0),    "apples")
    deepEqual(new Obj(obj2).fetchKeyByIndex(2),    undefined)
    deepEqual(new Obj(obj2).fetchKeyByIndex(9001), undefined)

    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(obj3).fetchKeyByIndex(0),    "apples")
    deepEqual(new Obj(obj3).fetchKeyByIndex(2),    "brapples")
    deepEqual(new Obj(obj3).fetchKeyByIndex(9001), undefined)

  )

  test("fetchValueByIndex", ->

    obj1 = {}
    deepEqual(new Obj(obj1).fetchValueByIndex(0),    undefined)
    deepEqual(new Obj(obj1).fetchValueByIndex(2),    undefined)
    deepEqual(new Obj(obj1).fetchValueByIndex(9001), undefined)

    obj2 = { apples: "crapples" }
    deepEqual(new Obj(obj2).fetchValueByIndex(0),    "crapples")
    deepEqual(new Obj(obj2).fetchValueByIndex(2),    undefined)
    deepEqual(new Obj(obj2).fetchValueByIndex(9001), undefined)

    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(obj3).fetchValueByIndex(0),    "crapples")
    deepEqual(new Obj(obj3).fetchValueByIndex(2),    "wapples")
    deepEqual(new Obj(obj3).fetchValueByIndex(9001), undefined)

  )

  test("size", ->

    obj1 = {}
    obj2 = { apples: "crapples" }
    obj3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    obj4 = undefined
    obj5 = null

    deepEqual(new Obj(obj1).size(), 0)
    deepEqual(new Obj(obj2).size(), 1)
    deepEqual(new Obj(obj3).size(), 3)
    deepEqual(new Obj(obj4).size(), 0)
    deepEqual(new Obj(obj5).size(), 0)

  )

)
