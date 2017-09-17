# flyway-example

A sample project using the [Flyway](https://flywaydb.org/) package for Scala.

## Usage

To build and run the example inside a collection of Docker containers, run the following command:
```
$ make run-example
```

This `make` job will create a database `mydb`, a user `myuser`, and two tables: `my_table` and `my_other_table`.

To verify the job ran successfully run:
```
$ make connect-to-db
```

You will be connected to a `psql` session. Navigate as desired to view its current state. For example,
to list the tables for the `mydb` database, run:
```
myuser=# \c mydb
myuser=# \dt
```

## Clean-up
Remove all docker containers, images, and volumes created for `flyway-example` by running:
```
$ make clean
```
This has the obvious side-effect of dropping the `mydb` database.




