# dotfiles-arch

Arch Linux-specific dotfiles. Managed as a bare git repo.

## Setup

```bash
git clone --bare git@github.com:stivce-devops-dude/dotfiles-arch.git ~/.dotfiles-os
git --git-dir=$HOME/.dotfiles-os --work-tree=$HOME checkout
```

Add to your shell profile:

```bash
alias dot-os='git --git-dir=$HOME/.dotfiles-os --work-tree=$HOME'
dot-os config status.showUntrackedFiles no
```

## What's included

- **Hyprland** — `.config/hypr/` (compositor, lock screen, panel, wallpaper)
- **Bar** — `.config/waybar/` (config, styling)
- **Launcher** — `.config/fuzzel/fuzzel.ini`
- **Notifications** — `.config/swaync/` (config, styling)
- **Theming** — `.config/gtk-*/`, `.config/qt5ct/`, `.config/qt6ct/`, `.config/matugen/`
- **Scripts** — `.local/bin/` (fuzzel-launcher, powermenu, vm, battlenet, btop, nw-manager, volume-control, gemini, swww, zen-apply-prefs)
- **Zen Browser** — `.config/zen/user.js` (dark mode, 1.5x UI scale)
- **Misc** — `.config/xsettingsd/`, `Pictures/wallpapers/`

## Usage

```bash
dot-os add ~/.config/hypr/hyprland/binds.conf
dot-os commit -m "update hyprland keybinds"
dot-os push
```

## Related repos

- [dotfiles](https://github.com/stivce-devops-dude/dotfiles) — Shared dotfiles (zsh, nvim, starship, kitty base, git)
- [os-configuration](https://github.com/stivce-devops-dude/os-configuration) — Ansible playbook for package management and system setup
