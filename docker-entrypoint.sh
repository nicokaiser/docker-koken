#!/bin/bash
set -euo pipefail

if ! [ -e index.php ]; then
    cp /usr/local/src/koken/index.php .
    chown www-data:www-data . index.php
fi

exec "$@"
