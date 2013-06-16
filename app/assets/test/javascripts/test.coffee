QUnit.config.autostart = false

require(['./api/prototype/test', './index/test', './lib/test'], -> QUnit.start())
