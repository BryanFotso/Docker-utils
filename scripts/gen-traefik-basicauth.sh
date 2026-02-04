#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <username> [password]"
  exit 1
}

if [[ $# -lt 1 || $# -gt 2 ]]; then
  usage
fi

if ! command -v openssl >/dev/null 2>&1; then
  echo "openssl is required to generate the htpasswd hash."
  exit 1
fi

USERNAME="$1"

if [[ $# -eq 2 ]]; then
  PASSWORD="$2"
else
  read -rsp "Password for ${USERNAME}: " PASSWORD
  echo
fi

if [[ -z "${PASSWORD}" ]]; then
  echo "Password cannot be empty."
  exit 1
fi

HASH="$(openssl passwd -apr1 "${PASSWORD}")"

echo "Add this line to your .env:"
echo "TRAEFIK_DASHBOARD_USERS='${USERNAME}:${HASH}'"
