require.config({
  paths: {
    'r': '/assets/javascripts/'
  }
})

define(['r/api/jquery', 'r/api/prototypes', 'r/api/ractive'], ($, [], Ractive) ->

  playerTemplate = """
                     |<table class="player-table round-bordered card-row has-headroom">
                     |  <tr>
                     |    <td class="player-content">
                     |      <table>
                     |        <tr>
                     |          <td>
                     |            <span class="player-name">{{name}}</span>
                     |          </td>
                     |          <td>
                     |            <img src='/assets/images/index/priority/simple-x.png' proxy-click="removePlayer:{{i}}" class="player-button">
                     |          </td>
                     |        </tr>
                     |      </table>
                     |    </td>
                     |    <td>
                     |      <div class="row-divider"></div>
                     |    </td>
                     |    <td class="row-content">
                     |      <table>
                     |        <tr class="row-content-row">
                     |        </tr>
                     |      </table>
                     |    </td>
                     |  </tr>
                     |</table>
                   """.stripMargin().trim()

  model = new Ractive({
    el:       $.byID("player-box"),
    partials: { playerTemplate: playerTemplate }
    template: """
                |{{#players:i}}
                |  {{>playerTemplate}}
                |{{/players}}
              """.stripMargin().trim(),
    data: {
      players:      [],
      current_sets: []
    }
  })

  # (String, (T) => T) => Unit
  update = (name, f) ->
    old = model.get(name)
    model.set(name, f(old))

  model.on({
    removePlayer: (e, i) -> update('players', (old) -> old.removeAt(i))
  })

  model

)

