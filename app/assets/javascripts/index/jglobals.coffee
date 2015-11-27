# Globals into which to cache jQuery selector results
hidden_exports.index_jglobals = null

exports.index_jglobals =
  (->
    if hidden_exports.index_jglobals isnt null
      hidden_exports.index_jglobals
    else
      hidden_exports.index_jglobals =
        (-> {
          $adderBtn:       undefined
          $adderTable:     undefined
          $cardHolder:     undefined
          $cardNumSpinner: undefined
          $nameInput:      undefined
          $pickBtn:        undefined
        })()
      hidden_exports.index_jglobals
  )
