require.config({
  paths: {
    'prototype': '/assets/javascripts/lib/enhance/prototype'
  }
})

define("prototypes", ['prototype/array', 'prototype/function', 'prototype/string'])
