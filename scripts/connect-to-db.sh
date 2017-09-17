#!/usr/bin/env bash
#
# Connect to Postgres inside Docker container
#
# USAGE:
# bash connect-to-db.sh
#
# Environment variables:
# POSTGRES_VERSION: [String] The Postgres version to use
# FLYWAY_POSTGRES_USER: [String] The Postgres database user name
# FLYWAY_POSTGRES_PASSWORD: [String] The Postgres database password
set -eu

POSTGRES_VERSION=${POSTGRES_VERSION:-}
FLYWAY_POSTGRES_USER=${FLYWAY_POSTGRES_USER:-}
FLYWAY_POSTGRES_PASSWORD=${FLYWAY_POSTGRES_PASSWORD:-}

docker run -it --rm \
		--net flywayexample_backend \
		-e PGPASSWORD="$FLYWAY_POSTGRES_PASSWORD" \
		"postgres:${POSTGRES_VERSION}" \
		psql -h db -U "$FLYWAY_POSTGRES_USER"
