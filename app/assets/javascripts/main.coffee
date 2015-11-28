f =
  ->

    dependOn("api_prototypes")
    $ = dependOn("api_jquery")

    $(document).ready(->

      $('.collapsible-accordion').accordion({
        heightStyle: "fill"
      })

      $('.ui-button').each(->
        elem = $(this)
        elem.button()
      )

      $('.ui-tabs').each(->
        elem = $(this)
        elem.tabs()
      )

      $('.ui-spinner').each(->
        elem = $(this)
        elem.spinner()
        elem.val("1")
      )

      $('.ui-spinner-button').click(->
        elem = $(this)
        elem.siblings('input').change()
      )

      $('.checkboxes').each(->
        elem = $(this)
        elem.buttonset()
      )

      $('.check-set').each(->
        elem = $(this)
        elem.buttonset()
      )

      $('.radio-set').each(->
        elem = $(this)
        elem.buttonset()
      )

      $('.check-button').each(->
        elem = $(this)
        elem.button()
      )

      $('.check-label').each(->
        elem = $(this)
        elem.click(->
          btn = $("#" + elem.attr("for"))
          btn[0].checked = not btn[0].checked
          btn.button("refresh")
          btn.change()
          false
        )
      )

    )

declareModule("root_main", f)
