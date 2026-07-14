#!/bin/bash
export PATH="/opt/homebrew/bin:$PATH"

# Quit/dying Spotify still fires events; never osascript on those paths
# or AppleScript will RELAUNCH the app.
if ! pgrep -xq "Spotify"; then
  sketchybar --set media.title label="Nothing playing"
  exit 0
fi

# Fast path: the event payload carries the state (requires jq)
STATE=$(echo "$INFO" | jq -r '."Player State" // empty' 2>/dev/null)
TRACK=$(echo "$INFO" | jq -r '.Name // empty' 2>/dev/null)
ARTIST=$(echo "$INFO" | jq -r '.Artist // empty' 2>/dev/null)

if [ -z "$STATE" ]; then
  if [ "$SENDER" = "spotify_change" ]; then
    # Event fired but payload unreadable (jq missing, or quit event) —
    # do NOT fall back to osascript here: if Spotify is mid-quit,
    # the AppleScript would resurrect it. Skip quietly.
    exit 0
  fi
  # Non-event run (bar load / manual): one osascript read is safe,
  # since Spotify passed the pgrep check and nothing is mid-quit.
  IFS=$'\t' read -r STATE TRACK ARTIST <<< "$(osascript <<'APPLESCRIPT'
tell application "Spotify"
  set s to player state as string
  set t to name of current track
  set a to artist of current track
  return s & tab & t & tab & a
end tell
APPLESCRIPT
)"
fi

# "Stopped" is what the quit-event reports — show idle state
if [ "$STATE" = "Stopped" ] || [ "$STATE" = "stopped" ]; then
  sketchybar --set media.title label="Nothing playing"
  exit 0
fi

[ -n "$TRACK" ] && sketchybar --set media.title label="$TRACK — $ARTIST"