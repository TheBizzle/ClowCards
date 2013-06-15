package controllers

import
  play.api.mvc.{ Action, Controller }

/**
 * Created with IntelliJ IDEA.
 * User: jason
 * Date: 6/14/13
 * Time: 10:43 PM
 */
object Test extends Controller {

  def javascripts = Action {
    Ok(views.html.test.javascripts())
  }

}
