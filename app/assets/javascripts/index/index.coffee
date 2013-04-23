class Index

  class Replacement
    constructor: (@regex, @replacement) ->

  generateCardEntry: (name) ->
    imgURL   = genCardNameURL(name)
    imgHTML  = genCardImageHTML(imgURL)
    textHTML = genCardTextHTML(name)
    $("<div class='entry-wrapper'>#{imgHTML}#{textHTML}</div>")

  genCardNameURL   = (name) -> './assets/images/index/' + slugify(name.toLowerCase()) + '.png'
  genCardImageHTML = (url)  -> "<img class='entry-image' src='#{url}'>"
  genCardTextHTML  = (text) -> "<span class='entry-text'>#{text}</span>"

  slugify = (name) ->
    replacements = [new Replacement(/['.,]/g, ""), new Replacement(/\ /g, "-")]
    _(replacements).foldl(((acc, x) -> acc.replace(x.regex, x.replacement)), name)

exports.Index = new Index

window.addEventListener('load', ->
  $box   = $("#main-box")
  module = exports.Index
  _(exports.CardNames).forEach((name) -> $box.append(module.generateCardEntry(name)))
)
