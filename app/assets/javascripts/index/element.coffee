require.config({
  paths: {
    'r': '/assets/javascripts'
  }
})

# All public functions should be of type `(String*) => jQuery`

define({

  generateCardEntryColumn: (innerHTML) ->
    $("<td>#{innerHTML}</td>")

  generateCardImage: (id, url, faction) ->

    bgClass = "#{faction.toLowerCase()}-backgrounded"
    anim    = @generateLoadingAnimationHTML(id, bgClass)
    img     = @generateCardCoreImage(id, url, anim)

    elem = $(
      """
      <span class="outer-image-border">
        <span class="middle-image-border #{bgClass}">
          <span class="inner-image-border"></span>
        </span>
      </span>
      """
    )

    elem.find(".inner-image-border").append(img, anim)

    elem

  generateCardCoreImage: (id, url, anim) ->
    domCopyOf = (elem) -> $.byID(elem.attr('id'))
    $("<img id='#{id}' class='entry-image hidden' src='#{url}'>").load(
      ->
        domCopyOf(anim).remove()
        domCopyOf($(this)).removeClass("hidden")
    )

  generateCardText: (text) ->
    $("<div class='entry-text-outer'><div class='entry-text-middle'><div class='entry-text-inner'>#{text}</div></div></div>")

  generateCardEntry: (imgHTML, textHTML) ->
    $("<div class='entry-wrapper horiz-centered-children'>#{imgHTML}<br>#{textHTML}</div>")

  generatePlayerRow: (name, id, imgID) ->
    $(
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
                  <img id='#{imgID}' src='/assets/images/index/priority/simple-x.png' class="player-button">
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

