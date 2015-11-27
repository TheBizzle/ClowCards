hidden_exports.root_main = null

exports.root_main =
  (->
    if hidden_exports.root_main isnt null
      hidden_exports.root_main
    else
      hidden_exports.root_main =
        (->

          exports.api_prototypes()
          $ = exports.api_jquery()

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

        )()
      hidden_exports.root_main
  )
