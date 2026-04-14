#!/usr/bin/env bash

set -euo pipefail

CURRENT_SHELL=$(basename "$SHELL")
DOTFILES_DIR="$HOME/dotfiles"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# shellcheck disable=SC1091
source "scripts/common.sh"

if [[ "$CURRENT_SHELL" != "zsh" ]]; then
  log_info "Alterando shell padrão para zsh..."
  chsh -s "$(which zsh)"
else
  log_info "Shell já é zsh"
fi

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log_info "Instalando Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log_info "Oh My Zsh já está instalado"
fi

# Plugins
log_info "Instalando plugins..."

clone_if_not_exists() {
  local repo=$1
  local dest=$2

  if [ ! -d "$dest" ]; then
    log_info "Clonando $repo..."
    git clone "$repo" "$dest"
  else
    log_info "Já existe: $dest"
  fi
}

clone_if_not_exists \
  https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

clone_if_not_exists \
  https://github.com/zsh-users/zsh-syntax-highlighting \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# fzf
if [ ! -d "$HOME/.fzf" ]; then
  log_info "Instalando fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
else
  log_info "fzf já nstalado"
fi

# Starship
if ! command -v starship >/dev/null 2>&1; then
  log_info "Instalando Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  log_info "Starship já está instalado"
fi

# mise
if ! command -v mise >/dev/null 2>&1; then
  log_info "Instalando mise..."
  curl -sS https://mise.run | sh
else
  log_info "mise já está instalado"
fi

# Mise install (tools globais)
if command -v mise >/dev/null 2>&1; then
  log_info "Instalando ferramentas via mise..."

  # garante trust
  mise trust "$DOTFILES_DIR/mise/config.toml" 2>/dev/null || true
  mise install
else
  log_warn "mise não encontrado"
fi