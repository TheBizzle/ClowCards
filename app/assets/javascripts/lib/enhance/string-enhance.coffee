String::stripMargin = (delim = "\\|") ->
  regex = new RegExp("\n[ \t]*" + delim, "g")
  this.replace(regex, "\n")
