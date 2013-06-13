require.config({
  paths: {
    'jquery':    '/assets/javascripts/managed/jquery-1.9.0.min',
    'jquery-ui': '/assets/javascripts/managed/jquery-ui-1.9.2.custom.min'
  },
  shim: {
    'jquery-ui': {
      exports: '$',
      deps: ['jquery']
    }
  }
})

define(['jquery-ui'], ($) ->

  # (String) => jQuery
  $.byID = (id) -> $('#' + id)

  $

)

