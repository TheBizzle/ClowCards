f =
  ->

    dependOn("api_prototypes")

    Iterator = dependOn("adt_iterator")
    Obj      = dependOn("adt_obj")

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

declareModule("index_carditerator", f)
