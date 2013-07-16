require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(["r/main", "r/api/prototypes", "r/adt/obj", "r/adt/option", "r/api/jquery", "r/api/underscore"
       ,"r/index/card-iterator", "r/index/cards", "r/index/constants", "r/index/globals", "r/index/element", "r/index/jglobals", "r/index/onload"]
      , (main,     [],                 Obj,         Opt,            $,              _
       , CardIterator,            Cards,           Constants,           globals,           Element,           $globals,           []) ->

  class Index

    constructor: ->
      @_resetIterator()

    # (Event) => Unit
    handleRowKey: (event) ->
      switch (event.keyCode or event.which)
        when 13 then @addRow()
        else return

    # (Event) => Unit
    handleNumPickerKey: (event) ->
      switch (event.keyCode or event.which)
        when 13 then @genCards()
        else return

    # () => Unit
    clearErrorFuzz: ->
      $globals.$nameInput.removeClass('glowing-border')

    # () => Unit
    addRow: ->

      @clearErrorFuzz()

      $input = $globals.$nameInput
      name   = $input.val()

      if not _(name).isEmpty()
        if _(globals.playerNums).size() < Constants.MaxPlayerCount
          $input.val("")
          @_genRow(name)
      else
        $input.addClass('glowing-border')

    # (String) => Unit
    removeRow: (id) ->
      $.byID(id).remove()
      num = generateNumFromID(id)
      globals.playerNums = _(globals.playerNums).filter((n) -> n != num)

    # () => Unit
    genCards: ->

      @clearErrorFuzz()

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

    # (String) => String
    genCardImageURL: (name) ->
      _genCardImageURL(name)

    # (String) => String
    genPriorityImageURL: (name) ->
      "/assets/images/index/priority/#{name}.png"

    # (String) => Unit
    _genRow: (name) =>

      nums   = globals.playerNums
      num    = if _(nums).isEmpty() then 1 else (_(nums).last() + 1)
      id     = generatePlayerID(num)
      elemID = "#{id}-elem"

      globals.playerNums = nums.append(num)

      Element.generatePlayerRow(name, id, elemID, => @removeRow(id)).insertBefore($globals.$adderTable)

    # () => Unit
    _genCardForEachPlayer: =>
      _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach((id) => @_insertCardForID(id))

    # (String) => Unit
    _insertCardForID: (id) =>

      card = @_cardIterator.next()

      if card?
        # Given how this is currently implemented, this number is irrelevant; if multiple of the same card can be drawn though,
        # this then make it so that ID collisions are unlikely. --Jason (6/8/13)
        safetyNum = 10000
        r         = Math.floor(Math.random() * safetyNum)
        cardID    = "#{card.slugify()}-#{r}"
        imgURL    = _genCardImageURL(card)
        column    = Element.generateCardEntryColumn(card, cardID, imgURL, Cards[card].faction)
        $.byID(id).find(".row-content-row").append(column)
      else
        alert("Card pool exhausted!  Pick fewer cards!")

    # () => Unit
    _cleanupLastCardGen: =>
      clearCardBuckets()
      @_resetIterator()

    # () => Unit
    _resetIterator: =>
      @_cardIterator = new CardIterator(getCards())

    # (String) => Unit
    makeImageVisible = (id) ->

      loaderID = "#{id}-loading"
      img      = $.byID(id)
      loader   = $.byID(loaderID)

      img.removeClass("hidden")
      loader.remove()

    # () => Unit
    clearCardBuckets = ->
      _(globals.playerNums).map((num) -> generatePlayerID(num)).forEach(
        (id) -> $.byID(id).find(".row-content-row").empty()
      )

    # (String) => String
    _genCardImageURL = (name) ->

      origURL = "/assets/images/index/#{name.slugify()}.png"

      request = new XMLHttpRequest()
      request.open('GET', origURL, false)
      request.send(null)

      # //@ Improve this!
      if request.status is 200
        origURL
      else
        "/assets/images/index/priority/question-mark.png"

    # (String) => String
    generatePlayerID = (num) ->
      "player-#{num}"

    # (String) => Int
    generateNumFromID = (id) ->
      [[], num, []] = _(id).words("-")
      parseInt(num)

    # () => Obj[Object[Any]]
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

