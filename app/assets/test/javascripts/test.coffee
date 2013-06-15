QUnit.config.autostart = false

require(['./lib/enhance/prototype/array.test', './lib/enhance/prototype/function.test', './lib/enhance/prototype/string.test',
         './lib/adt/iterator.test', './lib/adt/obj.test'], -> QUnit.start())

