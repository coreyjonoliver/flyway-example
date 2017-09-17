package org.coreyoliver.flywayexample

import java.util.Properties

import com.zaxxer.hikari.{HikariConfig, HikariDataSource}
import org.flywaydb.core.Flyway

object Main extends App {
  val props = new Properties()
  props.setProperty("dataSource.user", sys.env.get("FLYWAY_POSTGRES_USER").get)
  props.setProperty("dataSource.password", sys.env.get("FLYWAY_POSTGRES_PASSWORD").get)
  props.setProperty("dataSourceClassName", "org.postgresql.ds.PGSimpleDataSource")
  props.setProperty("dataSource.databaseName", "mydb")
  props.setProperty("dataSource.portNumber", "5432")
  props.setProperty("dataSource.serverName", "db")
  val ds = new HikariDataSource(new HikariConfig(props))

  val flyway = new Flyway
  flyway.setDataSource(ds)
  flyway.migrate()
}
