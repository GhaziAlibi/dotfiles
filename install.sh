#!/usr/bin/env bash

# Dotfiles installation script using GNU Stow
# This script checks for dependencies, installs them if needed, and uses stow to manage dotfiles

set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error when substituting

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored messages
print_info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
  echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
  echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Function to install packages using pacman (Arch Linux)
install_package() {
  local package="$1"
  
  # Check if package is already installed using pacman -Qi
  if pacman -Qi "$package" &> /dev/null; then
    print_info "$package is already installed"
    return 0
  fi
  
  # If not installed, install it
  print_info "Installing $package..."
  sudo pacman -S --noconfirm "$package" || {
    print_error "Failed to install $package"
    return 1
  }
  print_success "$package installed successfully"
}

# Function to install packages using yay (AUR helper for Arch Linux)
install_aur_package() {
  local package="$1"
  
  # Check if yay is available
  if ! command_exists "yay"; then
    print_error "Yay is not installed. Cannot install AUR package $package"
    return 1
  fi
  
  # Check if package is already installed using yay -Qi
  if yay -Qi "$package" &> /dev/null; then
    print_info "$package is already installed"
    return 0
  fi
  
  # If not installed, install it
  print_info "Installing $package from AUR..."
  yay -S --noconfirm "$package" || {
    print_error "Failed to install $package from AUR"
    return 1
  }
  print_success "$package installed successfully from AUR"
}

# Function to install yay if not already installed
install_yay() {
  if command_exists "yay"; then
    print_info "Yay is already installed"
    return 0
  fi
  
  print_info "Installing yay (AUR helper)..."
  
  # Check if git is installed
  install_package "git" || return 1
  install_package "base-devel" || return 1
  
  # Create a temporary directory
  local temp_dir
  temp_dir=$(mktemp -d)
  
  # Clone the yay repository
  git clone https://aur.archlinux.org/yay.git "$temp_dir" || {
    print_error "Failed to clone yay repository"
    rm -rf "$temp_dir"
    return 1
  }
  
  # Build and install yay
  (cd "$temp_dir" && makepkg -si --noconfirm) || {
    print_error "Failed to build and install yay"
    rm -rf "$temp_dir"
    return 1
  }
  
  # Clean up
  rm -rf "$temp_dir"
  
  if command_exists "yay"; then
    print_success "Yay installed successfully"
    return 0
  else
    print_error "Yay installation failed"
    return 1
  fi
}

# Function to install Zimfw if not already installed
install_zimfw() {
  if [ ! -d "${ZDOTDIR:-$HOME}/.zim" ]; then
    print_info "Installing Zimfw..."
    curl -fsSL --create-dirs -o "${ZDOTDIR:-$HOME}/.zim/zimfw.zsh" \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh || {
      print_error "Failed to download Zimfw"
      return 1
    }
    print_success "Zimfw installed successfully"
  else
    print_info "Zimfw is already installed"
  fi
}

# Function to install Starship if not already installed
install_starship() {
  if ! command_exists starship; then
    print_info "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh || {
      print_error "Failed to install Starship"
      return 1
    }
    print_success "Starship installed successfully"
  else
    print_info "Starship is already installed"
  fi
}

