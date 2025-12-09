#!/usr/bin/env bash
docker run -d --rm -p 5432:5432 -v /tmp/docker/postgres:/var/lib/postgresql/data -e POSTGRES_PASSWORD=postgres --name local-pg postgres

# To run this script, make sure you have Docker installed and run:
# chmod +x bin/postgres-start.sh
# ./bin/postgres-start.sh
# This will start a PostgreSQL container with the database data stored in /tmp/docker/postgres on your host machine.
