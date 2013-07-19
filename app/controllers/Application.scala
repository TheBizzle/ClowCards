package controllers

import
  org.joda.time.Duration

import
  play.api.mvc.{ Action, Controller, ResponseHeader, SimpleResult }

object Application extends Controller {

  def indexImage(path: String, file: String) = Action {
    request =>
      Assets.at(path, file)(request) match {
        case SimpleResult(ResponseHeader(NOT_FOUND, _), _) =>
          Assets.at("/public/images/index/priority", "question-mark.png")(request)
        case result =>
          val CacheTime = Duration.standardDays(1).getStandardSeconds
          result.withHeaders("Cache-Control" -> s"public, max-age=$CacheTime")
      }
  }

  def index = Action {
    Ok(views.html.index())
  }

  def redirect(path: String) = Action {
    MovedPermanently(s"/$path")
  }

}
