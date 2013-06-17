QUnit.config.autostart = false

require(['./api/test', './index/test', './adt/test'], -> QUnit.start())
