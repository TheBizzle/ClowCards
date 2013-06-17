require.config({
  paths: {
    'tr': '/assets/test/javascripts'
  }
})

require(['tr/api/array.test', 'tr/api/function.test', 'tr/api/string.test'])
