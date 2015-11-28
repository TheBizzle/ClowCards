# Globals into which to cache jQuery selector results
f =
  ->
    {
      $adderBtn:       undefined
      $adderTable:     undefined
      $cardHolder:     undefined
      $cardNumSpinner: undefined
      $nameInput:      undefined
      $pickBtn:        undefined
    }

declareModule("index_jglobals", f)
