f =
  ->

    dependOn("root_main")
    dependOn("api_prototypes")

    Cards    = dependOn("index_cards")
    globals  = dependOn("index_globals")
    $globals = dependOn("index_jglobals")
    Element  = dependOn("index_element")
    Obj      = dependOn("adt_obj")
    $        = dependOn("api_jquery")

    initGlobalsAndSelectors = ->

      $globals.$adderButton    = $.byID("adder-button")
      $globals.$adderTable     = $.byID("adder-table")
      $globals.$cardHolder     = $.byID("card-holder")
      $globals.$cardNumSpinner = $.byID("card-num-spinner")
      $globals.$nameInput      = $.byID("name-input")
      $globals.$pickBtn        = $.byID("pick-btn")

      globals.playerNums = []

    cleanupCSS = ->
      $.byID("main-box").css('overflow', 'auto')

    populateCardHolder = ->

      $cardHolder = $globals.$cardHolder
      cardPool    = new Obj(Cards).clone().value()

      for cardname, obj of cardPool
        $cardHolder.append(Element.generateCardCheckbox(cardname, obj.enabled))

      # So I don't try this a fourth time, let's get this straight: this CANNOT be refactored into `Element`,
      # since jQuery-UI methods (like `button`) don't work unless there's a DOM object for them --Jason (7/15/13)
      $cardHolder.children(".dynamic-check-button").each(->
        elem = $(this)
        elem.button()
      )

      $cardHolder.children(".dynamic-check-label").each(->
        elem = $(this)
        elem.click(-> # Stupid hack to get around fidgetty button-click behavior
          btn = $.byID(elem.attr("for"))
          btn[0].checked = not btn[0].checked
          btn.button("refresh")
          btn.change()
          false
        )
      )


    initGlobalsAndSelectors()
    cleanupCSS()
    populateCardHolder()

declareModule("index_onload", f)
