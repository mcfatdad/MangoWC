#!/usr/bin/env bash
# Install a user-local Steam desktop override for Rofi/drun.
#
# This makes Rofi launch the Mango Steam wrapper instead of the system Steam
# desktop entry, while avoiding hard-coded /home/<user> paths in the repo.

set -euo pipefail

desktop_dir="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
desktop_file="$desktop_dir/steam.desktop"
steam_wrapper="${XDG_CONFIG_HOME:-$HOME/.config}/mango/scripts/APPS/steam.sh"

mkdir -p "$desktop_dir"

cat > "$desktop_file" <<DESKTOP
[Desktop Entry]
Name=Steam
Comment=Launch Steam through MangoWM rules
Exec=$steam_wrapper %U
Icon=steam
Terminal=false
Type=Application
Categories=Network;FileTransfer;Game;
MimeType=x-scheme-handler/steam;x-scheme-handler/steamlink;
StartupNotify=false
DESKTOP

echo "Installed Steam desktop override:"
echo "  $desktop_file"
echo
echo "Exec=$steam_wrapper %U"
