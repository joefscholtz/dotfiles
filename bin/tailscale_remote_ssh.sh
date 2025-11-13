#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_PORT="5900"
DESTINATION_HOST="localhost"
DESTINATION_PORT="5900"
DESTINATION_USER="joe"
# This is now just a placeholder
DESTINATION_PUBLIC_IP=""
USE_HEADER="false"

if [[ "$USE_HEADER" == "true" ]]; then
  DEVICES_RAW=$(tailscale status --header --self=false | grep -v "#" | grep -v "^$")

  HEADER=$(echo "$DEVICES_RAW" | awk 'NR == 1 {printf "%s %s", $2, $1}')
  FORMATTED_LIST=$(echo "$DEVICES_RAW" | awk 'NR > 2 {printf "%-15s %s\n", $2, $1}')

  SELECTED_LINE=$(echo "$FORMATTED_LIST" | gum filter --header "$HEADER")
else
  DEVICES_RAW=$(tailscale status --self=false | grep -v "#" | grep -v "^$")

  FORMATTED_LIST=$(echo "$DEVICES_RAW" | awk '{printf "%-15s %s\n", $2, $1}')

  SELECTED_LINE=$(echo "$FORMATTED_LIST" | gum filter --header "Hostname IP")
fi

SELECTED_IP=$(echo "$SELECTED_LINE" | awk '{print $2}')
SELECTED_HOST=$(echo "$SELECTED_LINE" | awk '{print $1}')

if [[ -z "$SELECTED_IP" || "$SELECTED_IP" == "IP" ]]; then
  echo "No device selected. Exiting."
  exit 1
fi

DESTINATION_PUBLIC_IP="$SELECTED_IP"

gum spin --spinner dot --title "Connecting at $DESTINATION_USER@$SELECTED_HOST with IP $DESTINATION_PUBLIC_IP" -- sleep 2

ssh -L "$LOCAL_PORT:$DESTINATION_HOST:$DESTINATION_PORT" "$DESTINATION_USER@$DESTINATION_PUBLIC_IP"
