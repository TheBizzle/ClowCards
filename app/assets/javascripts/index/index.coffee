$globals     = exports.$IndexGlobals
globals      = exports.IndexGlobals
CardIterator = exports.CardIterator
Constants    = exports.IndexConstants
HTML         = exports.IndexServices.HTML
Obj          = exports.Obj

class Index

  constructor: ->
    @_cardIterator = new CardIterator(getCards())

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

  # () => Unit
  addRow: ->
    $input = $globals.$nameInput
    name   = $input.val()
    if not _(name).isEmpty() and _(globals.playerNums).size() < Constants.MaxPlayerCount
      $input.val("")
      genRow(name)

  # () => Unit
  genCards: ->

    numCards   = parseInt($globals.$cardNumSpinner.val())
    maxCards   = new Obj(getCards()).filter((k, v) -> v.enabled).size() # Not really great, but... good enough, I guess --Jason (4/30/13)
    totalCards = _(globals.playerNums).size() * numCards

    if totalCards <= maxCards
      cleanupLastCardGen()
      _([0...numCards]).forEach((x) -> genCardForEachPlayer())
    else
      msg = """You attempted to generate #{totalCards} cards, but there are only #{maxCards} available.
              |
              |Please reduce the number of cards or players and try again.
            """.stripMargin().trim()
      alert(msg)

  # () => Unit
  cleanupLastCardGen = ->
    clearCardBuckets()
    @_cardIterator = new CardIterator(getCards())

  # () => Unit
  clearCardBuckets = ->
    _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach(
      (id) -> $.byID(id).find(".row-content-row").empty()
    )

  # () => Unit
  genCardForEachPlayer = ->
    _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach((id) -> insertCardForID(id))

  # (String) => Unit
  insertCardForID = (id) ->

    card = _cardIterator.next()

    if card
      entry  = generateCardEntry(card)
      column = HTML.generateCardEntryColumn(entry)
      $.byID(id).find(".row-content-row").append(column)
    else
      alert("Card pool exhausted!  Pick fewer cards!")

  # (String) => String
  genCardNameURL = (name) ->
    "./assets/images/index/#{name.slugify()}.png"

  # (String) => Unit
  genRow = (name) ->
    nums = globals.playerNums
    num  = if _(nums).isEmpty() then 1 else (_(nums).last() + 1)
    id   = generatePlayerID(num)
    globals.playerNums = nums.append(num)
    $(HTML.generatePlayerRow(name, id)).insertBefore($globals.$adderTable)

  # (String) => String
  generatePlayerID = (num) ->
    "player-#{num}"

  # (String) => Int
  generateNumFromID = (id) ->
    [[], num, []] = _(id).words("-")
    parseInt(num)

  # (String) => String
  generateCardEntry = (name) ->
    imgURL   = genCardNameURL(name)
    imgHTML  = HTML.generateCardImage(imgURL)
    textHTML = HTML.generateCardText(name)
    HTML.generateCardEntry(imgHTML, textHTML)

  getCards = ->

    cardObj     = $.extend(true, {}, exports.Cards)
    labels      = $globals.$cardHolder.children("label").map(-> $(this))
    idNamePairs = _(labels).map((elem) -> [elem.attr("for"), elem.text()])

    _(idNamePairs).forEach(
      (pair) ->
        [id, name, []]        = pair
        cardObj[name].enabled = $.byID(id)[0].checked # Mutation == meh
    )

    cardObj

exports.IndexServices.IndexClass = Index

