BizzleLib =

  # (Object[T], T) => Object[T]
  deleteFrom: (target, x) ->
    replacement = $.extend(true, {}, target)
    delete replacement[x]
    replacement

  # (Array[T], T) => Array[T]
  appendTo: (xs, x) ->
    xss = xs.splice(0)
    xss.push(x)
    xss

exports.BizzleLib = BizzleLib
