require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

# All public functions should return a single object of type `jQuery`

define({

  generateCardEntryColumn: (innerHTML) ->
    $("<td>#{innerHTML}</td>")

  generateCardImage: (id, url, faction) ->
    bgClass = "#{faction.toLowerCase()}-backgrounded"
    anim    = @generateLoadingAnimationHTML(id, bgClass)
    img     = @generateCardCoreImage(id, url, anim, bgClass)
    $("<span></span>").append(img, anim)

  generateCardCoreImage: (id, url, anim, bgClass) ->
    domCopyOf = (elem) -> $.byID(elem.attr('id'))
    $("<img id='#{id}' class='entry-image hidden #{bgClass}' src='#{url}'>").load(
      ->
        domCopyOf(anim).remove()
        domCopyOf($(this)).removeClass("hidden")
    )

  generateCardText: (text) ->
    $("<div class='entry-text-outer'><div class='entry-text-middle'><div class='entry-text-inner'>#{text}</div></div></div>")

  generateCardEntry: (imgHTML, textHTML) ->
    $("<div class='entry-wrapper horiz-centered-children'>#{imgHTML}<br>#{textHTML}</div>")

  # (String, String, String, () => Unit) => jQuery
  generatePlayerRow: (name, id, imgID, onclick) ->
    img  = $("""<img id='#{imgID}' src='/assets/images/index/priority/simple-x.png' class="player-button">""").click(onclick)
    elem = $(
      """
      <table id="#{id}" class="player-table round-bordered card-row has-headroom">
        <tr>
          <td class="player-content">
            <table>
              <tr>
                <td>
                  <span class="player-name">#{name}</span>
                </td>
                <td>
                  <div class="placeholder">
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
    )
    elem.find(".placeholder").replaceWith(img)
    elem

  generateLoadingAnimationHTML: (idBasis, bgClass) ->
    id = "#{idBasis}-loading"
    $(
      """
      <div id='#{id}' class='entry-image #{bgClass} fade-anim-wrapper'>
        <div class="fade-anim-circle fade-anim-1"></div>
        <div class="fade-anim-circle fade-anim-2"></div>
        <div class="fade-anim-circle fade-anim-3"></div>
        <div class="fade-anim-circle fade-anim-4"></div>
        <div class="fade-anim-circle fade-anim-5"></div>
        <div class="fade-anim-circle fade-anim-6"></div>
      </div>
      """
    )

  generateCardCheckbox: (cardname, isEnabled) ->
    name    = cardname.slugify()
    checked = if isEnabled then " checked" else ""
    $("""<input type="checkbox" id="check-#{name}" name="version" class="check-button version-button dynamic-check-button"#{checked}/>
        |<label for="check-#{name}" class="unselectable check-label dynamic-check-label">#{cardname}</label>""".stripMargin())

})

