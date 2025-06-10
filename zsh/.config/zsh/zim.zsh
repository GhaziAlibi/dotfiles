# =================
# Zim Framework Configuration
# =================
# Define Zim home directory
ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Install Zim if it doesn't exist
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    # Download zimfw script
    mkdir -p ${ZIM_HOME}
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Initialize Zim if installed
if [[ -e ${ZIM_HOME}/zimfw.zsh ]]; then
    # Install missing modules and update ${ZIM_HOME}/init.zsh
    if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
        source ${ZIM_HOME}/zimfw.zsh init -q
    fi
    # Source the initialization file
    source ${ZIM_HOME}/init.zsh
fi

