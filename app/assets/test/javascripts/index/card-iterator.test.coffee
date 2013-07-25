require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

define(['r/index/card-iterator', 'r/api/prototypes'], (CardIterator, []) ->

  module("CardIterator Tests")

  test("toArray (does it stream every card exactly once?)", ->

    cards1 = {}
    cards2 = { "Agent Carr": { enabled: true } }
    cards3 = {
      "Agent Carr":       { enabled: true,  faction: "Vydar"   },
      "Airborne Elite":   { enabled: true,  faction: "Jandar"  },
      "Alastair MacDirk": { enabled: true,  faction: "Jandar"  },
      "Anubian Wolves":   { enabled: true,  faction: "Utgar"   },
      "Aphotia":          { enabled: true,  faction: "Choobar" },
      "Arkmer":           { enabled: true,  faction: "Ullar"   },
      "Arrow Gruts":      { enabled: true,  faction: "Utgar"   },
      "Aubrien Archers":  { enabled: true,  faction: "Ullar"   },
      "Basilisk":         { enabled: true,  faction: "Choobar" },
      "Blade Gruts":      { enabled: true,  faction: "Utgar"   },
      "Blastatrons":      { enabled: true,  faction: "Vydar"   },
      "Braxas":           { enabled: true,  faction: "Vydar"   },
      "Brunak":           { enabled: true,  faction: "Utgar"   },
      "Chardris":         { enabled: true,  faction: "Ullar"   },
      "Charos":           { enabled: true,  faction: "Ullar"   }
    }

    deepEqual(new CardIterator(cards1).toArray().distinct().length, Object.keys(cards1).length)
    deepEqual(new CardIterator(cards2).toArray().distinct().length, Object.keys(cards2).length)
    deepEqual(new CardIterator(cards3).toArray().distinct().length, Object.keys(cards3).length)

  )

)
