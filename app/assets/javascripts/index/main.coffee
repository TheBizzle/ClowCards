require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(["r/main", "r/lib/adt/obj", "r/lib/enhance/jquery", "r/lib/enhance/prototypes", "r/lib/enhance/underscore", "r/lib/adt/option"
       ,"r/index/card-iterator", "r/index/cards", "r/index/constants", "r/index/globals", "r/index/html", "r/index/jglobals", "r/index/onload"]
      , (main,     Obj,             $,                      [],                         _,                          Opt
       , CardIterator,            Cards,           Constants,           globals,           HTML,           $globals,           []) ->

  class Index

    constructor: ->
      @_cardIterator = new CardIterator(getCards())

    # (Event) => Unit
    handleRowKey: (event) =>
      switch (event.keyCode or event.which)
        when 13 then @addRow()
        else return

    # (Event) => Unit
    handleNumPickerKey: (event) =>
      switch (event.keyCode or event.which)
        when 13 then @genCards()
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
        @_genRow(name)

    # (String) => Unit
    _genRow: (name) =>

      nums   = globals.playerNums
      num    = if _(nums).isEmpty() then 1 else (_(nums).last() + 1)
      id     = generatePlayerID(num)
      spanID = "#{id}-span"

      globals.playerNums = nums.append(num)

      $(HTML.generatePlayerRow(name, id, spanID)).insertBefore($globals.$adderTable)
      $.byID(spanID).click(=> @removeRow(id))

    # () => Unit
    genCards: =>

      numCards   = parseInt($globals.$cardNumSpinner.val())
      maxCards   = new Obj(getCards()).filter((k, v) -> v.enabled).size() # Not really great, but... good enough, I guess --Jason (4/30/13)
      totalCards = _(globals.playerNums).size() * numCards

      if totalCards <= maxCards
        @_cleanupLastCardGen()
        _([0...numCards]).forEach((x) => @_genCardForEachPlayer())
      else
        msg = """You attempted to generate #{totalCards} cards, but there are only #{maxCards} available.
                |
                |Please reduce the number of cards or players and try again.
              """.stripMargin().trim()
        alert(msg)

    # () => Unit
    _genCardForEachPlayer: =>
      _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach((id) => @_insertCardForID(id))

    # (String) => Unit
    _insertCardForID: (id) ->

      card = @_cardIterator.next()

      if card?
        # Given how this is currently implemented, this number is irrelevant; if multiple of the same card can be drawn though,
        # this then make it so that ID collisions are unlikely. --Jason (6/8/13)
        safetyNum = 10000
        r         = Math.floor(Math.random() * safetyNum)
        cardID    = "#{card.slugify()}-#{r}"
        entry     = generateCardEntry(card, cardID)
        column    = HTML.generateCardEntryColumn(entry)
        $.byID(id).find(".row-content-row").append(column)
        $.byID(cardID).load(-> makeImageVisible(cardID))
      else
        alert("Card pool exhausted!  Pick fewer cards!")

    # (String) => String
    genCardNameURL: (name) ->
      _genCardNameURL(name)

    # (String) => Unit
    makeImageVisible = (id) ->

      loaderID = "#{id}-loading"
      img      = $.byID(id)
      loader   = $.byID(loaderID)

      img.removeClass("hidden")
      loader.remove()

    # () => Unit
    _cleanupLastCardGen: ->
      clearCardBuckets()
      @_cardIterator = new CardIterator(getCards())

    # () => Unit
    clearCardBuckets = ->
      _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach(
        (id) -> $.byID(id).find(".row-content-row").empty()
      )

    # (String) => String
    _genCardNameURL = (name) ->
      "./assets/images/index/#{name.slugify()}.png"

    # (String) => String
    generatePlayerID = (num) ->
      "player-#{num}"

    # (String) => Int
    generateNumFromID = (id) ->
      [[], num, []] = _(id).words("-")
      parseInt(num)

    # (String) => String
    generateCardEntry = (name, id) ->
      imgURL   = _genCardNameURL(name)
      imgHTML  = HTML.generateCardImage(id, imgURL, Cards[name].faction)
      textHTML = HTML.generateCardText(name)
      HTML.generateCardEntry(imgHTML, textHTML)

    # () => Object[String, Object[String, Any]]
    getCards = ->

      cardObj = new Obj(Cards).clone().value()
      labels  = $globals.$cardHolder.children("label").map(-> $(this))

      _(labels).forEach(
        (elem) ->
          id   = elem.attr("for")
          name = elem.text()
          cardObj[name].enabled = $.byID(id)[0].checked
      )

      cardObj

)

