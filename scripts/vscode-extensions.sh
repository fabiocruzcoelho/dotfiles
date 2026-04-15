#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck disable=SC1091
source "scripts/common.sh"

install_vscode_extensions() {
    info "Installing VSCode extensions..."

    extensions=(
    )

    for e in "${extensions[@]}"; do
        code --install-extension "$e"
    done

    success "VSCode extensions installed successfully"
}

if [ "$(basename "$0")" = "$(basename "${BASH_SOURCE[0]}")" ]; then
    install_vscode_extensions
fi