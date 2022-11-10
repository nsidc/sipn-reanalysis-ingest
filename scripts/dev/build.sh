#!/usr/bin/env bash
# Create a dev image which is specially configured to use the same user
# in-container as the current host user
#
# WARNING: A simple `docker-compose build` with an override file will not work
#          because the correct envvars will not be set.
set -euo pipefail

THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT_DIR="$(realpath "$THIS_DIR/../..")"

# Use the current user's ids inside the container
export MAMBA_USER_ID="$(id -u ${USER})"
export MAMBA_USER_GID="$(id -g ${USER})"

cd "$REPO_ROOT_DIR"
ln -sf docker-compose.dev.yml docker-compose.override.yml
docker-compose build
