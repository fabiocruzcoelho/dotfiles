# Fabio's dotfiles

Configuração pessoal para ambiente DevOps/SRE

---

## 🚀 Setup

```bash
git clone https://github.com/seu-usuario/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

---

## 🧰 Stack

* zsh + oh-my-zsh
* starship (prompt)
* mise (runtime manager)
* fzf (fuzzy finder)
* bat / eza / duf / ripgrep / fd
* gh (GitHub CLI)

---

## ⌨️ Shortcuts

| Atalho   | Ação                    |
| -------- | ----------------------- |
| `Ctrl+F` | Buscar arquivos         |
| `Ctrl+D` | Navegar diretórios      |
| `Ctrl+G` | Buscar texto no projeto |

---

## 🔧 Estrutura

```
zsh/
  aliases.zsh
  exports.zsh
  functions.zsh
  plugins.zsh

starship/
  starship.toml

mise/
  config.toml
```

---

## 🧠 Filosofia

* simples > complexo
* rápido > bonito
* automatizado > manual

---

## 📌 Notas

* Ubuntu usa `batcat` e `fdfind` (aliases aplicados)
* Nerd Font recomendada para ícones
* Reexecute `install.sh` a qualquer momento (idempotente)

---
