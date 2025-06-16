# =================
# Custom Functions
# =================

# Function to create a directory and navigate into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Function to extract various archive formats
extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Function to show file information
fileinfo() {
    if [ -f "$1" ]; then
        echo "File: $1"
        echo "Size: $(du -h "$1" | cut -f1)"
        echo "Type: $(file -b "$1")"
        echo "Permissions: $(ls -l "$1" | cut -d' ' -f1)"
        echo "Last modified: $(stat -c %y "$1")"
    else
        echo "File '$1' not found"
    fi
}

# Function to find files by name
find_file() {
    find . -name "*$1*" -type f 2>/dev/null
}

# Function to find directories by name
find_dir() {
    find . -name "*$1*" -type d 2>/dev/null
}

