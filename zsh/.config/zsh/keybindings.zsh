# =================
# Key Bindings
# =================
# Use emacs-style key bindings (default)
bindkey -e

# Useful key bindings
bindkey '^[[A' history-beginning-search-backward # Up arrow
bindkey '^[[B' history-beginning-search-forward  # Down arrow
bindkey '^[[H' beginning-of-line                 # Home key
bindkey '^[[F' end-of-line                       # End key
bindkey '^[[3~' delete-char                      # Delete key
bindkey '^[[1;5C' forward-word                   # Ctrl+Right
bindkey '^[[1;5D' backward-word                  # Ctrl+Left
bindkey "^[[Z" reverse-menu-complete             # Shift+Tab

# =================
# Plugin-specific Key Bindings
# =================
# Auto-suggest accepts with right arrow
bindkey '^[[C' autosuggest-accept

# History substring search with up/down arrows
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

