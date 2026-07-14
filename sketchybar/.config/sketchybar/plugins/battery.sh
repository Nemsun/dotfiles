#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

MODE_CACHE="/tmp/sketchybar_battery_mode"   # "time" or "pct"

BATT_INFO=$(pmset -g batt)
PERCENTAGE=$(echo "$BATT_INFO" | grep -Eo "[0-9]+%" | head -1 | tr -d '%')
CHARGING=$(echo "$BATT_INFO" | grep "AC Power")

# Click toggles between percentage and time-remaining display
if [ "$SENDER" = "mouse.clicked" ]; then
  if [ "$(cat "$MODE_CACHE" 2>/dev/null)" = "time" ]; then
    echo "pct" > "$MODE_CACHE"
  else
    echo "time" > "$MODE_CACHE"
  fi
fi

[ -z "$PERCENTAGE" ] && exit 0

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=""
  ;;
  [6-8][0-9]) ICON=""
  ;;
  [3-5][0-9]) ICON=""
  ;;
  [1-2][0-9]) ICON=""
  ;;
  *) ICON=""
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

if [ "$(cat "$MODE_CACHE" 2>/dev/null)" = "time" ]; then
  TIME_LEFT=$(echo "$BATT_INFO" | grep -Eo "[0-9]+:[0-9]+" | head -1)
  if [ -n "$CHARGING" ]; then
    LABEL="${TIME_LEFT:-–:–} to full"
  else
    LABEL="${TIME_LEFT:-–:–} left"
  fi
else
  LABEL="${PERCENTAGE}%"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"