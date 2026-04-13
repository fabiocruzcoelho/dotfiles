export DOTFILES="$HOME/dotfiles"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

# plugins
source "$DOTFILES/zsh/plugins.zsh"
source $ZSH/oh-my-zsh.sh

# mise
if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$($HOME/.local/bin/mise activate zsh)"
fi

# fzf
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
fi


# módulos
for file in exports aliases functions; do
  [ -f "$DOTFILES/zsh/$file.zsh" ] && source "$DOTFILES/zsh/$file.zsh"
done

export PATH="$DOTFILES/bin:$PATH"

# Starship
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# CTRL+F → buscar arquivo
bindkey -s '^f' 'f\n'

# CTRL+D → navegar diretórios
bindkey -s '^d' 'fdcd\n'

# CTRL+G → grep interativo
bindkey -s '^g' 'frg\n'