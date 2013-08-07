require.config({
  baseUrl: ".",
  waitSeconds: 20, # Without this, jQuery-UI fails to load
  paths: {
    'jquery':            'managed/jquery-1.9.0.min',
    'jquery-ui':         'managed/jquery-ui-1.9.2.custom.min',
    'underscore':        'managed/underscore-1.4.4.min',
    'underscore-string': 'managed/underscore-string-2.3.0.min'
  },
  shim: {
    'jquery-ui': {
      exports: '$',
      deps: ['jquery']
    },
    'underscore': {
      exports: '_'
    },
    'underscore.string': {
      deps: ['underscore']
    }
  }
});