# Function to setup SSH keys and configuration
setup_ssh() {
  print_info "Setting up SSH..."
  
  # Create .ssh directory with proper permissions if it doesn't exist
  if [ ! -d "${HOME}/.ssh" ]; then
    print_info "Creating .ssh directory..."
    mkdir -p "${HOME}/.ssh"
    chmod 700 "${HOME}/.ssh"
    print_success "Created .ssh directory with secure permissions"
  else
    chmod 700 "${HOME}/.ssh"
    print_info ".ssh directory already exists, ensuring proper permissions"
  fi
  
  # Ask if user wants to generate SSH keys
  read -p "$(echo -e ${BLUE}[PROMPT]${NC}" Would you like to generate SSH keys for GitHub? (y/n): ")" generate_keys
  
  if [[ "$generate_keys" =~ ^[Yy]$ ]]; then
    # Ask for email
    read -p "$(echo -e ${BLUE}[PROMPT]${NC}" Enter your email for the SSH key: ")" ssh_email
    
    if [ -z "$ssh_email" ]; then
      print_warning "No email provided, using default value"
      ssh_email="user@example.com"
    fi
    
    # Generate Ed25519 key for GitHub
    print_info "Generating SSH key for GitHub..."
    ssh-keygen -t ed25519 -C "$ssh_email" -f "${HOME}/.ssh/github_ed25519" || {
      print_error "Failed to generate SSH key"
      return 1
    }
    
    # Set proper permissions
    chmod 600 "${HOME}/.ssh/github_ed25519"
    chmod 644 "${HOME}/.ssh/github_ed25519.pub"
    
    # Display the public key
    echo -e "\n${GREEN}[SUCCESS]${NC} SSH key generated successfully"
    echo -e "\n${YELLOW}[IMPORTANT]${NC} Add this public key to your GitHub account:"
    echo -e "https://github.com/settings/keys\n"
    cat "${HOME}/.ssh/github_ed25519.pub"
    echo -e "\n${BLUE}[INFO]${NC} After adding the key to GitHub, test with: ssh -T git@github.com"
  else
    print_info "Skipping SSH key generation"
  fi
  
  return 0
}

