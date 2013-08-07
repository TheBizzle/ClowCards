require.config({
  baseUrl: '/assets/javascripts'
})

define(['adt/obj'], (Obj) ->

  module("Obj Tests")

  test("value", ->

    object1 = {}
    object2 = { apples: "crapples" }
    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    object4 = undefined
    object5 = null

    deepEqual(new Obj(object1).value(), object1)
    deepEqual(new Obj(object2).value(), object2)
    deepEqual(new Obj(object3).value(), object3)
    deepEqual(new Obj(object4).value(), object4)
    deepEqual(new Obj(object5).value(), object5)

  )

  test("get", ->

    object1 = {}
    object2 = { apples: "crapples" }
    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    object4 = undefined
    object5 = null

    deepEqual(new Obj(object1).get("apples"),  undefined)
    deepEqual(new Obj(object1).get("mapples"), undefined)
    deepEqual(new Obj(object2).get("apples"),  "crapples")
    deepEqual(new Obj(object2).get("mapples"), undefined)
    deepEqual(new Obj(object3).get("apples"),  "crapples")
    deepEqual(new Obj(object3).get("mapples"), "snapples")

    raises((-> new Obj(object4).get("apples")), TypeError)
    raises((-> new Obj(object5).get("apples")), TypeError)

  )

  test("append", ->

    object1 = {}
    obj1    = new Obj(object1)
    target1 = { apples: "crapples" }

    deepEqual(obj1.append("apples", "crapples").value(), target1)
    notDeepEqual(obj1.value(), target1)
    notDeepEqual(object1,      target1)

    object2 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    obj2    = new Obj(object2)
    target2 = { apples: "crapples", mapples: "snapples", brapples: "wapples", zapples: "bippity-dapples" }

    deepEqual(obj2.append("zapples", "bippity-dapples").value(), target2)
    notDeepEqual(obj2.value(), target2)
    notDeepEqual(object2,      target2)

    object3 = { apples: "crapples" }
    obj3    = new Obj(object3)
    target3 = { apples: "kapples" }

    deepEqual(obj3.append("apples", "kapples").value(), target3)
    notDeepEqual(obj3.value(), target3)
    notDeepEqual(object3,      target3)

  )

  test("without", ->

    object1 = {}
    deepEqual(new Obj(object1).without("shoop da whoop").            value(), object1)
    deepEqual(new Obj(object1).without("apples").                    value(), {})
    deepEqual(new Obj(object1).without("apples").without("brapples").value(), {})

    object2 = { apples: "crapples" }
    deepEqual(new Obj(object2).without("shoop da whoop").            value(), object2)
    deepEqual(new Obj(object2).without("apples").                    value(), {})
    deepEqual(new Obj(object2).without("apples").without("brapples").value(), {})

    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(object3).without("shoop da whoop").            value(), object3)
    deepEqual(new Obj(object3).without("apples").                    value(), { mapples: "snapples", brapples: "wapples" })
    deepEqual(new Obj(object3).without("apples").without("brapples").value(), { mapples: "snapples" })

  )

  test("filter", ->

    object1 = {}
    deepEqual(new Obj(object1).filter((x, y) -> true).          value(), object1)
    deepEqual(new Obj(object1).filter((x, y) -> false).         value(), {})
    deepEqual(new Obj(object1).filter((x, y) -> x is "mapples").value(), {})
    deepEqual(new Obj(object1).filter((x, y) -> x.length < 8).  value(), {})
    deepEqual(new Obj(object1).filter((x, y) -> y is "wapples").value(), {})
    deepEqual(new Obj(object1).filter((x, y) -> y.length > 7).  value(), {})

    object2 = { apples: "crapples" }
    deepEqual(new Obj(object2).filter((x, y) -> true).          value(), object2)
    deepEqual(new Obj(object2).filter((x, y) -> false).         value(), {})
    deepEqual(new Obj(object2).filter((x, y) -> x is "mapples").value(), {})
    deepEqual(new Obj(object2).filter((x, y) -> x.length < 8).  value(), { apples: "crapples" })
    deepEqual(new Obj(object2).filter((x, y) -> y is "wapples").value(), {})
    deepEqual(new Obj(object2).filter((x, y) -> y.length > 7).  value(), { apples: "crapples" })

    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(object3).filter((x, y) -> true).          value(), object3)
    deepEqual(new Obj(object3).filter((x, y) -> false).         value(), {})
    deepEqual(new Obj(object3).filter((x, y) -> x is "mapples").value(), { mapples: "snapples" })
    deepEqual(new Obj(object3).filter((x, y) -> x.length < 8).  value(), { apples: "crapples", mapples: "snapples" })
    deepEqual(new Obj(object3).filter((x, y) -> y is "wapples").value(), { brapples: "wapples" })
    deepEqual(new Obj(object3).filter((x, y) -> y.length > 7).  value(), { apples: "crapples", mapples: "snapples" })

  )

  test("filterNot", ->

    object1 = {}
    deepEqual(new Obj(object1).filterNot((x, y) -> true).          value(), {})
    deepEqual(new Obj(object1).filterNot((x, y) -> false).         value(), object1)
    deepEqual(new Obj(object1).filterNot((x, y) -> x is "mapples").value(), {})
    deepEqual(new Obj(object1).filterNot((x, y) -> x.length < 8).  value(), {})
    deepEqual(new Obj(object1).filterNot((x, y) -> y is "wapples").value(), {})
    deepEqual(new Obj(object1).filterNot((x, y) -> y.length > 7).  value(), {})

    object2 = { apples: "crapples" }
    deepEqual(new Obj(object2).filterNot((x, y) -> true).          value(), {})
    deepEqual(new Obj(object2).filterNot((x, y) -> false).         value(), object2)
    deepEqual(new Obj(object2).filterNot((x, y) -> x is "mapples").value(), { apples: "crapples" })
    deepEqual(new Obj(object2).filterNot((x, y) -> x.length < 8).  value(), {})
    deepEqual(new Obj(object2).filterNot((x, y) -> y is "wapples").value(), { apples: "crapples" })
    deepEqual(new Obj(object2).filterNot((x, y) -> y.length > 7).  value(), {})

    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(object3).filterNot((x, y) -> true).          value(), {})
    deepEqual(new Obj(object3).filterNot((x, y) -> false).         value(), object3)
    deepEqual(new Obj(object3).filterNot((x, y) -> x is "mapples").value(), { apples: "crapples", brapples: "wapples" })
    deepEqual(new Obj(object3).filterNot((x, y) -> x.length < 8).  value(), { brapples: "wapples" })
    deepEqual(new Obj(object3).filterNot((x, y) -> y is "wapples").value(), { apples: "crapples", mapples: "snapples" })
    deepEqual(new Obj(object3).filterNot((x, y) -> y.length > 7).  value(), { brapples: "wapples" })

  )

  test("filterKeys", ->

    object1 = {}
    deepEqual(new Obj(object1).filterKeys((x) -> true).          value(), object1)
    deepEqual(new Obj(object1).filterKeys((x) -> false).         value(), {})
    deepEqual(new Obj(object1).filterKeys((x) -> x is "mapples").value(), {})
    deepEqual(new Obj(object1).filterKeys((x) -> x.length < 8).  value(), {})

    object2 = { apples: "crapples" }
    deepEqual(new Obj(object2).filterKeys((x) -> true).          value(), object2)
    deepEqual(new Obj(object2).filterKeys((x) -> false).         value(), {})
    deepEqual(new Obj(object2).filterKeys((x) -> x is "mapples").value(), {})
    deepEqual(new Obj(object2).filterKeys((x) -> x.length < 8).  value(), { apples: "crapples" })

    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(object3).filterKeys((x) -> true).          value(), object3)
    deepEqual(new Obj(object3).filterKeys((x) -> false).         value(), {})
    deepEqual(new Obj(object3).filterKeys((x) -> x is "mapples").value(), { mapples: "snapples" })
    deepEqual(new Obj(object3).filterKeys((x) -> x.length < 8).  value(), { apples: "crapples", mapples: "snapples" })

  )

  test("map", ->

    object1 = {}
    deepEqual(new Obj(object1).map((x, y) -> [x,         y + '!']).  value(), object1)
    deepEqual(new Obj(object1).map((x, y) -> [x,         y + '!']).  value(), {})
    deepEqual(new Obj(object1).map((x, y) -> [undefined, y + '!']).  value(), {})
    deepEqual(new Obj(object1).map((x, y) -> [x,         undefined]).value(), {})

    object2 = { apples: "crapples" }
    deepEqual(new Obj(object2).map((x, y) -> [x,         y      ]).  value(), object2)
    deepEqual(new Obj(object2).map((x, y) -> [x,         y + '!']).  value(), { apples: "crapples!" })
    deepEqual(new Obj(object2).map((x, y) -> [undefined, y + '!']).  value(), { undefined: "crapples!" })
    deepEqual(new Obj(object2).map((x, y) -> [x,         undefined]).value(), { apples: undefined })

    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(object3).map((x, y) -> [x,         y      ]).  value(), object3)
    deepEqual(new Obj(object3).map((x, y) -> [x,         y + '!']).  value(), { apples: "crapples!", mapples: "snapples!", brapples: "wapples!" })
    deepEqual(new Obj(object3).map((x, y) -> [undefined, y + '!']).  value(), { undefined: "wapples!" })
    deepEqual(new Obj(object3).map((x, y) -> [x,         undefined]).value(), { apples: undefined, mapples: undefined, brapples: undefined })

  )

  test("clone", ->

    object1 = {}
    object2 = { apples: "crapples" }
    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    object4 = undefined
    object5 = null

    deepEqual(new Obj(object1).clone().value(), object1)
    deepEqual(new Obj(object2).clone().value(), object2)
    deepEqual(new Obj(object3).clone().value(), object3)
    deepEqual(new Obj(object4).clone().value(), {})
    deepEqual(new Obj(object5).clone().value(), {})

  )

  test("toArray", ->

    object1 = {}
    object2 = { apples: "crapples" }
    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    object4 = undefined
    object5 = null

    deepEqual(new Obj(object1).toArray(), [])
    deepEqual(new Obj(object2).toArray(), [["apples", "crapples"]])
    deepEqual(new Obj(object3).toArray(), [["apples", "crapples"], ["mapples", "snapples"], ["brapples", "wapples"]])
    deepEqual(new Obj(object4).toArray(), [])
    deepEqual(new Obj(object5).toArray(), [])

  )

  test("fetchKeyByIndex", ->

    object1 = {}
    deepEqual(new Obj(object1).fetchKeyByIndex(0),    undefined)
    deepEqual(new Obj(object1).fetchKeyByIndex(2),    undefined)
    deepEqual(new Obj(object1).fetchKeyByIndex(9001), undefined)

    object2 = { apples: "crapples" }
    deepEqual(new Obj(object2).fetchKeyByIndex(0),    "apples")
    deepEqual(new Obj(object2).fetchKeyByIndex(2),    undefined)
    deepEqual(new Obj(object2).fetchKeyByIndex(9001), undefined)

    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(object3).fetchKeyByIndex(0),    "apples")
    deepEqual(new Obj(object3).fetchKeyByIndex(2),    "brapples")
    deepEqual(new Obj(object3).fetchKeyByIndex(9001), undefined)

  )

  test("fetchValueByIndex", ->

    object1 = {}
    deepEqual(new Obj(object1).fetchValueByIndex(0),    undefined)
    deepEqual(new Obj(object1).fetchValueByIndex(2),    undefined)
    deepEqual(new Obj(object1).fetchValueByIndex(9001), undefined)

    object2 = { apples: "crapples" }
    deepEqual(new Obj(object2).fetchValueByIndex(0),    "crapples")
    deepEqual(new Obj(object2).fetchValueByIndex(2),    undefined)
    deepEqual(new Obj(object2).fetchValueByIndex(9001), undefined)

    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    deepEqual(new Obj(object3).fetchValueByIndex(0),    "crapples")
    deepEqual(new Obj(object3).fetchValueByIndex(2),    "wapples")
    deepEqual(new Obj(object3).fetchValueByIndex(9001), undefined)

  )

  test("size", ->

    object1 = {}
    object2 = { apples: "crapples" }
    object3 = { apples: "crapples", mapples: "snapples", brapples: "wapples" }
    object4 = undefined
    object5 = null

    deepEqual(new Obj(object1).size(), Object.keys(object1).length)
    deepEqual(new Obj(object2).size(), Object.keys(object2).length)
    deepEqual(new Obj(object3).size(), Object.keys(object3).length)
    deepEqual(new Obj(object4).size(), 0)
    deepEqual(new Obj(object5).size(), 0)

  )

)
