#!/usr/bin/env zsh

## https://github.com/Zellington3/Ghost-Monitor-Wayvnc-Hyprland

# === CONFIG ===
VIRTUAL_MONITOR="HEADLESS-2"
VIRTUAL_WORKSPACE=6

# === Auto-detect Real Monitor ===
echo "[wayvnc] Detecting real (non-headless) monitor..."
# Find the first monitor that does NOT contain "headless" (case-insensitive)
REAL_MONITOR=$(hyprctl monitors | grep '^Monitor ' | grep -iv 'headless' | head -n 1 | awk '{print $2}')

# Check if we actually found a monitor
if [[ -z "$REAL_MONITOR" ]]; then
  echo "[wayvnc] Error: Could not find a real (non-headless) monitor. Exiting."
  exit 1
fi

echo "[wayvnc] Using '$REAL_MONITOR' as the real monitor."

# === CLEANUP FUNCTION ===
cleanup() {
  echo "\n[wayvnc] Cleaning up..."
  hyprctl dispatch moveworkspacetomonitor $VIRTUAL_WORKSPACE $REAL_MONITOR
  hyprctl dispatch focusmonitor "$REAL_MONITOR"
  pkill wayvnc
  echo "[wayvnc] Done."
  exit 0
}

# === Trap Exit for Cleanup ===
trap cleanup INT TERM EXIT

# === Check if HEADLESS-2 is already active, create it if not ===
if ! hyprctl monitors | grep -q "$VIRTUAL_MONITOR"; then
  echo "[wayvnc] Creating $VIRTUAL_MONITOR dynamically..."
  hyprctl output create headless $VIRTUAL_MONITOR
  sleep 0.5
fi

# === Assign workspace and activate it ===
echo "[wayvnc] Moving workspace $VIRTUAL_WORKSPACE to $VIRTUAL_MONITOR..."
hyprctl dispatch moveworkspacetomonitor $VIRTUAL_WORKSPACE $VIRTUAL_MONITOR
sleep 0.2
hyprctl dispatch workspace $VIRTUAL_WORKSPACE
sleep 0.2

# === Return focus to your real monitor so you don't get stuck on the headless one ===
hyprctl dispatch focusmonitor "$REAL_MONITOR"

# === Start WayVNC ===
echo "[wayvnc] Starting WayVNC on $VIRTUAL_MONITOR..."
wayvnc 0.0.0.0 5900 "$VIRTUAL_MONITOR"
