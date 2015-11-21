requirejs.config({
  baseUrl:     "."
  waitSeconds: 20 # Without this, jQuery-UI fails to load
  paths: {
    "jq":   "//code.jquery.com/jquery-1.10.2.min.js",
    "jqui": "//code.jquery.com/ui/1.10.2/jquery-ui.min.js"
  },
  shim: {
    "jqui": {
      deps: ['jq']
    }
  }
});
