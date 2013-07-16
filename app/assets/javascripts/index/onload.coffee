require.config({
  paths: {
    'r': '/assets/javascripts/'
  }
})

require(['r/main', 'r/index/cards', 'r/index/globals', 'r/index/element', 'r/index/jglobals', 'r/index/main', 'r/index/services'
        ,'r/api/prototypes', 'r/adt/obj', 'r/api/jquery', 'r/api/underscore']
       , ([],       Cards,           globals,           Element,           $globals,           Index,          Services
        , [],                 Obj,         $,              _) ->

  # Initialize globals and selectors
  window.addEventListener('load', ->

    $globals.$adderButton    = $.byID("adder-button")
    $globals.$adderTable     = $.byID("adder-table")
    $globals.$cardHolder     = $.byID("card-holder")
    $globals.$cardNumSpinner = $.byID("card-num-spinner")
    $globals.$nameInput      = $.byID("name-input")
    $globals.$pickBtn        = $.byID("pick-btn")

    globals.playerNums = []

  )

  # Cleaning individual element CSS after jQuery-UI inits
  window.addEventListener('load', ->
    $.byID("main-box").css('overflow', 'auto')
  )

  # Populate `card-holder`
  window.addEventListener('load', ->

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

  )

  # Initialize `Index` object
  window.addEventListener('load', ->
    Services.Index = new Index
  )

  # Preload priority images
  window.addEventListener('load', ->
    Index      = Services.Index
    imageNames = ['simple-plus', 'simple-x']
    urls       = _(imageNames).map((name) -> Index.genPriorityImageURL(name))
    _(urls).forEach(preload)
  )

  # Preload card images
  window.addEventListener('load', ->
    Index = Services.Index
    urls  = Object.keys(Cards).map((key) -> Index.genCardImageURL(key))
    _(urls).forEach(preload)
  )

  # Initialize event listeners
  window.addEventListener('load', ->

    Index = Services.Index

    $globals.$adderButton.   click   (        -> Index.addRow())
    $globals.$nameInput.     keypress((event) -> Index.handleRowKey(event))
    $globals.$nameInput.     focus   (        -> Index.clearErrorFuzz())
    $globals.$nameInput.     unfocus (        -> if not _($(this).val()).isEmpty() then Index.addRow())
    $globals.$cardNumSpinner.keyup   ((event) -> Index.handleNumPickerKey(event))
    $globals.$pickBtn.       click   (        -> Index.genCards())

    $globals.$cardNumSpinner.change(->

      elem  = $(this)
      value = elem.val()

      newValue =
        if value < 0
          0
        else
          _(value).filter((c) -> c >= 0 and c <= 9).join("")

      finalValue = if _(newValue).isEmpty() then 0 else newValue

      elem.val(finalValue)

    )

  )

  preload = (url) -> $('<img/>').attr('src', url)

)
