#!/bin/bash
set -e

mkdir -p /app/backend/tmp/cache
bundle exec rails db:create
bundle exec ridgepole -c /app/shared/config/database.yml -E $RAILS_ENV --apply -f /app/shared/db/Schemafile

exec $@
