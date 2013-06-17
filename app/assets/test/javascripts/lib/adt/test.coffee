require.config({
  paths: {
    'tr': '/assets/test/javascripts'
  }
})

require(['tr/lib/adt/iterator.test', 'tr/lib/adt/obj.test', 'tr/lib/adt/option.test'])
