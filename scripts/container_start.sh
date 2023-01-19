#!/usr/bin/env bash
#
# Start the docker service(s).
#
# NOTE: If you want to test using a specific docker container version, it's
# expected that you've already set `SIPN_REANALYSIS_INGEST_VERSION` as desired.
#
# HACK: Shellcheck complains about ancillary file
#     https://github.com/koalaman/shellcheck/issues/769
# shellcheck source=/dev/null
set -euo pipefail

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT_DIR="$(realpath "$THIS_DIR/..")"

cd "$REPO_ROOT_DIR"
docker-compose up --detach
