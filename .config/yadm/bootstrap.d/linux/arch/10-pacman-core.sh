#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${REPO_ROOT:?REPO_ROOT not set}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/common.sh"

AUR_HELPER=$(check_aur_helper)
mapfile -t INSTALLED < <(get_installed)

log "Installing core packages..."

CORE_PKGS=(
  base-devel
  python
  python-pip
  plocate
  wget
  curl
  unzip
  udisks2
  udiskie
  gvfs
  tumbler
  polkit
  polkit-gnome
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
  networkmanager
  pavucontrol
  pamixer
  brightnessctl
  playerctl
  grim
  wl-clipboard
  libnotify
  swaync
  xsettingsd
)

while IFS= read -r pkg; do
  [[ -n "$pkg" ]] && CORE_PKGS+=("$pkg")
done < <(read_packages "$REPO_ROOT/packages/core.txt")

install_packages "${CORE_PKGS[@]}"

log "Enabling NetworkManager..."
sudo systemctl enable --now NetworkManager
