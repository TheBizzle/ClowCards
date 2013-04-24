class Index

  class Replacement
    constructor: (@regex, @replacement) ->

  generateCardEntry: (name) ->
    imgURL   = genCardNameURL(name)
    imgHTML  = genCardImageHTML(imgURL)
    textHTML = genCardTextHTML(name)
    $("<div class='entry-wrapper horiz-centered-children round-bordered'>#{imgHTML}<br>#{textHTML}</div>")

  genCardNameURL   = (name) -> './assets/images/index/' + slugify(name.toLowerCase()) + '.png'
  genCardImageHTML = (url)  -> "<img class='entry-image round-bordered' src='#{url}'>"
  genCardTextHTML  = (text) -> "<div class='entry-text-outer'><div class='entry-text-middle'><div class='entry-text-inner'>#{text}</div></div></div>"

  slugify = (name) ->
    replacements = [new Replacement(/['.,]/g, ""), new Replacement(/\ /g, "-")]
    _(replacements).foldl(((acc, x) -> acc.replace(x.regex, x.replacement)), name)

exports.Index = new Index

window.addEventListener('load', ->
  $box   = $("#main-box")
  module = exports.Index
  for k of exports.Cards
    $box.append(module.generateCardEntry(k))
)
