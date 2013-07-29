require.config({
  paths: {
    'ractive': '/assets/javascripts/managed/ractive-0.3.3.min'
  },
  shim: {
    'ractive': {
      exports: 'ractive'
    }
  }
})

define(['ractive'], (Ractive) -> Ractive)

