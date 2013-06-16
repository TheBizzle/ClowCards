require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(['r/lib/enhance/prototype/array'], ([]) ->

  module("Array Tests")

  test("append", ->

    arrS1 = []
    arrE1 = arrS1.append("apples")

    arrS2 = ["crapples", "snapples", "mapples"]
    arrE2 = arrS2.append("apples")

    deepEqual(arrS1, [])
    deepEqual(arrE1, ["apples"])
    deepEqual(arrS2, ["crapples", "snapples", "mapples"])
    deepEqual(arrE2, ["crapples", "snapples", "mapples", "apples"])

  )

)