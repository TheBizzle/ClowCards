class Index

  class Replacement
    constructor: (@regex, @replacement) ->

  class SelectionState
    constructor: (@pool, @selecteds) ->

  # => Unit
  genRow: ->
    exports.$IndexGlobals.$cardTable.append($(generateRow()))

  # 3x (String) => String
  genCardNameURL   = (name) -> './assets/images/index/' + slugify(name.toLowerCase()) + '.png'
  genCardImageHTML = (url)  -> "<img class='entry-image round-bordered' src='#{url}'>"
  genCardTextHTML  = (text) -> "<div class='entry-text-outer'><div class='entry-text-middle'><div class='entry-text-inner'>#{text}</div></div></div>"

  # (String) => String
  slugify = (name) ->
    replacements = [new Replacement(/['.,]/g, ""), new Replacement(/\ /g, "-")]
    _(replacements).foldl(((acc, x) -> acc.replace(x.regex, x.replacement)), name)

  # => String
  generateRow = ->

    Max     = 5
    baseObj = new SelectionState(exports.IndexGlobals.cardPool, [])

    state   = _([1..Max]).foldl(refineSelectionState, baseObj)
    exports.IndexGlobals.cardPool = state.pool
    cards   = state.selecteds
    entries = _(cards).map(generateCardEntry)
    columns = _(entries).foldl(((acc, x) -> acc + "<td>#{x}</td>"), "")
    "<tr>#{columns}</tr>"

  # (String) => String
  generateCardEntry = (name) ->
    imgURL   = genCardNameURL(name)
    imgHTML  = genCardImageHTML(imgURL)
    textHTML = genCardTextHTML(name)
    "<div class='entry-wrapper horiz-centered-children round-bordered'>#{imgHTML}<br>#{textHTML}</div>"

  # (SelectionState, Int) => SelectionState
  refineSelectionState = (acc, x) ->

    pool      = acc.pool
    selecteds = acc.selecteds
    size      = _(pool).size()
    num       = Math.floor(Math.random() * size)
    card      = Object.keys(pool)[num]

    lib          = exports.BizzleLib
    refinedCards = lib.deleteFrom(pool, card)
    refinedRow   = lib.appendTo(selecteds, card)
    new SelectionState(refinedCards, refinedRow)

exports.IndexServices.Index = new Index

