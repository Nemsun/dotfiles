#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

volume_change() {
  case $INFO in
    [6-9][0-9] | 100) ICON="󰕾" ;;
    [3-5][0-9])       ICON="󰖀" ;;
    [1-9] | [1-2][0-9]) ICON="󰕿" ;;
    0)                ICON="󰝟" ;;
    *)                ICON="󰕾" ;;
  esac
  sketchybar --set volume_icon icon="$ICON" label="$INFO%" \
             --set "$NAME" slider.percentage="$INFO"
}

case "$SENDER" in
  "volume_change") volume_change ;;
  "mouse.clicked")  osascript -e "set volume output volume $PERCENTAGE" ;;
  # Slider hover keeps itself open (icon->slider transition).
  # padding_left only exists while expanded so the collapsed slider
  # stays zero-width but the open track doesn't touch the pill border.
  "mouse.entered")  sketchybar --animate tanh 20 --set volume_slider slider.width=100 padding_left=10 ;;
  "mouse.exited")   sketchybar --animate tanh 20 --set volume_slider slider.width=0 padding_left=0 ;;
esac