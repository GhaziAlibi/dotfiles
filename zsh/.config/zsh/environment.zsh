# =================
# Environment Variables
# =================
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export LESS='-R'
export LC_COLLATE="C" # Sort files in a natural order

# =================
# PATH Configuration
# =================
# Add user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$PATH:$HOME/.dotnet/tools"
