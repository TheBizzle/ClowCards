QUnit.config.autostart = false

require.config({
  baseUrl: '/assets/test/javascripts'
})

define(['api/test', 'index/test', 'adt/test'], -> QUnit.start())
