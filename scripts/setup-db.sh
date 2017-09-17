#!/usr/bin/env bash
#
# Setup a simple database in the Postgres Docker container
#
# USAGE:
# bash setup-db.sh
#
# Environment variables:
# POSTGRES_VERSION: [String] The Postgres version to use
# FLYWAY_POSTGRES_USER: [String] The Postgres database user name
# FLYWAY_POSTGRES_PASSWORD: [String] The Postgres database password
# FLYWAY_POSTGRES_DB_NAME: [String] The Postgres database name
set -eu

POSTGRES_VERSION=${POSTGRES_VERSION:-}
FLYWAY_POSTGRES_USER=${FLYWAY_POSTGRES_USER:-}
FLYWAY_POSTGRES_PASSWORD=${FLYWAY_POSTGRES_PASSWORD:-}
FLYWAY_POSTGRES_DB_NAME=${FLYWAY_POSTGRES_DB_NAME:-}

echo "--> Creating $FLYWAY_POSTGRES_DB_NAME database"
drop_and_create=$(cat << EOF
    dropdb ${FLYWAY_POSTGRES_DB_NAME} --if-exists --host db --username ${FLYWAY_POSTGRES_USER} && \
    createdb ${FLYWAY_POSTGRES_DB_NAME} --host db --username ${FLYWAY_POSTGRES_USER}
EOF
)

docker run --rm -i \
		--net flywayexample_backend \
		-e PGPASSWORD="$FLYWAY_POSTGRES_PASSWORD" \
		"postgres:${POSTGRES_VERSION}" \
		sh -c "$drop_and_create"
