#!/usr/bin/env bash
# $CONFIG_DIR is exported by sketchybar to all plugin scripts
source "$CONFIG_DIR/colors.sh"
export PATH="/opt/homebrew/bin:$PATH"

SID="$1"
ICON_MAP="$CONFIG_DIR/plugins/icon_map.sh"

# front_app_switched (and other non-aerospace events) don't carry the
# FOCUSED_WORKSPACE env var — query it so the highlight never drops.
FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"

# --- Apps on this workspace -> icon ligatures via sketchybar-app-font ---
APPS=()
while IFS= read -r app; do
  [ -n "$app" ] && APPS+=("$app")
done <<< "$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null | sort -u)"

ICONS=""
if [ ${#APPS[@]} -gt 0 ] && [ -x "$ICON_MAP" ]; then
  # Batch lookup: returns space-separated ligatures in argument order
  ICONS="$("$ICON_MAP" "${APPS[@]}")"
fi

# --- Focused highlight: color the number + app icons, no background fill ---
if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
  NUM="$UMBRELLA_YELLOW"; APPCOLOR="$UMBRELLA_YELLOW"
else
  NUM="$MIST_TEAL"; APPCOLOR="$MIST_TEAL"
fi

if [ -n "$ICONS" ]; then
  sketchybar --set "$NAME" background.color="$TRANSPARENT" icon.color="$NUM" \
             label.drawing=on label="$ICONS" label.color="$APPCOLOR"
else
  sketchybar --set "$NAME" background.color="$TRANSPARENT" icon.color="$NUM" \
             label.drawing=off
fi