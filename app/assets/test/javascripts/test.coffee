QUnit.config.autostart = false

require.config({
  baseUrl: '/assets/test/javascripts'
})

require(['api/test', 'index/test', 'adt/test'], -> QUnit.start())
