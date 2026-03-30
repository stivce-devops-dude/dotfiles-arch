#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${REPO_ROOT:?REPO_ROOT not set}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/common.sh"

AUR_HELPER=$(check_aur_helper)
mapfile -t INSTALLED < <(get_installed)

log "Installing extra packages..."

EXTRA_PKGS=(
  localsend
)

install_packages "${EXTRA_PKGS[@]}"

if command -v opencode &>/dev/null; then
  log "opencode already installed"
else
  log "Installing opencode..."
  TMP_FILE=$(mktemp)
  curl -fsSL https://opencode.ai/install -o "$TMP_FILE"
  chmod +x "$TMP_FILE"
  if [[ ${EUID:-0} -eq 0 ]] && [[ -n "${SUDO_USER:-}" ]]; then
    sudo -u "$SUDO_USER" "$TMP_FILE"
  else
    "$TMP_FILE"
  fi
  rm -f "$TMP_FILE"
fi
