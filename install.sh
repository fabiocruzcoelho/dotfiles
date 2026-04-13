#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "🚀 Iniciando setup..."

# Detectar OS
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  OS=$ID
else
  echo "❌ Não foi possível detectar o OS"
  exit 1
fi

echo "🖥️ Sistema: $OS"

# Dependências base
echo "📦 Instalando dependências..."

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

for pkg in git curl zsh eza duf bat fd-find tldr direnv httpie btop; do
  if ! command -v $pkg >/dev/null 2>&1; then
    echo "➡️ Instalando $pkg..."
    sudo apt install -y $pkg
  else
    echo "✅ $pkg já instalado"
  fi
done

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🎨 Instalando Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh já instalado"
fi

# Plugins
echo "🔌 Instalando plugins..."

clone_if_not_exists() {
  local repo=$1
  local dest=$2

  if [ ! -d "$dest" ]; then
    echo "➡️ Clonando $repo..."
    git clone "$repo" "$dest"
  else
    echo "✅ Já existe: $dest"
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
  echo "🔍 Instalando fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
else
  echo "✅ fzf já instalado"
fi

# Starship
if ! command -v starship >/dev/null 2>&1; then
  echo "🚀 Instalando Starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- -y
else
  echo "✅ Starship já instalado"
fi

# mise
if ! command -v mise >/dev/null 2>&1; then
  echo "🧰 Instalando mise..."
  curl https://mise.run | sh
else
  echo "✅ mise já instalado"
fi

# Mise install (tools globais)
if command -v mise >/dev/null 2>&1; then
  echo "📦 Instalando ferramentas via mise..."

  # garante trust
  mise trust "$DOTFILES_DIR/mise/config.toml" 2>/dev/null || true
  mise install
else
  echo "⚠️ mise não encontrado"
fi

# Função DRY de symlink
link_file() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  # se já está correto, ignora
  if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$src" ]; then
    echo "✅ Já linkado: $dest"
    return
  fi

  echo "🔗 Linking: $dest → $src"
  ln -sf "$src" "$dest"
}

# Symlinks
echo "🔗 Criando symlinks..."

declare -A FILES=(
  ["$DOTFILES_DIR/zsh/.zshrc"]="$HOME/.zshrc"
  ["$DOTFILES_DIR/starship/starship.toml"]="$HOME/.config/starship.toml"
  ["$DOTFILES_DIR/mise/config.toml"]="$HOME/.config/mise/config.toml"
)

for src in "${!FILES[@]}"; do
  link_file "$src" "${FILES[$src]}"
done

# Shell padrão
CURRENT_SHELL=$(basename "$SHELL")

if [[ "$CURRENT_SHELL" != "zsh" ]]; then
  echo "🔁 Alterando shell padrão para zsh..."
  chsh -s "$(which zsh)"
else
  echo "✅ Shell já é zsh"
fi

echo ""
echo "✅ Setup concluído!"