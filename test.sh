#!/bin/bash
set -e

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

echo "Copying docker-database.yml"
cp -rf /app/docker-database.yml /app/config/database.yml

if echo "\c $PGDATABASE; \dt" | psql | grep schema_migrations 2>&1 >/dev/null
then
    bundle exec rails db:migrate
else
    bundle exec rails db:setup
fi


echo "Running Rails test"
# Run rails Test
bin/rails test
