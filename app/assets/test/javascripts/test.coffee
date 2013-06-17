QUnit.config.autostart = false

require(['./api/test', './index/test', './lib/test'], -> QUnit.start())
