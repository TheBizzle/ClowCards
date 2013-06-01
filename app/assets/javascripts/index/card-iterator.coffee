Iterator = exports.Iterator
Obj      = exports.Obj

class CardIterator extends Iterator
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

exports.CardIterator = CardIterator
