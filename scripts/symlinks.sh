#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_FILE="$SCRIPT_DIR/../symlinks.conf"

# shellcheck disable=SC1091
source "scripts/common.sh"

log_info "Symbolic Links"
if [ ! -f "$CONFIG_FILE" ]; then
    log_error "Arquivo de configuração não encontrado: $CONFIG_FILE"
    exit 1
fi

create_symlinks() {
    log_info "Criando links simbólicos..."

    while IFS=: read -r source target || [ -n "$source" ]; do

        if [[ -z "$source" || -z "$target" || "$source" == \#* ]]; then
            continue
        fi

        source=$(eval echo "$source")
        target=$(eval echo "$target")

        if [ ! -e "$source" ]; then
            log_error "Erro: Arquivo de origem '$source' não encontrado. Pulando criação do link para '$target'."
            continue
        fi

        if [ -L "$target" ]; then
            log_warn "Já existe um link simbólico: $target"
        elif [ -f "$target" ]; then
            log_warn "O arquivo já existe.: $target"
        else
            target_dir=$(dirname "$target")

            if [ ! -d "$target_dir" ]; then
                mkdir -p "$target_dir"
                log_info "Created directory: $target_dir"
            fi

            ln -s "$source" "$target"
            log_info "Link simbólico criado:: $target"
        fi
    done <"$CONFIG_FILE"
}

delete_symlinks() {
    log_info "Excluindo links simbólicos..."

    while IFS=: read -r _ target || [ -n "$target" ]; do

        if [[ -z "$target" ]]; then
            continue
        fi

        target=$(eval echo "$target")

        if [ -L "$target" ] || { [ "$include_files" == true ] && [ -f "$target" ]; }; then
            rm -rf "$target"
            log_info "Excluído: $target"
        else
            log_warn "Não encontrado: $target"
        fi
    done <"$CONFIG_FILE"
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
    case "$1" in
    "--create")
        create_symlinks
        ;;
    "--delete")
        if [ "$2" == "--include-files" ]; then
            include_files=true
        fi
        delete_symlinks
        ;;
    "--help")
        echo "Usage: $0 [--create | --delete [--include-files] | --help]"
        ;;
    *)
        log_error "Erro: Argumento desconhecido '$1'"
        log_error "Uso: $0 [--create | --delete [--include-files] | --help]"
        exit 1
        ;;
    esac
fi