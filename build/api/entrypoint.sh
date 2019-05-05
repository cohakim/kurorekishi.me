#!/bin/bash
set -e

mkdir -p /app/api/tmp/cache
bundle exec rails db:create
bundle exec ridgepole -c /app/base/config/database.yml -E $RAILS_ENV --apply -f /app/base/db/Schemafile

exec $@
