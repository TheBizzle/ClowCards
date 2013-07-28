require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(['r/api/prototypes'], ([]) ->

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

  test("distinct", ->

    arr1    = []
    target1 = []

    arr2    = [1, 2, 3]
    target2 = [1, 2, 3]

    arr3    = [1, 1, 5, 4, 2, 3, 2, 1, 5, 1, 6, 1, 6, 1, 2, 3]
    target3 = [1, 5, 4, 2, 3, 6]

    arr4    = ["1", "2", "3"]
    target4 = ["1", "2", "3"]

    arr5    = ["1", "1", "5", "4", "2", "3", "2", "1", "5", "1", "6", "1", "6", "1", "2", "3"]
    target5 = ["1", "5", "4", "2", "3", "6"]

    deepEqual(arr1.distinct(), target1)
    deepEqual(arr2.distinct(), target2)
    deepEqual(arr3.distinct(), target3)
    deepEqual(arr4.distinct(), target4)
    deepEqual(arr5.distinct(), target5)

  )

  test("removeAt", ->

    arrS1 = []
    arrE1 = arrS1.removeAt(0)

    arrS2 = ["crapples", "snapples", "mapples", "apples"]
    arrE2 = arrS2.removeAt(0)
    arrE3 = arrS2.removeAt(1)
    arrE4 = arrS2.removeAt(3)

    deepEqual(arrS1, [])
    deepEqual(arrE1, [])
    deepEqual(arrE2, ["snapples", "mapples",  "apples"])
    deepEqual(arrE3, ["crapples", "mapples",  "apples"])
    deepEqual(arrE4, ["crapples", "snapples", "mapples"])
    deepEqual(arrS2, ["crapples", "snapples", "mapples", "apples"])

  )

)
