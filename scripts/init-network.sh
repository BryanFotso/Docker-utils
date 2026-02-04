#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="${ROOT_DIR}/.env"

if [[ -f "${ENV_FILE}" ]]; then
  # shellcheck disable=SC1090
  set -a
  source "${ENV_FILE}"
  set +a
fi

SHARED_NETWORK="${SHARED_NETWORK:-docker-utils-shared}"

if docker network inspect "${SHARED_NETWORK}" >/dev/null 2>&1; then
  echo "Shared network already exists: ${SHARED_NETWORK}"
else
  docker network create "${SHARED_NETWORK}" >/dev/null
  echo "Shared network created: ${SHARED_NETWORK}"
fi
