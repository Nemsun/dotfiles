# ~/.config/fish/config.fish — TUYU

# ── PATH / Homebrew ─────────────────────────────────────────────────
# The zsh->fish paper cut, handled: brew shellenv sets PATH and friends
# in fish syntax automatically.
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# ── Quality of life ─────────────────────────────────────────────────
set -g fish_greeting ""          # no "Welcome to fish" banner

# ── TUYU syntax highlighting ────────────────────────────────────────
# fish colors commands as you type; map that to the palette.
set -g fish_color_command        a8d4d2        # Mist Teal
set -g fish_color_param          d8e8e2        # Fog White
set -g fish_color_quote          f8d66c        # Umbrella Yellow
set -g fish_color_error          f6b4c9        # Hydrangea Pink
set -g fish_color_comment        7ca8c7        # Rain Blue
set -g fish_color_operator       b9a8e8        # Lavender
set -g fish_color_redirection    b9a8e8        # Lavender
set -g fish_color_autosuggestion 506c88        # muted navy (bright black)
set -g fish_color_valid_path     --underline

# ── Prompt (next step) ─────────────────────────────────────────────
# Safe no-op until starship is installed; activates automatically after.
if type -q starship
    starship init fish | source
end