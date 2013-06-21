package controllers

import
  play.api.mvc.{ Action, Controller }

object Application extends Controller {

  def indexImage(path: String, file: String) = Action {
    request =>
      val CacheTime = 60 * 60 * 24 // Cache duration (seconds): 1 day
      Assets.at(path, file)(request).withHeaders("Cache-Control" -> s"public, max-age=$CacheTime")
  }

  def index = Action {
    Ok(views.html.index())
  }

  def redirect(path: String) = Action {
    MovedPermanently(s"/$path")
  }

}
