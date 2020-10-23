#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
   rm tmp/pids/server.pid
fi

cp /app/docker-database.yml /app/config/database.yml

if echo "\c $PGDATABASE; \dt" | psql | grep schema_migrations 2>&1 >/dev/null
then
   bundle exec rails db:migrate
else
   bundle exec rails db:setup
fi

cd /app

echo "Running entrypoint.sh"
bundle exec rails s -b 0.0.0.0