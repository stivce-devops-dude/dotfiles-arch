#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${REPO_ROOT:?REPO_ROOT not set}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/common.sh"

AUR_HELPER=$(check_aur_helper)
mapfile -t INSTALLED < <(get_installed)

log "Installing desktop packages..."

DESKTOP_PKGS=(
  nautilus
  zen-browser
  mpv
  imv
  wdisplays
  swappy
)

install_packages "${DESKTOP_PKGS[@]}"
