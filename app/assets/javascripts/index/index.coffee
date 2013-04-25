$globals = exports.$IndexGlobals

class Index

  class Replacement
    constructor: (@regex, @replacement) ->

  class SelectionState
    constructor: (@pool, @selecteds) ->

  # (Event) => Unit
  handleRowKey: (event) =>
    switch (event.keyCode or event.which)
      when 13 then @addRow()
      else

  # => Unit
  addRow: =>
    $input = $globals.$nameInput
    name   = $input.val()
    $input.val("")
    genRow(name)

  # 3x (String) => String
  genCardNameURL   = (name) -> './assets/images/index/' + slugify(name.toLowerCase()) + '.png'
  genCardImageHTML = (url)  -> "<img class='entry-image round-bordered' src='#{url}'>"
  genCardTextHTML  = (text) -> "<div class='entry-text-outer'><div class='entry-text-middle'><div class='entry-text-inner'>#{text}</div></div></div>"

  # (String) => String
  slugify = (name) ->
    replacements = [new Replacement(/['.,]/g, ""), new Replacement(/\ /g, "-")]
    _(replacements).foldl(((acc, x) -> acc.replace(x.regex, x.replacement)), name)

  # (String) => Unit
  genRow = (name) ->
    $(generateRow(name)).insertBefore($globals.$adderTable)

  # (String) => String
  generateRow = (name) ->
    """
      <table class="player-table round-bordered card-row">
        <tr>
          <td class="player-content">
            <table>
              <tr>
                <td>
                  <span class="player-remove-button player-button" onclick='exports.IndexServices.Index.addRow()'>x</span>
                </td>
                <td class="player-spacer"></td>
                <td>
                  <span class="player-name">#{name}</span>
                </td>
              </tr>
            </table>
          </td>
          <td>
            <div class="row-divider"></div>
          </td>
          <td class="row-content">
          </td>
        </tr>
      </table>
    """

  # => String
  generateCardRow = ->

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

