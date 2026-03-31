#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="${REPO_ROOT:?REPO_ROOT not set}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/lib/common.sh"

has_dgpu() {
    if lspci 2>/dev/null | grep -qiE 'vga|3d.*controller.*nvidia|geforce|radeon|rx\s'; then
        return 0
    fi
    if command -v nvidia-smi &>/dev/null && nvidia-smi &>/dev/null; then
        return 0
    fi
    return 1
}

if ! has_dgpu; then
    log "No dedicated GPU detected. Skipping gaming packages."
    return 0
fi

log "Dedicated GPU detected. Installing gaming packages..."

if [[ -f "$REPO_ROOT/install-gaming" ]]; then
    log "Running gaming setup script..."
    chmod +x "$REPO_ROOT/install-gaming"
    if [[ ${EUID:-0} -eq 0 ]] && [[ -n "${SUDO_USER:-}" ]]; then
        sudo -u "$SUDO_USER" bash "$REPO_ROOT/install-gaming"
    else
        bash "$REPO_ROOT/install-gaming"
    fi
else
    warn "install-gaming script not found"
fi
