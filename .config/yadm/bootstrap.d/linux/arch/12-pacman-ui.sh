#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${REPO_ROOT:?REPO_ROOT not set}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/common.sh"

AUR_HELPER=$(check_aur_helper)
mapfile -t INSTALLED < <(get_installed)

log "Installing UI packages..."

UI_PKGS=(
  hyprland
  hyprlock
  waybar
  fuzzel
  awww
  hyprshot
  hyprpanel
  matugen
  kitty
  ttf-jetbrains-mono-nerd
  noto-fonts
  noto-fonts-emoji
  whitesur-icon-theme
  whitesur-gtk-theme
  graphite-gtk-theme
  nwg-look
)

install_packages "${UI_PKGS[@]}"
