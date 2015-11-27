# Non-selector globals

hidden_exports.index_globals = null

exports.index_globals =
  (->
    if hidden_exports.index_globals isnt null
      hidden_exports.index_globals
    else
      hidden_exports.index_globals =
        (-> {
          $adderBtn:       undefined
          $adderTable:     undefined
          $cardHolder:     undefined
          $cardNumSpinner: undefined
          $nameInput:      undefined
          $pickBtn:        undefined
        })()
      hidden_exports.index_globals
  )
