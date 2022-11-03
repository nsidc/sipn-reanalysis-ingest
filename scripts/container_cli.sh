#!/usr/bin/env bash
set -euo pipefail

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT_DIR="$(realpath "$THIS_DIR/..")"

if [[ -t 1 ]]; then
    echo "TTY attached, running interactively."
    tty_opt='-it'
else
    tty_opt=''
fi

cd "$REPO_ROOT_DIR"
docker exec ${tty_opt} luigi sipn-reanalysis-ingest "$@"
