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
# TODO: Why does the command have to be fully qualified? If not, get
# "executable not found". But it works unqualified from an interactive
# prompt... $PATH is different in these two situations.
docker exec ${tty_opt} luigi \
    /opt/conda/bin/sipn-reanalysis-ingest "$@"
