#!/bin/bash
set -euo pipefail; IFS=$'\n\t'

CURRENT_TIME=$(date -Im)

pg_dump \
    --username=$POSTGRES_USER \
    --host=$POSTGRES_HOST \
    --format=custom \
    $POSTGRES_DB > "/app/backup/pg_dump-$CURRENT_TIME.dump"

echo "DB Backup Successful at $CURRENT_TIME"
