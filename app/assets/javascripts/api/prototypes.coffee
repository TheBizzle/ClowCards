require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

# Don't refactor these out into their own files; RequireJS gets funny when you explicitly load these transitive dependencies --Jason 6/17/13
require(['r/api/underscore'], (_) ->

  # Array refinements
  # Assume that `this` is an `Array[T]`

  # (T) => Array[T]
  Array::append = (x) ->
    xs = this.slice(0)
    xs.push(x)
    xs

  # () => Array[T]
  Array::distinct = ->
    _(this).foldl(
      (acc, x) ->
        if _(acc).any((y) -> y is x) # The efficiency of this is piss-poor; I wish I had a decent way to make maps in JavaScript...
          acc
        else
          acc.append(x)
    , [])

  # (Int) => Array[T]
  Array::removeAt = (index) ->
    xs = this.slice(0)
    xs.splice(index, 1)
    xs


  # Function refinements
  # Assume that `this` is a `Function[T, U]`

  # (Function[U, V]) => Function[T, V]
  Function::andThen = (g) ->
    f = this
    (x) => g(f.apply(this, arguments))



  # String refinements

  class Replacement
    # regex:       Regex
    # replacement: String
    constructor: (@regex, @replacement) ->

  # (String) => String
  String::stripMargin = (delim = "\\|") ->
    regex = new RegExp("(?:^|\n[ \t]*)" + delim, "g")
    this.replace(regex, "\n")

  # () => String
  String::slugify = ->
    lowered = this.toLowerCase()
    replacements = [new Replacement(/['.,]/g, ""), new Replacement(/\ /g, "-")]
    _(replacements).foldl(((acc, x) -> acc.replace(x.regex, x.replacement)), lowered)

)
