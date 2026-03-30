#!/usr/bin/env zsh
# test-zshrc.zsh — validate zsh configs load without errors
set -euo pipefail

export HOME="${HOME:-/root}"
export TERM=xterm-256color
export XDG_CONFIG_HOME="$HOME/.config"

# Source .zshrc and check for errors
if [[ -f "$HOME/.zshrc" ]]; then
  echo "Sourcing .zshrc..."
  emulate zsh -c "source $HOME/.zshrc" || {
    echo "ERROR: .zshrc failed to source"
    exit 1
  }
else
  echo "WARN: .zshrc not found"
fi

# Test each zshrc.d file
ZSHRC_D="$HOME/.config/zshrc.d"
if [[ -d "$ZSHRC_D" ]]; then
  for f in "$ZSHRC_D"/*.zsh; do
    [[ -f "$f" ]] || continue
    echo "Testing: $f"
    emulate zsh -c "source $f" || {
      echo "ERROR: $f failed to source"
      exit 1
    }
  done
fi

echo "All tests passed."
