# All public functions should be of type `(String*) => String`
class IndexHTML

  generateCardEntryColumn: (innerHTML) ->
    "<td>#{innerHTML}</td>"

  generateCardImage: (url, faction) ->
    "<img class='entry-image round-bordered #{faction.toLowerCase()}-backgrounded' src='#{url}'>"

  generateCardText: (text) ->
    "<div class='entry-text-outer'><div class='entry-text-middle'><div class='entry-text-inner'>#{text}</div></div></div>"

  generateCardEntry: (imgHTML, textHTML) ->
    "<div class='entry-wrapper horiz-centered-children'>#{imgHTML}<br>#{textHTML}</div>"

  generatePlayerRow: (name, id) ->
    """
    <table id="#{id}" class="player-table round-bordered card-row has-headroom">
      <tr>
        <td class="player-content">
          <table>
            <tr>
              <td>
                <span class="player-remove-button player-button unselectable" onclick='exports.IndexServices.Index.removeRow("#{id}")'>x</span>
              </td>
              <td class="player-spacer"></td>
              <td>
                <span class="player-name">#{name}</span>
              </td>
            </tr>
          </table>
        </td>
        <td>
          <div class="row-divider"></div>
        </td>
        <td class="row-content">
          <table>
            <tr class="row-content-row">
            </tr>
          </table>
        </td>
      </tr>
    </table>
    """

exports.IndexServices.HTML = new IndexHTML

