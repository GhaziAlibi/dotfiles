# =================
# File Operations Aliases
# =================
alias ls='ls --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# =================
# System Operations Aliases
# =================
alias df='df -h'
alias du='du -h'
alias free='free -m'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -c'

# =================
# Git Aliases
# =================
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gst='git status'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gpl='git pull'

# =================
# Package Manager Aliases (Arch Linux)
# =================
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -Rs'
alias yayu='yay -Syu'
alias yayi='yay -S'
alias yayr='yay -Rnsc'
alias yayl='yay -Qe'

# =================
# General Shortcuts
# =================
alias c='clear'
alias h='history'
alias j='jobs'
alias zshrc='$EDITOR ~/.zshrc'
alias reload='source ~/.zshrc'

# =================
# yt-dlp Aliases
# =================
# Audio downloads
alias dmp3='yt-dlp -x --audio-format mp3'                                    # Download as MP3
alias dflac='yt-dlp -x --audio-format flac'                                  # Download as FLAC
alias daac='yt-dlp -x --audio-format aac'                                    # Download as AAC
alias dbest='yt-dlp -x --audio-format best'                                  # Download best audio quality

# Video downloads
alias dvideo='yt-dlp -f "best[height<=720]"'                                 # Download 720p video
alias d1080='yt-dlp -f "best[height<=1080]"'                                # Download 1080p video
alias d4k='yt-dlp -f "best[height<=2160]"'                                  # Download 4K video
alias dworst='yt-dlp -f worst'                                               # Download worst quality (smallest file)

# Playlist downloads
alias dplaylist='yt-dlp -x --audio-format mp3 --yes-playlist'               # Download playlist as MP3
alias dplaylistvideo='yt-dlp -f "best[height<=720]" --yes-playlist'         # Download playlist as 720p video

# Utility aliases
alias dinfo='yt-dlp --list-formats'                                         # List available formats
alias dsubs='yt-dlp --write-subs --write-auto-subs --sub-lang en'           # Download with subtitles
alias dthumbnail='yt-dlp --write-thumbnail --skip-download'                  # Download thumbnail only
alias dmetadata='yt-dlp --write-info-json --skip-download'                  # Download metadata only

