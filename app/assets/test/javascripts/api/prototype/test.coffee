require.config({
  paths: {
    'tr': '/assets/test/javascripts'
  }
})

require(['tr/api/prototype/array.test', 'tr/api/prototype/function.test', 'tr/api/prototype/string.test'])
