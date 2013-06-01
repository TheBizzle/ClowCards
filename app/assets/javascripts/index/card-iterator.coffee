Iterator = exports.Iterator
Obj      = exports.Obj

class CardIterator extends Iterator
  constructor: (state) ->

    f = (p) =>

      g = (pool) ->

        num  = Math.floor(Math.random() * pool.size())
        card = pool.fetchKeyByIndex(num)

        if not card? or pool.get(card).enabled
          [card, pool]
        else
          g(pool.without(card))

      [card, outPool, []] = g(p)
      [card, outPool.without(card)]

    super(new Obj(state), f)

exports.CardIterator = CardIterator
