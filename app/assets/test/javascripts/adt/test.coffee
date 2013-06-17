require.config({
  paths: {
    'tr': '/assets/test/javascripts'
  }
})

require(['tr/adt/iterator.test', 'tr/adt/obj.test', 'tr/adt/option.test'])
