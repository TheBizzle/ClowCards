hidden_exports.index_carditerator = null

exports.index_carditerator =
  (->
    if hidden_exports.index_carditerator isnt null
      hidden_exports.index_carditerator
    else
      hidden_exports.index_carditerator =
        (->

          exports.api_prototypes()

          Iterator = exports.adt_iterator()
          Obj      = exports.adt_obj()

          class CardIterator extends Iterator

            # state: Object[T]
            constructor: (state) ->

              iterateFunc = (p) =>

                iterateHelper = (pool) ->

                  num  = Math.floor(Math.random() * pool.size())
                  card = pool.fetchKeyByIndex(num)

                  if not card?
                    [card, pool]
                  else
                    cardObj = pool.get(card)
                    newPool = pool.without(card)
                    if cardObj.enabled
                      [card, newPool]
                    else
                      iterateHelper(newPool)

                iterateHelper(p)

              super(new Obj(state), iterateFunc)

          CardIterator

        )()
      hidden_exports.index_carditerator
  )
