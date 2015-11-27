hidden_exports.index_constants = null

exports.index_constants =
  (->
    if hidden_exports.index_constants isnt null
      hidden_exports.index_constants
    else
      hidden_exports.index_constants =
        (-> {
          MaxPlayerCount: 10
        })()
      hidden_exports.index_constants
  )
