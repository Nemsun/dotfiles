#!/bin/bash
# ~/.config/tmux/rice-session.sh
# One window, two panes — fastfetch LEFT, working shell RIGHT:
#  ┌──────────────┬─────────────┐
#  │  fastfetch   │    shell    │
#  └──────────────┴─────────────┘
export PATH="/opt/homebrew/bin:$PATH"

SESSION="rice"

if tmux has-session -t "$SESSION" 2>/dev/null; then
  exec tmux attach -t "$SESSION"
fi

tmux new-session -d -s "$SESSION" -n main
# New pane opens on the right = working shell; original left = fastfetch
tmux split-window -h -t "$SESSION:main"
# Fastfetch pane: 95 cols fits image (36) + padding (8) + boxes (48)
tmux resize-pane -t "$SESSION:main.{left}" -x 60

tmux send-keys -t "$SESSION:main.{left}" 'clear && fastfetch' C-m
tmux select-pane -t "$SESSION:main.{right}"

exec tmux attach -t "$SESSION"