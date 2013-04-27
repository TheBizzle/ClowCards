$globals  = exports.$IndexGlobals
globals   = exports.IndexGlobals
Constants = exports.IndexConstants
HTML      = exports.IndexServices.HTML
Lib       = exports.BizzleLib

class Index

  class Replacement
    constructor: (@regex, @replacement) ->

  # (Event) => Unit
  handleRowKey: (event) =>
    switch (event.keyCode or event.which)
      when 13 then @addRow()
      else return

  # (String) => Unit
  removeRow: (id) ->
    $.byID(id).remove()
    num = generateNumFromID(id)
    globals.playerNums = _(globals.playerNums).filter((n) -> n != num)

  # => Unit
  addRow: ->
    $input = $globals.$nameInput
    name   = $input.val()
    if not _(name).isEmpty() and _(globals.playerNums).size() < Constants.MaxPlayerCount
      $input.val("")
      genRow(name)

  # => Unit
  genCards: ->
    cleanupLastCardGen()
    numCards = parseInt($globals.$cardNumSpinner.val())
    _([0...numCards]).forEach((x) -> genCardForEachPlayer())

  # => Unit
  cleanupLastCardGen = ->
    clearCardBuckets()
    globals.cardPool = $.extend(true, {}, exports.Cards)

  # => Unit
  clearCardBuckets = ->
    _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach(
      (id) -> $.byID(id).find(".row-content-row").empty()
    )

  # => Unit
  genCardForEachPlayer = ->
    _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach((id) -> insertCardForID(id))

  # (String) => Unit
  insertCardForID = (id) ->

    pool   = globals.cardPool
    size   = _(pool).size()
    num    = Math.floor(Math.random() * size)
    card   = Object.keys(pool)[num]
    entry  = generateCardEntry(card)
    column = HTML.generateCardEntryColumn(entry)

    newPool = Lib.deleteFrom(pool, card)
    globals.cardPool = newPool

    $.byID(id).find(".row-content-row").append(column)


  # (String) => String
  genCardNameURL = (name) ->
    './assets/images/index/' + slugify(name.toLowerCase()) + '.png'

  # (String) => String
  slugify = (name) ->
    replacements = [new Replacement(/['.,]/g, ""), new Replacement(/\ /g, "-")]
    _(replacements).foldl(((acc, x) -> acc.replace(x.regex, x.replacement)), name)

  # (String) => Unit
  genRow = (name) ->
    nums = globals.playerNums
    num  = if _(nums).isEmpty() then 1 else (_(nums).last() + 1)
    id   = generatePlayerID(num)
    globals.playerNums.push(num)
    $(HTML.generatePlayerRow(name, id)).insertBefore($globals.$adderTable)

  # (String) => String
  generatePlayerID = (num) ->
    "player-#{num}"

  # (String) => Int
  generateNumFromID = (id) ->
    [fluff, num, none...] = _(id).words("-")
    parseInt(num)

  # (String) => String
  generateCardEntry = (name) ->
    imgURL   = genCardNameURL(name)
    imgHTML  = HTML.generateCardImage(imgURL)
    textHTML = HTML.generateCardText(name)
    HTML.generateCardEntry(imgHTML, textHTML)

exports.IndexServices.Index = new Index

