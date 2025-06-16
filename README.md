# Dotfiles

A personal collection of configuration files for zsh, starship prompt, zim framework, SSH, and more.

## Introduction

This repository contains my personal configuration files ("dotfiles") for various command-line tools and applications, organized using GNU Stow for easy installation and management.

Included configurations:

- **ZSH**: Shell configuration
- **Zimfw**: ZSH plugin manager framework
- **Starship**: Cross-shell prompt
- **FZF**: Fuzzy finder
- **SSH**: Secure Shell configuration
- **Git**: Git configuration and global gitignore
- **VSCode**: Visual Studio Code configuration with settings, keybindings, and snippets

## Directory Structure

The repository is organized following the GNU Stow conventions, with each application's configurations in its own subdirectory:

```
dotfiles/
├── install.sh         # Automated installation script
├── README.md          # This documentation file
├── git/              # Git configuration
│   ├── .gitconfig       # Git settings
│   └── .gitignore_global # Global gitignore patterns
├── ssh/              # SSH configuration
│   └── .ssh/
│       └── config     # SSH client configuration
├── starship/          # Starship prompt configuration
│   └── .config/
│       └── starship.toml
├── vscode/            # VSCode configuration
│   ├── .config/
│   │   └── Code/
│   │       └── User/
│   │           ├── settings.json      # VSCode settings
│   │           ├── keybindings.json   # Custom keybindings
│   │           └── snippets/          # Code snippets
│   │               ├── javascript.json
│   │               └── python.json
│   └── README.md      # VSCode-specific documentation
└── zsh/               # ZSH shell configuration
    ├── .fzf.zsh       # FZF configuration for ZSH
    ├── .zimrc         # Zim framework configuration
    └── .zshrc         # Main ZSH configuration
```

## Dependencies

This configuration requires the following tools:

- **zsh**: The Z shell
- **stow**: Symlink farm manager
- **starship**: Cross-shell prompt
- **fzf**: Command-line fuzzy finder
- **zimfw**: ZSH plugin framework
- **yay**: AUR helper (for Arch Linux)

## Installation

### Automated Installation

The easiest way to install these dotfiles is using the provided installation script:

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

The script will:
- Check for and install missing dependencies
- Set up symbolic links to all configuration files
- Install yay (AUR helper) if not present
- Install fzf from AUR (if yay is available)
- Install Starship and Zimfw
- Optionally set up SSH keys for GitHub (with proper permissions)

### Manual Installation

If you prefer to install manually:

1. Install required packages:
   ```bash
   # For Arch Linux
   sudo pacman -S zsh stow git base-devel
   
   # Install yay (AUR helper)
   git clone https://aur.archlinux.org/yay.git
   cd yay && makepkg -si
   
   # Install fzf
   yay -S fzf
   
   # Install Starship
   curl -sS https://starship.rs/install.sh | sh
   
   # Install Zimfw
   curl -fsSL --create-dirs -o ~/.zim/zimfw.zsh \
     https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
   ```

2. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
   ```

3. Use stow to create the symlinks:
   ```bash
   cd ~/dotfiles
   stow zsh
   stow starship
   stow vscode
   stow git
   stow ssh
   ```

## Usage

### Adding New Configurations

To add a new configuration for an application:

1. Create a new directory for the application:
   ```bash
   mkdir -p ~/dotfiles/app_name
   ```

2. Add the configuration files to this directory, maintaining the same structure as they would have in your home directory:
   ```bash
   # Example for an app with config in ~/.config/app_name/config.yml
   mkdir -p ~/dotfiles/app_name/.config/app_name
   cp ~/.config/app_name/config.yml ~/dotfiles/app_name/.config/app_name/
   ```

3. Stow the new configuration:
   ```bash
   cd ~/dotfiles
   stow app_name
   ```

### Updating Configurations

Simply edit the files in the `~/dotfiles` directory. Since they're symlinked, changes will be reflected immediately.

### Removing Configurations

To remove the symlinks for a specific package:

```bash
cd ~/dotfiles
stow -D app_name
```

### Restowing After Changes

If you've made changes to the directory structure:

```bash
cd ~/dotfiles
stow -R app_name
```

## SSH Setup

The dotfiles include SSH client configuration with secure defaults. The installation script can also help you generate SSH keys for GitHub.

### Manual SSH Key Generation

If you didn't generate keys during installation or need additional keys:

```bash
# Generate a new Ed25519 key (recommended)
ssh-keygen -t ed25519 -C "your_email@example.com" -f ~/.ssh/github_ed25519

# Set proper permissions
chmod 700 ~/.ssh
chmod 600 ~/.ssh/github_ed25519
chmod 644 ~/.ssh/github_ed25519.pub

# Add to GitHub
cat ~/.ssh/github_ed25519.pub
# Copy the output and add to https://github.com/settings/keys

# Test connection
ssh -T git@github.com
```

### SSH Config

The SSH configuration in `ssh/.ssh/config` includes settings for GitHub and general security hardening:

```
# Global settings with security hardening
Host *
    HashKnownHosts yes
    IdentitiesOnly yes
    ServerAliveInterval 60
    ServerAliveCountMax 2

# GitHub-specific settings
Host github.com
    User git
    IdentityFile ~/.ssh/github_ed25519
    IdentitiesOnly yes
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

