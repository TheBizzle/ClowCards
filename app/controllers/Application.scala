package controllers

import
  scala.concurrent.Future

import
  org.joda.time.Duration

import
  play.api.mvc.{ Action, Controller }

import play.api.libs.concurrent.Execution.Implicits.defaultContext

object Application extends Controller {

  def indexImage(path: String, file: String) = Action.async {
    request =>
      Assets.at(path, file)(request).flatMap {
        case result if result.header.status == 404 =>
          Assets.at("/public/images/index/priority", "question-mark.png")(request)
        case result =>
          val CacheTime = Duration.standardDays(1).getStandardSeconds
          Future(result.withHeaders("Cache-Control" -> s"public, max-age=$CacheTime"))
      }
  }

  def index = Action {
    Ok(views.html.index())
  }

  def basic = Action {
    Ok(views.html.basic())
  }

  def redirect(path: String) = Action {
    MovedPermanently(s"/$path")
  }

}
