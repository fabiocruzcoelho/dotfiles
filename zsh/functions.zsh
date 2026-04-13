f() {
  local file
  file=$(fd --type f | fzf --preview 'batcat --style=numbers --color=always {}')
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

fdcd() {
  local dir
  dir=$(fd --type d | fzf)
  [ -n "$dir" ] && cd "$dir"
}

frg() {
  local file
  file=$(rg --line-number --no-heading . | fzf \
    --delimiter ':' \
    --preview 'batcat --style=numbers --color=always {1} --highlight-line {2}')
  [ -n "$file" ] && ${EDITOR:-vim} $(echo "$file" | cut -d: -f1)
}