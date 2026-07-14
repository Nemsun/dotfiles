# ☂ TUYU dotfiles

Rainy-day macOS rice inspired by [TUYU](https://en.wikipedia.org/wiki/Tuyu_(band))'s
*It's Raining After All*. Deep midnight blues, mist teal, and one umbrella yellow
accent, carried through every layer of the desktop.

> *it's raining after all*

![desktop](assets/screenshot.png)

## Palette

| | Name | Hex |
|---|---|---|
| 🌑 | Deep Midnight Blue | `#08284a` |
| 🌊 | Rainy Navy | `#163b61` |
| 🌧 | Rain Blue | `#7ca8c7` |
| 🍃 | Mist Teal | `#a8d4d2` |
| ☁️ | Fog White | `#d8e8e2` |
| 💜 | Lavender | `#b9a8e8` |
| 🌸 | Hydrangea Pink | `#f6b4c9` |
| ☂ | Umbrella Yellow | `#f8d66c` |

## The stack

| Layer | Tool | Notes |
|---|---|---|
| Window manager | [AeroSpace](https://github.com/nikitabobko/AeroSpace) | 5 workspaces: desktop (floating) · Spotify · VSCode · Ghostty · browser |
| Status bar | [SketchyBar](https://github.com/FelixKratz/SketchyBar) | Three-pill layout, notch-aware Spotify title, hover volume slider |
| Terminal | [Ghostty](https://ghostty.org) | Full TUYU ANSI palette, blur + translucency |
| Multiplexer | tmux | `rice-session.sh`: fastfetch art pane + working shell |
| Shell | [fish](https://fishshell.com) | TUYU syntax highlighting |
| Prompt | [Starship](https://starship.rs) | ☂ prompt — teal on success, pink on failure |
| Fetch | [fastfetch](https://github.com/fastfetch-cli/fastfetch) | Boxed layout, kitty-direct PNG art |
| Editor | VSCode | Theme via settings overrides (see `vscode/`) |
| Font | Maple Mono NF | Plus [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font) for app glyphs |

## Install

```sh
# Dependencies
brew install --cask nikitabobko/tap/aerospace ghostty font-sketchybar-app-font
brew install sketchybar fastfetch tmux fish starship jq
brew tap FelixKratz/formulae   # for sketchybar, if needed

# Clone + symlink
git clone https://github.com/Nemsun/dotfiles ~/dotfiles
cd ~/dotfiles
brew install stow
stow sketchybar aerospace tmux fastfetch ghostty fish starship
```

VSCode: merge `vscode/settings.json` into your user settings
(`Cmd+Shift+P` → *Preferences: Open User Settings (JSON)*).

### Post-install (things symlinks can't carry)

- **fish as login shell:**
  `echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells && chsh -s /opt/homebrew/bin/fish`
- **Services:** `brew services start sketchybar`, launch AeroSpace once
  (it starts at login per config)
- **Permissions:** macOS will prompt for Automation (sketchybar → Spotify)
  on first use — approve it
- **Fonts:** Maple Mono NF from `brew install --cask font-maple-mono-nf`

## Layout

```
dotfiles
├── aerospace/     window manager · workspace rules · keybinds
├── sketchybar/    bar config + plugins (calendar, volume, spotify, battery, workspaces)
├── ghostty/       terminal theme
├── tmux/          multiplexer config + rice session script
├── fastfetch/     fetch config + artwork
├── fish/          shell config
├── starship/      prompt
└── vscode/        editor settings (applied manually)
```

## Keybinds worth remembering

| Keys | Action |
|---|---|
| `⌥ 1-5` | Switch workspace |
| `⌥⇧ 1-5` | Move window to workspace |
| `⌥ h/j/k/l` | Focus window |
| `⌥ f` | Fullscreen (workspace-native) |
| `⌥⇧ ;` | Service mode (esc reloads config) |
| `Ctrl-b` then `h/l` | tmux pane focus |

## Credits

- [FelixKratz](https://github.com/FelixKratz/dotfiles) — sketchybar patterns
- [kvndrsslr/sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font) — app glyphs
- TUYU — the palette's soul ☂