# ===================================================
# ZSH Configuration File
# ===================================================

# =================
# Zim Configuration
# =================
# Define Zim home directory
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Initialize Zim if installed
if [[ -e ${ZIM_HOME}/init.zsh ]]; then
  # Source the initialization file
  source ${ZIM_HOME}/init.zsh
fi

# =================
# History Configuration
# =================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# =================
# Basic ZSH Options
# =================
setopt auto_cd              # cd by typing directory name if it's not a command
setopt auto_list            # automatically list choices on ambiguous completion
setopt auto_menu            # automatically use menu completion
setopt always_to_end        # move cursor to end if word had one match
setopt complete_in_word     # allow completion from within a word
setopt extended_glob        # treat #, ~, and ^ as part of patterns for filename generation
setopt path_dirs            # perform path search even on command names with slashes
setopt long_list_jobs       # list jobs in the long format
setopt interactivecomments  # recognize comments in interactive mode

# =================
# Completion Settings
# =================
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"   # colored completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*' rehash true                        # automatically find new executables
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:kill:*' force-list always

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
# Useful Aliases
# =================
# File operations
alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# System operations
alias df='df -h'
alias du='du -h'
alias free='free -m'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c'

# Git aliases
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gst='git status'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gpl='git pull'

# Pacman/yay aliases
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -Rs'
alias yayu='yay -Syu'
alias yayi='yay -S'

# Useful shortcuts
alias c='clear'
alias h='history'
alias j='jobs'
alias zshrc='$EDITOR ~/.zshrc'
alias reload='source ~/.zshrc'

# =================
# PATH Configuration
# =================
# Add user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# =================
# Initialize Zim
# =================
# Install Zim if it doesn't exist
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    # Download zimfw script
    mkdir -p ${ZIM_HOME}
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Define Zim home directory
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Initialize Zim if installed
if [[ -e ${ZIM_HOME}/zimfw.zsh ]]; then
    # Install missing modules and update ${ZIM_HOME}/init.zsh
    if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
        source ${ZIM_HOME}/zimfw.zsh init -q
    fi
    # Source the initialization file
    source ${ZIM_HOME}/init.zsh
fi

# =================
# Environment Variables
# =================
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LESS='-R'
export LC_COLLATE="C" # Sort files in a natural order

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
# Additional integrations
# =================
# Auto-suggest accepts with right arrow
bindkey '^[[C' autosuggest-accept

# History substring search with up/down arrows
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Add custom functions directory to fpath if it exists
if [[ -d ~/.zsh/functions ]]; then
  fpath=(~/.zsh/functions $fpath)
  autoload -Uz $fpath[1]/*(.:t)
fi

# =================
# Local Configuration - for machine-specific settings
# =================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# =================
# Starship Prompt - Keep this at the end
# =================
eval "$(starship init zsh)"

# Show a welcome message
echo "Welcome to ZSH with Starship! $(date +"%Y-%m-%d %H:%M")"

