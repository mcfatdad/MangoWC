#!/usr/bin/env bash
set -euo pipefail

if ! command -v simcoupe >/dev/null 2>&1; then
  notify-send "Mango" "simcoupe is not installed" 2>/dev/null || true
  echo "ERROR: simcoupe is not installed or not in PATH" >&2
  exit 1
fi

exec simcoupe "$@"
