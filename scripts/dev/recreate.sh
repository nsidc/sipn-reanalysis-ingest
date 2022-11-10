#!/usr/bin/env bash
# Start a dev container. Also build if `-b` arg provided.
set -euo pipefail

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT_DIR="$(realpath "$THIS_DIR/../..")"
DEV_IMAGE="nsidc/sipn-reanalysis-ingest:dev"

cd "$REPO_ROOT_DIR"

docker-compose down
if [ "${1:-}" = "-b" ]; then
    $REPO_ROOT_DIR/scripts/dev/up.sh -b
else
    $REPO_ROOT_DIR/scripts/dev/up.sh
fi
