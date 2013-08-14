import sbt._
import Keys._
import play.Project._

object ApplicationBuild extends Build {

  val appName         = "ClowCards"
  val appVersion      = "1.0-SNAPSHOT"

  val appDependencies = Seq(
    "org.webjars" %% "webjars-play"      % "2.2.0",
    "org.webjars" %  "requirejs"         % "2.1.1",
    "org.webjars" %  "jquery-ui"         % "1.10.2-1",
    "org.webjars" %  "lodash-underscore" % "2.2.1"
      from "http://ccl.northwestern.edu/devel/jason/lodash-underscore-2.2.1.jar",
    jdbc,
    anorm
  )

  val main = play.Project(appName, appVersion, appDependencies).settings(
    requireJs     += "index.js",
    requireJsShim := "require-config.js"
  )

}
