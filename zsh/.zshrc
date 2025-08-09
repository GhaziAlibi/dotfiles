# ===================================================
# ZSH Configuration File - Modular Setup
# ===================================================

# Define the configuration directory
ZSH_CONFIG_DIR="${ZDOTDIR:-$HOME}/.config/zsh"

# Source all configuration modules in the correct order
# Note: Order matters for some configurations

# 1. Environment variables (should be loaded first)
[[ -f "$ZSH_CONFIG_DIR/environment.zsh" ]] && source "$ZSH_CONFIG_DIR/environment.zsh"

# 2. ZSH options and settings
[[ -f "$ZSH_CONFIG_DIR/options.zsh" ]] && source "$ZSH_CONFIG_DIR/options.zsh"

# 3. History configuration
[[ -f "$ZSH_CONFIG_DIR/history.zsh" ]] && source "$ZSH_CONFIG_DIR/history.zsh"

# 4. Completion system
[[ -f "$ZSH_CONFIG_DIR/completion.zsh" ]] && source "$ZSH_CONFIG_DIR/completion.zsh"

# 5. Key bindings
[[ -f "$ZSH_CONFIG_DIR/keybindings.zsh" ]] && source "$ZSH_CONFIG_DIR/keybindings.zsh"

# 6. Zim framework (plugin manager)
[[ -f "$ZSH_CONFIG_DIR/zim.zsh" ]] && source "$ZSH_CONFIG_DIR/zim.zsh"

# 7. Aliases
[[ -f "$ZSH_CONFIG_DIR/aliases.zsh" ]] && source "$ZSH_CONFIG_DIR/aliases.zsh"

# 8. Custom functions
[[ -f "$ZSH_CONFIG_DIR/functions.zsh" ]] && source "$ZSH_CONFIG_DIR/functions.zsh"

# 9. External integrations (FZF, Starship, etc.) - should be loaded last
[[ -f "$ZSH_CONFIG_DIR/integrations.zsh" ]] && source "$ZSH_CONFIG_DIR/integrations.zsh"

# =================
# Local Configuration - for machine-specific settings
# =================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# =================
# Welcome Message
# =================
echo "Welcome to ZSH with modular configuration! $(date +"%Y-%m-%d %H:%M")"



# Load Angular CLI autocompletion.
source <(ng completion script)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
