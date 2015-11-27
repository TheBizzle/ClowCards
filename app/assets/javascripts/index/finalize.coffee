hidden_exports.index_finalize = null

exports.index_finalize =
  (->
    if hidden_exports.index_finalize isnt null
      hidden_exports.index_finalize
    else
      hidden_exports.index_finalize =
        (->

          exports.api_prototypes()
          exports.index_onload()

          $ = exports.api_jquery()

          Cards    = exports.index_cards()
          $globals = exports.index_jglobals()
          Index    = exports.index_main()

          _index   = new Index
          _preload = (url) -> $('<img/>').attr('src', url)

          initEventListeners = ->

              $globals.$adderButton.   click   (        -> _index.addRow())
              $globals.$nameInput.     keypress((event) -> _index.handleRowKey(event))
              $globals.$nameInput.     focus   (        -> _index.clearErrorFuzz())
              $globals.$nameInput.     unfocus (        -> if not _($(this).val()).isEmpty() then _index.addRow())
              $globals.$cardNumSpinner.keyup   ((event) -> _index.handleNumPickerKey(event))
              $globals.$pickBtn.       click   (        -> _index.genCards())

              $globals.$cardNumSpinner.change(->

                  elem  = $(this)
                  value = elem.val()

                  newValue =
                      if value < 0
                          0
                      else
                          _(value).filter((c) -> c >= 0 and c <= 9).value().join("")

                  finalValue = if _(newValue).isEmpty() then 0 else newValue

                  elem.val(finalValue)

              )

          preloadPriorityImages = ->
              imageNames = ['question-mark', 'simple-plus', 'simple-x']
              urls       = _(imageNames).map((name) -> _index.genPriorityImageURL(name))
              _(urls).forEach(_preload).value()

          preloadCardImages = ->
              urls  = Object.keys(Cards).map((key) -> _index.genCardImageURL(key))
              _(urls).forEach(_preload).value()

          initEventListeners()
          preloadPriorityImages()
          preloadCardImages()

        )()
      hidden_exports.index_finalize
  )
