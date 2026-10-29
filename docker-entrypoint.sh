#!/bin/sh
set -eu

if [ "${SKIP_ENTRYPOINT_MIGRATIONS:-false}" != "true" ]; then
  ./node_modules/.bin/prisma migrate deploy
fi
if [ "${NODE_ENV:-production}" != "production" ] && [ "${SEED_DEMO:-false}" = "true" ]; then
  ./node_modules/.bin/prisma db seed
fi
if [ "$#" -eq 0 ]; then set -- ./node_modules/.bin/next start; fi
exec "$@"
