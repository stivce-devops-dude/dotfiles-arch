#!/bin/bash
set -euo pipefail

# Script to restructure dotfiles-arch into main + gaming branches
# Run this from /home/sn0w/Projects/dotfiles-arch

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$REPO_DIR"

echo "=== Dotfiles-arch Branch Restructuring ==="
echo ""

GAMING_FILES=(
    ".local/bin/battlenet"
    ".local/bin/fuzzel-launcher"
    ".local/share/applications/battlenet.desktop"
    ".config/yadm/bootstrap.d/linux/arch/15-gaming.sh"
    "install-gaming"
)

echo "Step 1: Rename main to minimal..."
git branch -m main minimal

echo "Step 2: Create gaming branch..."
git checkout --orphan gaming

echo "Step 3: Add gaming-only files..."
for f in "${GAMING_FILES[@]}"; do
    if [ -e "$f" ]; then
        git add "$f"
        echo "  + $f"
    else
        echo "  - $f (not found)"
    fi
done

echo "Step 4: Commit gaming branch..."
git commit -m "Gaming branch - gaming-specific configs only"

echo "Step 5: Switch back to minimal..."
git checkout minimal

echo "Step 6: Remove gaming files from minimal..."
for f in "${GAMING_FILES[@]}"; do
    if [ -e "$f" ]; then
        rm -rf "$f"
        echo "  - $f"
    fi
done

echo "Step 7: Commit minimal branch..."
git commit -m "Minimal branch - base Arch config without gaming"

echo ""
echo "=== DONE ==="
echo ""
echo "Branches created:"
echo "  - minimal  : base Arch config"
echo "  - gaming  : gaming-specific configs"
echo ""
echo "To push to remote:"
echo "  git push origin minimal gaming"
