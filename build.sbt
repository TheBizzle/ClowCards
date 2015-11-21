val root = (project in file(".")).enablePlugins(PlayScala)

name := "ClowCards"

version := "1.0-SNAPSHOT"

organization := "org.bizzle"

licenses += ("BSD-3", url("http://opensource.org/licenses/bsd-3-clause"))

scalaVersion := "2.11.7"

scalacOptions ++= "-deprecation -unchecked -feature -Xcheckinit -encoding us-ascii -target:jvm-1.7 -Xlint -Xfatal-warnings -language:_".split(" ").toSeq

ivyLoggingLevel := UpdateLogging.Quiet

libraryDependencies ++= Seq(
  cache
)

ivyScala := ivyScala.value map { _.copy(overrideScalaVersion = true) }

onLoadMessage := ""

logBuffered in testOnly in Test := false

includeFilter in (Assets, LessKeys.less) := "*.less"

pipelineStages := Seq(rjs)

RjsKeys.mainModule := "index"

RjsKeys.mainConfigFile := target.value / "web" / "public" / "main" / "javascripts" / "require-config.js"
