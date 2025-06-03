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
  if ! command_exists "$1"; then
    print_info "Installing $1..."
    sudo pacman -S --noconfirm "$1" || {
      print_error "Failed to install $1"
      return 1
    }
    print_success "$1 installed successfully"
  else
    print_info "$1 is already installed"
  fi
}

# Function to install packages using yay (AUR helper for Arch Linux)
install_aur_package() {
  if ! command_exists "yay"; then
    print_error "Yay is not installed. Cannot install AUR package $1"
    return 1
  fi
  
  if ! yay -Qi "$1" &> /dev/null; then
    print_info "Installing $1 from AUR..."
    yay -S --noconfirm "$1" || {
      print_error "Failed to install $1 from AUR"
      return 1
    }
    print_success "$1 installed successfully from AUR"
  else
    print_info "$1 is already installed"
  fi
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

