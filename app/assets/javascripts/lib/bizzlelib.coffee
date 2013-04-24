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

  # (Array, Int) => Array
  takeN: (xs, n) ->
    helper = (xs, ys, n) ->
      if n <= 0 or _(xs).isEmpty()
        ys
      else
        [h, t...] = xs
        helper(t, appendTo(ys, h), n - 1)
    helper(xs, [], n)

exports.BizzleLib = BizzleLib
