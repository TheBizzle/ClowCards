require.config({
  paths: {
    'underscore':        '/assets/javascripts/managed/underscore-1.4.4.min',
    'underscore-string': '/assets/javascripts/managed/underscore-string-2.3.0.min'
  },
  shim: {
    'underscore': {
      exports: '_'
    },
    'underscore-string': {
      deps: ['underscore']
    }
  }
})

define(['underscore', 'underscore-string'], (_) ->
  _.mixin(_.str.exports())
  _
)
