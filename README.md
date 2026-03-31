# dotfiles-arch

Arch Linux-specific dotfiles managed with [yadm](https://yadm.io/).

## CI Jobs

| CI Job | Description |
|--------|-------------|
| **Lint** — bash/zsh syntax + shellcheck | [![Lint](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/lint.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/lint.yml) |
| **Config Validation** — verify configs | [![Config Validation](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/config-validation.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/config-validation.yml) |
| **Bootstrap** — dry-run bootstrap test | [![Bootstrap](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/bootstrap.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/bootstrap.yml) |
| **Test Arch** — deploy & integration | [![Test Arch](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/test-arch.yml/badge.svg)](https://github.com/stivce-devops-dude/dotfiles-arch/actions/workflows/test-arch.yml) |
| **Package Availability** — verify packages in pacman | |

## Setup

```bash
# Default: minimal (base config only)
yadm clone git@github.com:stivce-devops-dude/dotfiles-arch.git
yadm bootstrap

# With gaming additions
DOTFILES_INCLUDE_GAMING=1 yadm bootstrap
```

## Branches

| Branch | Files | Description |
|--------|-------|-------------|
| `minimal` (default) | ~60 | Base Arch config |
| `gaming` | ~5 | Gaming additions only |

The `gaming` branch is applied on top of `minimal` when `DOTFILES_INCLUDE_GAMING=1`.

## What's Included

- **Window Manager**: Hyprland + Wayland
- **App Launcher**: Fuzzel
- **Themes**: GTK (WhiteSur, Graphite), Qt
- **Terminal**: kitty
- **Development**: go, rust, nodejs, lazygit, fzf, ripgrep

## Bootstrap Scripts

| Script | Description |
|--------|-------------|
| `.config/yadm/bootstrap` | Main bootstrap |
| `bootstrap.d/linux/00-distro` | Linux distribution detection |
| `bootstrap.d/linux/arch/10-pacman-core.sh` | Core packages |
| `bootstrap.d/linux/arch/11-pacman-dev.sh` | Development packages |
| `bootstrap.d/linux/arch/12-pacman-ui.sh` | UI packages |
| `bootstrap.d/linux/arch/13-pacman-desktop.sh` | Desktop packages |
| `bootstrap.d/linux/arch/14-pacman-extras.sh` | Extra packages |
| `bootstrap.d/linux/arch/15-gaming.sh` | Gaming packages |

## Package Lists

| File | Description |
|------|-------------|
| `packages/core.txt` | Core system packages |
| `packages/dev.txt` | Development packages |
| `packages/ui.txt` | UI/desktop packages |
| `packages/desktop.txt` | Desktop applications |
| `packages/gaming.txt` | Gaming packages |
| `packages/extras.txt` | Extra packages |

## Dependencies

Requires the general dotfiles repo for shared packages.
