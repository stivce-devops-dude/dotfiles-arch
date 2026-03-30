#!/usr/bin/env bash
set -euo pipefail

log() { printf '[INFO] %s\n' "$*"; }
warn() { printf '[WARN] %s\n' "$*" >&2; }
die() { printf '[ERROR] %s\n' "$*" >&2; exit 1; }

read_packages() {
  local file="$1"
  [[ -f "$file" ]] || return 0
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    echo "$line"
  done < "$file"
}

check_aur_helper() {
  if command -v yay &>/dev/null; then
    echo "yay"
  elif command -v paru &>/dev/null; then
    echo "paru"
  else
    die "No AUR helper found (yay or paru). Install one first."
  fi
}

get_installed() {
  pacman -Qq
}

is_installed() {
  local pkg="$1"
  for installed in "${INSTALLED[@]:-}"; do
    [[ "$installed" == "$pkg" ]] && return 0
  done
  return 1
}

install_packages() {
  local pkgs=("$@")
  [[ ${#pkgs[@]} -eq 0 ]] && return 0

  local pacman_pkgs=()
  local aur_pkgs=()
  local aur_bin_pkgs=()

  for pkg in "${pkgs[@]}"; do
    is_installed "$pkg" && continue
    is_installed "${pkg}-bin" && continue

    if pacman -Si "$pkg" &>/dev/null 2>&1; then
      pacman_pkgs+=("$pkg")
    elif $AUR_HELPER -Si "${pkg}-bin" &>/dev/null 2>&1; then
      aur_bin_pkgs+=("${pkg}-bin")
    else
      aur_pkgs+=("$pkg")
    fi
  done

  if [[ ${#pacman_pkgs[@]} -gt 0 ]]; then
    log "Installing pacman packages: ${pacman_pkgs[*]}"
    sudo pacman -S --needed --noconfirm "${pacman_pkgs[@]}"
  fi

  if [[ ${#aur_bin_pkgs[@]} -gt 0 ]]; then
    log "Installing AUR packages (bin): ${aur_bin_pkgs[*]}"
    install_aur "${aur_bin_pkgs[@]}"
  fi

  if [[ ${#aur_pkgs[@]} -gt 0 ]]; then
    log "Installing AUR packages: ${aur_pkgs[*]}"
    install_aur "${aur_pkgs[@]}"
  fi
}

install_aur() {
  local pkgs=("$@")
  [[ ${#pkgs[@]} -eq 0 ]] && return 0

  if [[ ${EUID:-0} -eq 0 ]] && [[ -n "${SUDO_USER:-}" ]]; then
    sudo -u "$SUDO_USER" "$AUR_HELPER" -S --needed --noconfirm "${pkgs[@]}"
  else
    "$AUR_HELPER" -S --needed --noconfirm "${pkgs[@]}"
  fi
}
