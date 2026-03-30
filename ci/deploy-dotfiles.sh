#!/usr/bin/env bash
# deploy-dotfiles.sh — simulates yadm alt for CI environments
set -euo pipefail
shopt -s nullglob nocaseglob

PLATFORM="${1:?Usage: deploy-dotfiles.sh <linux-arch>}"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

deploy() {
  local src="$1" dest="$2"
  [[ -z "$src" ]] && return 0
  [[ "$src" -ef "$dest" ]] && return 0
  if [[ -d "$HOME" ]]; then
    local real_dest
    real_dest=$(realpath -m "$dest" 2>/dev/null) || true
    if [[ -n "$real_dest" && "$real_dest" != "$HOME"* ]]; then
      echo "ERROR: Destination outside HOME: $dest" >&2
      return 1
    fi
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  echo "  deployed: $dest"
}

echo "==> Deploying dotfiles for platform: $PLATFORM"

# .config/hypr/
for f in "$REPO_ROOT/.config/hypr"/*.conf; do
  [[ -f "$f" ]] || continue
  fname="$(basename "$f")"
  mkdir -p "$HOME/.config/hypr"
  deploy "$f" "$HOME/.config/hypr/$fname"
done

# .config/hypr/hyprland/
for d in "$REPO_ROOT/.config/hypr"/hyprland; do
  [[ -d "$d" ]] || continue
  mkdir -p "$HOME/.config/hypr/hyprland"
  for f in "$d"/*.conf; do
    [[ -f "$f" ]] || continue
    fname="$(basename "$f")"
    deploy "$f" "$HOME/.config/hypr/hyprland/$fname"
  done
done

# .config/fuzzel/
if [[ -d "$REPO_ROOT/.config/fuzzel" ]]; then
  mkdir -p "$HOME/.config/fuzzel"
  deploy "$REPO_ROOT/.config/fuzzel/fuzzel.ini" "$HOME/.config/fuzzel/fuzzel.ini"
fi

# .local/bin/
mkdir -p "$HOME/.local/bin"
for f in "$REPO_ROOT/.local/bin"/*; do
  [[ -f "$f" ]] || continue
  fname="$(basename "$f")"
  deploy "$f" "$HOME/.local/bin/$fname"
done

# .local/share/applications/
mkdir -p "$HOME/.local/share/applications"
for f in "$REPO_ROOT/.local/share/applications"/*.desktop; do
  [[ -f "$f" ]] || continue
  fname="$(basename "$f")"
  deploy "$f" "$HOME/.local/share/applications/$fname"
done

echo "==> Deploy complete"
