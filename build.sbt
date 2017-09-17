name := "flyway-example"
homepage := Option(url("https://github.com/coreyjonoliver/flyway-example"))
scalaVersion := "2.12.3"

libraryDependencies ++= {
    Seq(
        "com.zaxxer" % "HikariCP" % "2.7.1",
        "org.flywaydb" % "flyway-core" % "3.0",
        "org.postgresql" % "postgresql" % "42.1.4"
    )
}

dockerBaseImage := "java:8-jre"
dockerUpdateLatest := true
daemonUser := "daemon"

val app = (project in file("."))
.enablePlugins(JavaAppPackaging, DockerPlugin)

