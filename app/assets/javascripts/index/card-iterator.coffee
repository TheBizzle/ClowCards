class CardIterator extends exports.Iterator
  constructor: ->

    state = $.extend(true, {}, exports.Cards)

    f = (pool) =>

      g = ->

        size   = _(pool).size()
        num    = Math.floor(Math.random() * size)
        card   = Object.keys(pool)[num]

        if card is undefined or pool[card].enabled or card is undefined
          card
        else
          delete pool[card] # //@ Absolutely disgusting
          g()

      card = g()

      delete pool[card] # //@ Absolutely disgusting
      card

    super(state, f)

exports.CardIterator = CardIterator
