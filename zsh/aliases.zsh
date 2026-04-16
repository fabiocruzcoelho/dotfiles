# CORE
alias la='eza -A'
alias htop='btop'
alias tree='eza --tree --icons'
alias ls='eza --color=always --group-directories-first'
alias ll='eza -lah --icons --group-directories-first'
alias apt-upgrade='sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y'

# FILE VIEW
alias cat='bat --style=plain'
alias catn='bat --style=numbers'

# SEARCH
alias grep='rg'
alias find='fd'

# DISK
alias df='duf'

# FIX UBUNTU BIN NAMES
alias fd='fdfind'
alias bat='batcat'