zf() {
  local dir

  if [[ "$1" == "-h" ]]; then
    dir=$(
      (
        zoxide query -l
        fd --type d --hidden --exclude .git .
      ) | awk '!seen[$0]++' |
      fzf --height 40% --reverse \
          --preview 'eza --tree --level=2 --color=always {} | head -200'
    )
  else
    dir=$(
      (
        zoxide query -l
        fd --type d --exclude .git .
      ) | grep -v '/\.' | awk '!seen[$0]++' |
      fzf --height 40% --reverse \
          --preview 'eza --tree --level=2 --color=always {} | head -200'
    )
  fi

  [ -n "$dir" ] && cd "$dir"
}

f() {
  local file
  file=$(fd --type f | fzf --preview 'batcat --style=numbers --color=always {}')
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

frg() {
  local file
  file=$(rg --line-number --no-heading . | fzf \
    --delimiter ':' \
    --preview 'batcat --style=numbers --color=always {1} --highlight-line {2}')
  [ -n "$file" ] && ${EDITOR:-vim} $(echo "$file" | cut -d: -f1)
}