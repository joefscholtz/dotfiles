#!/usr/bin/env bash

# 1. Setup
TEMP_DIR="/tmp/rofi_screenshots"
mkdir -p "$TEMP_DIR"
rm -f "$TEMP_DIR"/*.png

# 2. Get Monitors
MONITORS=$(hyprctl -j monitors | jq -r '.[] | .name')
COUNT=$(hyprctl monitors -j | jq 'length')

# 3. Build Input
# Format: Name\0icon\x1fPath
# We bypass Bash variable limitations by writing to a file
ROFI_INPUT_FILE="$TEMP_DIR/input.txt"
>"$ROFI_INPUT_FILE"

for MON in $MONITORS; do
  THUMB="$TEMP_DIR/$MON.png"
  # Take raw screenshot
  grim -o "$MON" "$THUMB"
  # Write metadata to file
  printf "%s\0icon\x1f%s\n" "$MON" "$THUMB" >>"$ROFI_INPUT_FILE"
done

# 4. Launch Rofi
# We override your config.rasi window size temporarily to fit the previews
SELECTION=$(rofi -dmenu -i -p "󰹑" \
  -input "$ROFI_INPUT_FILE" \
  -theme-str '
        mainbox { 
          children: [ "listview" ];
          spacing: 0px;
          padding: 5px;
        }

        window { 
          width: 1000px;
          height: 340px;
        }
        listview { 
            columns: '$COUNT'; 
            spacing: 10px; 
            fixed-columns: true;
        }

        element { 
            orientation: vertical; 
            spacing: 0px;
            padding: 0px; 
            children: [ "element-icon", "element-text" ]; 
        }

        element-icon { 
          size: 300px;
            spacing: 0px;
            padding: 0px; 
          border-radius: 0px;
          horizontal-align: 0.5; 
        }
        element-text { 
            vertical-align: 0.5; 
            horizontal-align: 0.5; 
            font: "JetBrainsMono Nerd Font Bold 12"; 
        }
    ')

# 5. Take high-quality screenshot
if [ -n "$SELECTION" ]; then
  # Ensure we only have the monitor name
  MON_NAME=$(echo "$SELECTION" | xargs)
  sleep 0.5
  hyprshot -m output -m "$MON_NAME" --silent
fi
