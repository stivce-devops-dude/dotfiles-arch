#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${REPO_ROOT:?REPO_ROOT not set}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/common.sh"

AUR_HELPER=$(check_aur_helper)
mapfile -t INSTALLED < <(get_installed)

log "Installing development packages..."

DEV_PKGS=(
  base-devel
  python3
  python-pip
  go
  rust
  nodejs
  npm
  git
  lazygit
  fzf
  ripgrep
  fd
  bat
  exa
  zoxide
  unzip
  zip
)

install_packages "${DEV_PKGS[@]}"
