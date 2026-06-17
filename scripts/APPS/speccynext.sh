#!/usr/bin/env bash
set -euo pipefail

if ! command -v cspect >/dev/null 2>&1; then
  notify-send "Mango" "cspect is not installed" 2>/dev/null || true
  echo "ERROR: cspect is not installed or not in PATH" >&2
  exit 1
fi

exec cspect "$@"
