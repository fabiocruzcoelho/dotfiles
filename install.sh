#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "scripts/common.sh"
source "scripts/setup.sh"
source "scripts/zsh.sh"
source "scripts/symlinks.sh"
read -p "Overwrite existing dotfiles? [y/n] " overwrite_dotfiles

# Backup do arquivo zsh existente.
if [[ -e "$HOME/.zshrc" ]]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

if [[ "$overwrite_dotfiles" == "y" ]]; then
    log_warn "Deleting existing dotfiles..."
    ./scripts/symlinks.sh --delete --include-files
fi
./scripts/symlinks.sh --create
