#!/usr/bin/env bash
# Launch Steam without changing tags.
# Window placement is handled by conf.d/70-windowrules.conf.

set -u

launch_detached() {
  if command -v setsid >/dev/null 2>&1; then
    setsid -f "$@" >/dev/null 2>&1
  else
    "$@" >/dev/null 2>&1 &
  fi
}

# Do not use "steam -silent": that loads Steam to the system tray only.
# Do not run mmsg here: this launcher must not switch tags.
launch_detached steam "$@"
