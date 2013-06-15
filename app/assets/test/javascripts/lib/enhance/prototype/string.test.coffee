require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(['r/lib/enhance/prototype/string'], ([]) ->

  module("String Tests")

  test("stripMargin", ->

    # Default delim
    deepEqual("hello, derp!".stripMargin(),   "hello, derp!")
    deepEqual("hello|derp!".stripMargin(),    "hello|derp!")
    deepEqual("""hello
                |derp!""".stripMargin(),      "hello\nderp!")
    deepEqual("""Dear Sir.
                |It is my pleasure to contact you ,
                |and to confined on you as regards this transaction.
                |I am Mr. Nicolas Usando From Abidjan-Cote D' Ivoire ,
                |The Only Surviving Son of Late Mr. S.H Usando .""".stripMargin(), "Dear Sir.\nIt is my pleasure to contact you ,\nand to confined on you as regards this transaction.\nI am Mr. Nicolas Usando From Abidjan-Cote D' Ivoire ,\nThe Only Surviving Son of Late Mr. S.H Usando .")

    # "apples" as delim
    deepEqual("hello, derp!".stripMargin("apples"),   "hello, derp!")
    deepEqual("hello|derp!".stripMargin("apples"),    "hello|derp!")
    deepEqual("""hello
              |derp!""".stripMargin("apples"),        """hello
              |derp!""")
    deepEqual("""hello
           applesderp!""".stripMargin("apples"),      "hello\nderp!")
    deepEqual("""Dear Sir.
           applesIt is my pleasure to contact you ,
           applesand to confined on you as regards this transaction.
           applesI am Mr. Nicolas Usando From Abidjan-Cote D' Ivoire ,
           applesThe Only Surviving Son of Late Mr. S.H Usando .""".stripMargin("apples"), "Dear Sir.\nIt is my pleasure to contact you ,\nand to confined on you as regards this transaction.\nI am Mr. Nicolas Usando From Abidjan-Cote D' Ivoire ,\nThe Only Surviving Son of Late Mr. S.H Usando .")

  )

  test("slugify", ->
    deepEqual("apples".slugify(),                                          "apples")
    deepEqual("derptown expressway".slugify(),                             "derptown-expressway")
    deepEqual("DERPTOWN EXPRESSWAY".slugify(),                             "derptown-expressway")
    deepEqual("DErptOwN ExpREssWay".slugify(),                             "derptown-expressway")
    deepEqual("Hi, there".slugify(),                                       "hi-there")
    deepEqual("This is quite wonderful, don't you think. I do.".slugify(), "this-is-quite-wonderful-dont-you-think-i-do")
    deepEqual("DErp,t OwN'-ExpRE..ss'Way".slugify(),                       "derpt-own-expressway")
  )

)
