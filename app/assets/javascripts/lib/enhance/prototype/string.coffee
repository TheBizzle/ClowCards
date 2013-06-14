require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(->

  class Replacement
    constructor: (@regex, @replacement) ->

  # (String) => String
  String::stripMargin = (delim = "\\|") ->
    regex = new RegExp("\n[ \t]*" + delim, "g")
    this.replace(regex, "\n")

  # () => String
  String::slugify = ->
    lowered = this.toLowerCase()
    replacements = [new Replacement(/['.,]/g, ""), new Replacement(/\ /g, "-")]
    _(replacements).foldl(((acc, x) -> acc.replace(x.regex, x.replacement)), lowered)

)
