#!/usr/bin/env bash

# VSCode Extensions Installation Script
# This script installs all VSCode extensions listed in extensions.txt

# Note: We don't use 'set -e' to allow graceful error handling

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

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSIONS_FILE="${SCRIPT_DIR}/extensions.txt"

# Main function
main() {
  print_info "VSCode Extensions Installation Script"
  
  # Check if VSCode is installed
  if ! command_exists "code"; then
    print_error "VSCode is not installed. Please install it first:"
    echo "  Arch Linux: sudo pacman -S code"
    echo "  Ubuntu/Debian: Install from https://code.visualstudio.com/"
    echo "  Or using snap: sudo snap install code --classic"
    exit 1
  fi
  
  print_success "VSCode is installed"
  
  # Check if extensions file exists
  if [ ! -f "$EXTENSIONS_FILE" ]; then
    print_error "Extensions file not found at $EXTENSIONS_FILE"
    exit 1
  fi
  
  print_info "Reading extensions from: $EXTENSIONS_FILE"
  
  # Parse command line arguments
  local action="install"
  case "${1:-}" in
    "list")
      action="list"
      ;;
    "update")
      action="update"
      ;;
    "install")
      action="install"
      ;;
    "uninstall")
      action="uninstall"
      ;;
    "help"|"--help"|"-h")
      echo "Usage: $0 [action]"
      echo "Actions:"
      echo "  install   - Install all extensions (default)"
      echo "  update    - Update all extensions"
      echo "  list      - List extensions that would be installed"
      echo "  uninstall - Uninstall all extensions"
      echo "  help      - Show this help message"
      exit 0
      ;;
    "")
      # Default action
      ;;
    *)
      print_error "Unknown action: $1"
      echo "Use '$0 help' for usage information"
      exit 1
      ;;
  esac
  
  # Read extensions from file
  local extensions=()
  while IFS= read -r line; do
    # Skip empty lines and comments
    if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
      continue
    fi
    
    # Remove any trailing whitespace
    extension=$(echo "$line" | tr -d '[:space:]')
    
    if [ -n "$extension" ]; then
      extensions+=("$extension")
    fi
  done < "$EXTENSIONS_FILE"
  
  if [ ${#extensions[@]} -eq 0 ]; then
    print_warning "No extensions found to process"
    exit 0
  fi
  
  # Perform the requested action
  case "$action" in
    "list")
      print_info "Extensions that would be installed:"
      for extension in "${extensions[@]}"; do
        echo "  - $extension"
      done
      print_info "Total: ${#extensions[@]} extensions"
      ;;
    "install")
      install_extensions "${extensions[@]}"
      ;;
    "update")
      update_extensions "${extensions[@]}"
      ;;
    "uninstall")
      uninstall_extensions "${extensions[@]}"
      ;;
  esac
}

# Function to install extensions
install_extensions() {
  local extensions=("$@")
  local installed_count=0
  local failed_count=0
  local total_count=${#extensions[@]}
  
  print_info "Installing $total_count VSCode extensions..."
  
  for extension in "${extensions[@]}"; do
    print_info "Installing: $extension"
    
    # Try to install the extension, capture output
    if output=$(code --install-extension "$extension" --force 2>&1); then
      ((installed_count++))
      if echo "$output" | grep -q "already installed"; then
        print_success "✓ $extension (already installed)"
      else
        print_success "✓ $extension (newly installed)"
      fi
    else
      ((failed_count++))
      print_warning "✗ Failed to install: $extension"
      print_warning "Error: $output"
    fi
  done
  
  # Report results
  echo ""
  if [ $failed_count -eq 0 ]; then
    print_success "All $installed_count extensions installed successfully!"
  else
    print_warning "$installed_count of $total_count extensions installed successfully, $failed_count failed"
  fi
}

# Function to update extensions
update_extensions() {
  print_info "Updating all VSCode extensions..."
  
  if code --list-extensions | xargs -L 1 echo code --install-extension; then
    print_success "All extensions updated successfully!"
  else
    print_warning "Some extensions may have failed to update"
  fi
}

# Function to uninstall extensions
uninstall_extensions() {
  local extensions=("$@")
  local uninstalled_count=0
  local failed_count=0
  local total_count=${#extensions[@]}
  
  print_warning "This will uninstall $total_count VSCode extensions"
  read -p "Are you sure? (y/N): " confirm
  
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    print_info "Operation cancelled"
    return 0
  fi
  
  for extension in "${extensions[@]}"; do
    print_info "Uninstalling: $extension"
    
    if code --uninstall-extension "$extension"; then
      ((uninstalled_count++))
      print_success "✓ Uninstalled: $extension"
    else
      ((failed_count++))
      print_warning "✗ Failed to uninstall: $extension"
    fi
  done
  
  # Report results
  echo ""
  if [ $failed_count -eq 0 ]; then
    print_success "All $uninstalled_count extensions uninstalled successfully!"
  else
    print_warning "$uninstalled_count of $total_count extensions uninstalled, $failed_count failed"
  fi
}

# Run the main function with all arguments
main "$@"

