Obj = exports.Obj

class CardIterator extends exports.Iterator
  constructor: ->

    state = new Obj($.extend(true, {}, exports.Cards))

    f = (p) =>

      g = (pool) ->

        num    = Math.floor(Math.random() * pool.size())
        card   = pool.fetchKeyByIndex(num)

        if card is undefined or pool.get(card).enabled
          [card, pool]
        else
          g(pool.without(card))

      [card, outPool, nothing...] = g(p)
      [card, outPool.without(card)]

    super(state, f)

exports.CardIterator = CardIterator
