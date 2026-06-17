#!/usr/bin/env bash
# NOTE:
# This is an experimental/prototype demo script.
# It may use older Mango IPC syntax and is not part of the main daily config path.
#

set -euo pipefail

# -------------------------------------------------------------------
# MangoWM desktop recording demonstration
# -------------------------------------------------------------------

MONITOR="HDMI-A-1"

ROFI_PAUSE=4
APP_PAUSE=4
LAYOUT_PAUSE=3
MOVE_PAUSE=2
TAG_PAUSE=3

rofi_pid=""

cleanup() {
    if [[ -n "${rofi_pid}" ]]; then
        kill "${rofi_pid}" 2>/dev/null || true
    fi
}

trap cleanup EXIT

pause() {
    sleep "$1"
}

view_tag() {
    local tag="$1"

    mmsg -o "${MONITOR}" -s -t "${tag}"
    pause "${TAG_PAUSE}"
}

set_layout() {
    local layout="$1"

    mmsg -o "${MONITOR}" -s -l "${layout}"
}

try_layout() {
    local layout="$1"

    if mmsg -o "${MONITOR}" -s -l "${layout}" >/dev/null 2>&1; then
        printf 'Showing layout: %s\n' "${layout}"
        pause "${LAYOUT_PAUSE}"
    else
        printf 'Skipping unsupported layout: %s\n' "${layout}"
    fi
}

dispatch() {
    local command="$1"

    mmsg -d "${command}" >/dev/null 2>&1 || true
    pause "${MOVE_PAUSE}"
}

launch() {
    "$@" >/dev/null 2>&1 &
    pause "${APP_PAUSE}"
}

launch_if_missing() {
    local process_name="$1"
    shift

    if ! pgrep -x "${process_name}" >/dev/null 2>&1; then
        launch "$@"
    fi
}

# -------------------------------------------------------------------
# Scene 1: Tag 1 starts in scroller mode
# -------------------------------------------------------------------

view_tag 1
set_layout scroller
pause "${LAYOUT_PAUSE}"

# -------------------------------------------------------------------
# Scene 2: Show the application launcher
# -------------------------------------------------------------------

rofi -show drun -show-icons >/dev/null 2>&1 &
rofi_pid="$!"

pause "${ROFI_PAUSE}"

kill "${rofi_pid}" 2>/dev/null || true
wait "${rofi_pid}" 2>/dev/null || true
rofi_pid=""

pause 1

# -------------------------------------------------------------------
# Scene 3: Populate tag 1
#
# Multiple Ghostty windows are intentional. They make the different
# tiling layouts visible and leave the final Ghostty window focused.
# -------------------------------------------------------------------

launch emacsclient -c -a emacs

launch ghostty
launch ghostty
launch ghostty

# -------------------------------------------------------------------
# Scene 4: Demonstrate all known layouts
#
# The list combines layouts supported by older and newer Mango builds.
# Unsupported layouts are skipped automatically.
# -------------------------------------------------------------------

layouts=(
    tile
    scroller
    monocle
    grid
    deck
    center_tile
    right_tile
    vertical_tile
    vertical_scroller
    vertical_grid
    vertical_spiral
    vertical_deck
    tgmix
    dwindle
    fair
    vertical_fair
)

for layout in "${layouts[@]}"; do
    try_layout "${layout}"
done

# -------------------------------------------------------------------
# Scene 5: Finish on center_tile and reposition the focused Ghostty
# -------------------------------------------------------------------

set_layout center_tile
pause "${LAYOUT_PAUSE}"

dispatch zoom
dispatch exchange_client,left
dispatch exchange_client,right
dispatch exchange_client,right
dispatch exchange_client,left
dispatch exchange_stack_client,next
dispatch exchange_stack_client,prev
dispatch zoom

# -------------------------------------------------------------------
# Scene 6: Move to tag 2 and show GIMP with OBS Studio
#
# OBS should already be running because it is recording the video.
# It is launched only if it is not currently running.
# -------------------------------------------------------------------

view_tag 2
set_layout center_tile
pause "${LAYOUT_PAUSE}"

launch gimp
launch_if_missing obs obs

pause "${APP_PAUSE}"
EOF

chmod +x ~/dotfiles/mango/scripts/mango-demo.sh
