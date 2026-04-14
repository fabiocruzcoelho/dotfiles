#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "scripts/common.sh"

echo -e "
         _ ._  _ , _ ._
        (_ ' ( \`  )_  .__)
      ( (  (    )   \`)  ) _)
     (__ (_   (_ . _) _) ,__)
           ~~\ ' . /~~
         ,::: ;   ; :::,
        ':::::::::::::::'
 ____________/_ __ \____________
|                               |
|  Welcome to @fabio dotfiles   |
|_______________________________|
"
# Detectar OS
if [[ -f /etc/os-release ]]; then
  . /etc/os-release
  OS=$ID
else
  log_info "Não foi possível detectar o OS"
  exit 1
fi

log_info "🖥️ Sistema Operacional: $OS"

log_info "Este script irá apagar todos os seus arquivos de configuração.!"
log_info "Use por sua conta e risco."

if [ $# -ne 1 ] || [ "$1" != "-y" ]; then
  log_warn "Pressione a tecla Enter para continuar…\n"
  read key
fi

log_info "Instalando dependências..."

sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

for pkg in git curl zsh eza duf bat fd-find tldr direnv httpie btop; do
  if ! command -v $pkg >/dev/null 2>&1; then
    log_info "Instalando $pkg..."
    sudo apt install -y $pkg
  else
    log_info "$pkg já está instalado"
  fi
done