# Function to install developer tools
install_dev_tools() {
  print_info "Installing developer tools..."
  
  # Define arrays of packages to install
  # Standard packages available in official repositories
  local standard_packages=(
    "fastfetch"  # System information display
    "ripgrep"   # Fast search tool (better grep)
    "neovim"    # Modern vim editor
    "bat"       # Cat with syntax highlighting
    "git-delta" # Better git diff viewer
    "fd"        # Fast find alternative
    "jq"        # JSON processor
    "yt-dlp"    # YouTube video/audio downloader
  )
  
  # AUR packages that require yay
  local aur_packages=(
    "exa"      # Modern ls replacement
    "lazygit"  # Terminal UI for git
  )
  
  # Install standard packages
  print_info "Installing packages from official repositories..."
  local failed_packages=()
  local success_count=0
  local total_standard=${#standard_packages[@]}
  
  for package in "${standard_packages[@]}"; do
    install_package "$package" || {
      print_warning "Failed to install $package, continuing with other packages"
      failed_packages+=("$package")
    }
    
    if ! [[ " ${failed_packages[*]} " =~ " $package " ]]; then
      ((success_count++))
    fi
  done
  
  # Report results for standard packages
  if [ ${#failed_packages[@]} -eq 0 ]; then
    print_success "All standard packages installed successfully"
  else
    print_warning "$success_count of $total_standard standard packages installed. Failed packages: ${failed_packages[*]}"
  fi
  
  # Install AUR packages if yay is available
  if command_exists "yay"; then
    print_info "Installing packages from AUR..."
    local failed_aur_packages=()
    local success_aur_count=0
    local total_aur=${#aur_packages[@]}
    
    for package in "${aur_packages[@]}"; do
      install_aur_package "$package" || {
        print_warning "Failed to install $package from AUR, continuing with other packages"
        failed_aur_packages+=("$package")
      }
      
      if ! [[ " ${failed_aur_packages[*]} " =~ " $package " ]]; then
        ((success_aur_count++))
      fi
    done
    
    # Report results for AUR packages
    if [ ${#failed_aur_packages[@]} -eq 0 ]; then
      print_success "All AUR packages installed successfully"
    else
      print_warning "$success_aur_count of $total_aur AUR packages installed. Failed packages: ${failed_aur_packages[*]}"
    fi
  else
    print_warning "Yay is not installed, skipping AUR packages installation"
    print_info "AUR packages that would have been installed: ${aur_packages[*]}"
  fi
  
  print_success "Developer tools installation completed"
  return 0
}

# Function to install VSCode extensions
install_vscode_extensions() {
  print_info "Installing VSCode extensions..."
  
  # Check if VSCode is installed
  if ! command_exists "code"; then
    print_warning "VSCode is not installed, skipping extension installation"
    print_info "Install VSCode first: sudo pacman -S code"
    return 0
  fi
  
  # Check if extensions file exists
  local extensions_file="${DOTFILES_DIR}/vscode/extensions.txt"
  if [ ! -f "$extensions_file" ]; then
    print_warning "Extensions file not found at $extensions_file"
    return 0
  fi
  
  # Read extensions from file and install them
  local installed_count=0
  local failed_count=0
  local total_count=0
  
  while IFS= read -r line; do
    # Skip empty lines and comments
    if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
      continue
    fi
    
    # Remove any trailing whitespace
    extension=$(echo "$line" | tr -d '[:space:]')
    
    if [ -n "$extension" ]; then
      ((total_count++))
      print_info "Installing VSCode extension: $extension"
      
      if code --install-extension "$extension" --force; then
        ((installed_count++))
        print_success "Extension $extension installed successfully"
      else
        ((failed_count++))
        print_warning "Failed to install extension: $extension"
      fi
    fi
  done < "$extensions_file"
  
  # Report results
  if [ $total_count -eq 0 ]; then
    print_info "No extensions found to install"
  elif [ $failed_count -eq 0 ]; then
    print_success "All $installed_count VSCode extensions installed successfully"
  else
    print_warning "$installed_count of $total_count extensions installed successfully, $failed_count failed"
  fi
  
  return 0
}

# Function to stow a package
stow_package() {
  local package="$1"
  print_info "Stowing $package..."
  
  # Use the --no-folding option to prevent merging directories
  stow --verbose=2 --target="$HOME" --restow --no-folding "$package" 2>&1 | grep -v "BUG in find_stowed_path" || {
    print_error "Failed to stow $package"
    return 1
  }
  
  print_success "$package stowed successfully"
}

# Main function
main() {
  print_info "Starting dotfiles installation..."
  
  # Dotfiles directory (where this script is located)
  DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  print_info "Dotfiles directory: $DOTFILES_DIR"
  
  # Check and install dependencies
  print_info "Checking dependencies..."
  
  # Check for zsh and install if needed
  install_package "zsh" || exit 1
  
  # Install stow
  install_package "stow" || exit 1
  
  # Install yay (AUR helper)
  install_yay || {
    print_warning "Failed to install yay, will not be able to install AUR packages"
  }
  
  # Install fzf if yay is available
  if command_exists "yay"; then
    install_aur_package "fzf" || {
      print_warning "Failed to install fzf from AUR"
    }
  else
    print_warning "Yay is not installed, skipping fzf installation"
  fi
  
  # Install Starship
  install_starship || exit 1
  
  # Install Zimfw
  install_zimfw || exit 1
  
  # Install developer tools
  install_dev_tools
  
  # Setup SSH (optional)
  setup_ssh
  
  # Install VSCode extensions (if VSCode is installed)
  install_vscode_extensions
  
  # Create necessary directories
  print_info "Creating necessary directories..."
  mkdir -p "${HOME}/.config" || {
    print_error "Failed to create directory ${HOME}/.config"
    exit 1
  }
  
  # Change to the dotfiles directory
  cd "$DOTFILES_DIR"
  
  # Stow all packages
  print_info "Setting up dotfiles with stow..."
  
  # Get all directories in the dotfiles directory (excluding hidden directories and .git)
  for package in */; do
    package=${package%/}  # Remove trailing slash
    if [[ "$package" != "." && "$package" != ".." && "$package" != ".git" ]]; then
      stow_package "$package"
    fi
  done
  
  print_success "All dotfiles have been installed successfully!"
  print_info "To apply changes, restart your terminal or run: source ~/.zshrc"
}

# Run the main function
main

