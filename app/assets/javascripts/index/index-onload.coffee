# Initialize variables and event listeners
window.addEventListener('load', ->

  exports.$IndexGlobals.$nameInput      = $("#name-input")
  exports.$IndexGlobals.$adderTable     = $("#adder-table")
  exports.$IndexGlobals.$cardNumSpinner = $("#card-num-spinner")
  exports.$IndexGlobals.$cardHolder     = $("#card-holder")

  exports.IndexGlobals.playerNums = []

  exports.$IndexGlobals.$cardNumSpinner.change(->

    elem  = $(this)
    value = elem.val()

    newValue =
      if value < 0
        0
      else
        _(value).filter((c) -> c >= 0 and c <= 9).join("")

    elem.val(newValue)

  )

)

# Populate `card-holder`
window.addEventListener('load', ->

  $cardHolder = exports.$IndexGlobals.$cardHolder
  cardPool    = new exports.Obj(exports.Cards).clone().value()

  for cardname, obj of cardPool
     name    = cardname.slugify()
     checked = if obj.enabled then " checked" else ""
     $cardHolder.append(
       """<input type="checkbox" id="check-#{name}" name="version" class="check-button version-button dynamic-check-button"#{checked}/>
         |<label for="check-#{name}" class="unselectable check-label dynamic-check-label">#{cardname}</label>""".stripMargin()
     )

  $cardHolder.children(".dynamic-check-button").each(->
    elem = $(this)
    elem.button()
  )

  $cardHolder.children(".dynamic-check-label").each(->
    elem = $(this)
    elem.click(->
      btn = $.byID(elem.attr("for"))
      btn[0].checked = not btn[0].checked
      btn.button("refresh")
      btn.change()
      false
    )
  )

)

# Initialize `Index` object
window.addEventListener('load', ->
  exports.IndexServices.Index = new exports.IndexServices.IndexClass
)
