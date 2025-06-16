# =================
# FZF Configuration (if installed)
# =================
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
elif [[ -f /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# =================
# Custom Functions Directory
# =================
# Add custom functions directory to fpath if it exists
if [[ -d ~/.zsh/functions ]]; then
  fpath=(~/.zsh/functions $fpath)
  autoload -Uz $fpath[1]/*(.:t)
fi

# =================
# Starship Prompt - Keep this at the end
# =================
eval "$(starship init zsh)"

