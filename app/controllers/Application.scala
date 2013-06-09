package controllers

import
  play.api.mvc.{ Action, Controller }

object Application extends Controller {

  def indexImage(path: String, file: String) = Action {
    request =>
      val cacheTime = 60 * 60 * 24 // Cache duration (seconds): 1 day
      Assets.at(path, file)(request).withHeaders("Cache-Control" -> s"public, max-age=$cacheTime")
  }

  def index = Action {
    Ok(views.html.index())
  }
  
}
