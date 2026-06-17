#!/usr/bin/env bash
# ~/.config/mango/autostart.sh
# MangoWC session autostart (Wayland + XWayland friendly)

# Check PATHS are not added, and add them. This is useful for first time clones
ENV_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/mango/scripts/env.sh"
if [ -f "$ENV_FILE" ]; then
  source "$ENV_FILE"
fi


# --- Export session environment to DBus + systemd user services ---
# This fixes apps launched via desktop entries/launchers (e.g. Steam) not seeing DISPLAY/XAUTHORITY.
export XDG_CURRENT_DESKTOP="${XDG_CURRENT_DESKTOP:-wlroots}"

dbus-update-activation-environment --systemd \
  DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP \
  XDG_SESSION_TYPE XDG_SESSION_DESKTOP XDG_RUNTIME_DIR >/dev/null 2>&1 || true

systemctl --user import-environment \
  DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP \
  XDG_SESSION_TYPE XDG_SESSION_DESKTOP XDG_RUNTIME_DIR >/dev/null 2>&1 || true

# --- Wallpaper ---
#swaybg -i "$HOME/Pictures/WALLPAPERS/Desktop-Wallpapers/3D Holograms/1Tc7-5r3.png" -m fill >/dev/null 2>&1 &

# --- Waybar ---
#waybar -c "$HOME/.config/waybar/minimal/config.jsonc" -s "$HOME/.config/waybar/minimal/style.css" >/dev/null 2>&1 &

# --- Clipboard persistence + history ---
wl-clip-persist --clipboard regular --reconnect-tries 0 >/dev/null 2>&1 &
wl-paste --type text --watch cliphist store >/dev/null 2>&1 &

# --- Notifications ---
#swaync >/dev/null 2>&1 &

# --- Polkit authentication agent ---
if command -v xfce-polkit >/dev/null 2>&1; then
  xfce-polkit >/dev/null 2>&1 &
elif command -v polkit-gnome-authentication-agent-1 >/dev/null 2>&1; then
  polkit-gnome-authentication-agent-1 >/dev/null 2>&1 &
fi

# Restart elephant so it picks up the correct environment and recreates its IPC/socket
systemctl --user restart elephant.service

# Remove any other swayosd-server start lines from elsewhere.
pgrep -x swayosd-server >/dev/null || swayosd-server &

# Noctalia Shell
pgrep -f "noctalia-shell" >/dev/null || noctalia-shell >/tmp/noctalia-shell.log 2>&1 &
