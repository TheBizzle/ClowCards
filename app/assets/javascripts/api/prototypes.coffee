require.config({
  paths: {
    'prototype': '/assets/javascripts/api/prototype'
  }
})

define("prototypes", ['prototype/array', 'prototype/function', 'prototype/string'])
