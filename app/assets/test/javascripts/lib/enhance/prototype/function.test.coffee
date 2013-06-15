require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(['r/lib/enhance/prototype/function'], ([]) ->

  module("Function Tests")

  test("andThen", ->

    f = (x) -> x + 3
    g = (y) -> y + '!'

    deepEqual(f.andThen(g)(5),    "8!")
    deepEqual(f.andThen(g)(9001), "9004!")

  )

)
