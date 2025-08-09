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


# =================
# Android
# =================
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$PATH"

# =================
# JAVA
# =================
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH

# =================
# CAPACITOR
# =================
export CAPACITOR_ANDROID_STUDIO_PATH="/home/ghazi/.local/bin/launch-android-studio"


# =================
# GNUPG
# =================
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)