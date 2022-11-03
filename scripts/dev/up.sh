#!/usr/bin/env bash
# Start a dev container. Also build if `-b` arg provided.
set -euo pipefail

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT_DIR="$(realpath "$THIS_DIR/../..")"
DEV_IMAGE="nsidc/sipn-reanalysis-ingest:dev"

cd "$REPO_ROOT_DIR"

if [ "${1:-}" = "-b" ]; then
    $REPO_ROOT_DIR/scripts/dev/build.sh
fi

if [ "$(docker images -q ${DEV_IMAGE} 2> /dev/null)" = "" ]; then
    echo "ERROR: Docker image not found. Pass \`-b\` to this script to build."
    exit 1
fi

# Map and create local data/logs dirs (if they aren't already configured)
export DATA_DIR="${DATA_DIR:-$REPO_ROOT_DIR/.data}"
export LOGS_DIR="${LOGS_DIR:-$REPO_ROOT_DIR/.logs}"
mkdir -p $DATA_DIR
mkdir -p $LOGS_DIR

ln -sf docker-compose.dev.yml docker-compose.override.yml
docker-compose up -d --no-build \
