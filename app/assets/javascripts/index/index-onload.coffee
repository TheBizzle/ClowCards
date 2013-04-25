window.addEventListener('load', ->

  exports.$IndexGlobals.$nameInput      = $("#name-input")
  exports.$IndexGlobals.$adderTable     = $("#adder-table")
  exports.$IndexGlobals.$cardNumSpinner = $("#card-num-spinner")
  exports.IndexGlobals.cardPool         = exports.Cards

  exports.$IndexGlobals.$cardNumSpinner.change(->
    elem    = $(this)
    value   = elem.val()
    trimmed = _(value).filter((c) -> c >= 0 and c <= 9)
    elem.val(trimmed)
  )

)
