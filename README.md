# dotfiles-arch

Arch Linux-specific dotfiles managed with yadm.

## CI Jobs

| CI Job | Description |
|--------|-------------|
| **Lint** — bash/zsh syntax validation | [![Lint](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/test.yml/badge.svg?job=lint)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/test.yml) |
| **Test Arch** — deploy & integration | [![Test Arch](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/test.yml/badge.svg?job=test-arch)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/test.yml) |

## Setup

```bash
yadm clone git@github.com:stivce-devops-dude/dotfiles-arch.git
yadm bootstrap
```

## What's Included

- Hyprland + Wayland config
- Fuzzel launcher
- GTK/Qt theming (WhiteSur, Graphite)
- Gaming setup (UMU, Wine, etc.)

## Bootstrap Scripts

| Script | Description |
|--------|-------------|
| `.config/yadm/bootstrap` | Main bootstrap - runs common then Arch-specific steps |
| `.config/yadm/bootstrap.d/linux/00-distro` | Linux distribution detection |
| `.config/yadm/bootstrap.d/linux/arch/10-pacman-core.sh` | Installs core packages from `packages/core.txt` |
| `.config/yadm/bootstrap.d/linux/arch/11-pacman-dev.sh` | Development tools (docker, kubectl, terraform, etc.) |
| `.config/yadm/bootstrap.d/linux/arch/12-pacman-ui.sh` | UI packages (Hyprland, waybar, fuzzel, kitty, themes) |
| `.config/yadm/bootstrap.d/linux/arch/13-pacman-desktop.sh` | Desktop environment packages |
| `.config/yadm/bootstrap.d/linux/arch/14-pacman-extras.sh` | Extra packages (fonts, utils) |
| `.config/yadm/bootstrap.d/linux/arch/15-gaming.sh` | Gaming packages (umu-launcher, wine, gamescope) |

## Dependencies

Requires the general dotfiles repo to be cloned at `~/dotfiles` for shared packages.
