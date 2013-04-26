window.addEventListener('load', ->

  exports.$IndexGlobals.$nameInput      = $("#name-input")
  exports.$IndexGlobals.$adderTable     = $("#adder-table")
  exports.$IndexGlobals.$cardNumSpinner = $("#card-num-spinner")

  exports.IndexGlobals.cardPool   = $.extend(true, {}, exports.Cards)
  exports.IndexGlobals.playerNums = []

  exports.$IndexGlobals.$cardNumSpinner.change(->

    elem  = $(this)
    value = elem.val()

    newValue =
      if value < 0
        0
      else
        _(value).filter((c) -> c >= 0 and c <= 9).join("")

    elem.val(newValue)

  )

)
