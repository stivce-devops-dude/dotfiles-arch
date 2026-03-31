# dotfiles-arch

Arch Linux-specific dotfiles managed with yadm.

## CI Jobs

| CI Job | Badge |
|--------|-------|
| **Lint** — bash/zsh syntax validation | [![Lint](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/lint.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/lint.yml) |
| **Config Validation** — Hyprland, Fuzzel, gaming | [![Config Validation](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/config-validation.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/config-validation.yml) |
| **Package Availability** — verify packages in pacman | [![Package Availability](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/package-availability.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/package-availability.yml) |
| **Bootstrap** — dry-run bootstrap test | [![Bootstrap](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/bootstrap.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/bootstrap.yml) |
| **Test Arch** — deploy & integration | [![Test Arch](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/test-arch.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/test-arch.yml) |

## Setup

```bash
# Minimal (base config only)
yadm clone git@github.com:stivce-devops-dude/dotfiles-arch.git --branch minimal
yadm bootstrap

# Or with gaming additions
DOTFILES_INCLUDE_GAMING=1 yadm bootstrap
```

## Branches

| Branch | Files | Description |
|--------|-------|-------------|
| `minimal` | ~60 | Base Arch config (Hyprland, kitty, dev tools, desktop) |
| `gaming` | ~5 | Gaming additions only (battlenet, wine, umu) |

The `gaming` branch is designed to be applied on top of `minimal` by setting `DOTFILES_INCLUDE_GAMING=1`.

## What's Included (minimal)

- Hyprland + Wayland config
- Fuzzel app launcher
- GTK/Qt theming (WhiteSur, Graphite)
- Development tools

## What's Included (gaming)

- Battle.net launcher
- UMU/Wine setup
- Gaming-specific bootstrap script

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
