require.config({
  paths: {
    'r': '/assets/javascripts/'
  }
})

require(['r/main', 'r/index/cards', 'r/index/globals', 'r/index/html', 'r/index/jglobals', 'r/index/main', 'r/index/services'
        ,'r/api/prototypes', 'r/adt/obj', 'r/api/jquery', 'r/api/underscore']
       , ([],       Cards,           globals,           HTML,           $globals,           Index,          Services
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

  # Populate `card-holder`
  window.addEventListener('load', ->

    $cardHolder = $globals.$cardHolder
    cardPool    = new Obj(Cards).clone().value()

    for cardname, obj of cardPool
      $cardHolder.append(HTML.generateCardCheckbox(cardname, obj.enabled))

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

  # Preload card images
  window.addEventListener('load', ->
    Index = Services.Index
    keys  = Object.keys(Cards)
    _(keys).forEach((key) -> $('<img/>').attr('src', Index.genCardImageURL(key)))
  )

  # Initialize event listeners
  window.addEventListener('load', ->

    Index = Services.Index

    $globals.$adderButton.   click   (        -> Index.addRow())
    $globals.$nameInput.     keypress((event) -> Index.handleRowKey(event))
    $globals.$nameInput.     focus   (        -> Index.clearErrorFuzz())
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

)
