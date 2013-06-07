# All public functions should be of type `(String*) => String`
class IndexHTML

  generateCardEntryColumn: (innerHTML) ->
    "<td>#{innerHTML}</td>"

  generateCardImage: (name, url, faction) ->

    r        = Math.floor(Math.random() * 10,000)
    id       = "#{name}-#{r}"
    bgClass  = "#{faction.toLowerCase()}-backgrounded"
    animHTML = @generateLoadingAnimationHTML(id, bgClass)

    """
    <img id='#{id}' class='entry-image round-bordered #{bgClass} hidden' src='#{url}'
     onload='exports.IndexServices.Index.makeImageVisible("#{id}")'>
    #{animHTML}
    """

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

  generateLoadingAnimationHTML: (idBasis, bgClass) ->
    id = "#{idBasis}-loading"
    """
    <div id='#{id}' class='entry-image round-bordered #{bgClass} fade-anim-wrapper'>
      <div class="fade-anim-circle fade-anim-1"></div>
      <div class="fade-anim-circle fade-anim-2"></div>
      <div class="fade-anim-circle fade-anim-3"></div>
      <div class="fade-anim-circle fade-anim-4"></div>
      <div class="fade-anim-circle fade-anim-5"></div>
      <div class="fade-anim-circle fade-anim-6"></div>
    </div>
    """

exports.IndexServices.HTML = new IndexHTML

