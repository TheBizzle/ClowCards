require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(['r/api/prototypes', 'r/api/jquery', 'r/lib/adt/iterator', 'r/lib/adt/obj']
      , ([],                 $,                      Iterator,             Obj) ->

  class CardIterator extends Iterator

    # state: Object[T, U] //@ Aren't `Object`'s keys always `String`s?
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

)
