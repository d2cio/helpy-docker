#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

SLEEPSECONDS=5
echo "waiting $SLEEPSECONDS seconds for $POSTGRES_HOST.."

# sleep while postgres is initializing
sleep $SLEEPSECONDS
pg_isready -q -h $POSTGRES_HOST
ISREADY=$?
while [[ "$ISREADY" != 0 ]]; do
  pg_isready -q -h $POSTGRES_HOST
  let ISREADY=$?
  echo "waiting $SLEEPSECONDS seconds for $POSTGRES_HOST.."
  sleep $SLEEPSECONDS
done

echo "$POSTGRES_HOST is now avaliable"

echo "starting unicorn"

exec bundle exec unicorn -E production -c config/unicorn.rb
