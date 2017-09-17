#!/usr/bin/env bash
#
# Sleep until a connection can be established to the Postgres Docker container
#
# USAGE:
# bash wait-for-db.sh
#
# Environment variables:
# POSTGRES_VERSION: [String] The Postgres version to use
# FLYWAY_POSTGRES_USER: [String] The Postgres database user name
# FLYWAY_POSTGRES_PASSWORD: [String] The Postgres database password
set -eu

POSTGRES_VERSION=${POSTGRES_VERSION:-}
FLYWAY_POSTGRES_USER=${FLYWAY_POSTGRES_USER:-}
FLYWAY_POSTGRES_PASSWORD=${FLYWAY_POSTGRES_PASSWORD:-}

is_psql_up() {
    docker run --rm -i \
    --net flywayexample_backend \
    --entrypoint psql \
    -e PGPASSWORD="$FLYWAY_POSTGRES_PASSWORD" \
    "postgres:${POSTGRES_VERSION}" \
    --host db \
    --username "$FLYWAY_POSTGRES_USER" \
    --quiet \
    -c '\l' > /dev/null 2>&1
}

n=0
max_retries=100
echo "--> Attempting to establish connection to Postgres"
until is_psql_up; do
    if [[ $n -lt $max_retries ]]; then
        n=$((n+1))
        echo "Failed to establish connection to Postgres. Attempt $n/$max_retries."
        sleep 1
    else
        echo "Failed to establish connection to Postgres after $n attempts." >&2
        exit 1
    fi
done

echo "Connection to Postgres established."
