define(['index/cards', '//cdnjs.cloudflare.com/ajax/libs/lodash.js/3.10.1/lodash.min.js'], (Cards, _) ->

  window.derptown = ->
    isEnabled  = ([name, { enabled }]) -> enabled
    toName     = ([name, []]) -> name
    chunkSize  = document.getElementById("chunk-size").value
    chunks     = _(Cards).pairs().filter(isEnabled).map(toName).shuffle().chunk(chunkSize).value()
    chunkHTMLs = chunks.map((chunk) -> chunk.map((name) -> "<div class='card-name'>#{name}</div>").join('\n'))
    document.getElementById("name-container").innerHTML = chunkHTMLs.join("\n<div class='chunk-divider'>========</div>")

  window.handleNumKeys = (e) ->
    if e.keyCode is 13 then window.derptown()

)
