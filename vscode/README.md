# VSCode Configuration

This directory contains a comprehensive VSCode configuration optimized for development productivity.

## Features

### Settings (`settings.json`)
- **Editor Experience**: Optimized font settings, ligatures, and smooth scrolling
- **Theme**: One Dark Pro with Material Icon Theme
- **Performance**: Telemetry disabled, auto-updates off for better performance
- **Language Support**: Comprehensive settings for JavaScript, TypeScript, Python, Rust, Go, and more
- **Git Integration**: Enhanced Git workflow settings
- **Terminal**: Integrated zsh terminal with custom fonts
- **Code Quality**: Auto-formatting, linting, and error highlighting
- **Privacy**: All telemetry and tracking disabled

### Keybindings (`keybindings.json`)
- **Editor Shortcuts**: Multi-cursor editing, line manipulation, commenting
- **Navigation**: Quick file switching, symbol navigation, go-to-definition
- **Debugging**: Full debugging workflow shortcuts
- **Refactoring**: Quick fixes, renaming, and code actions
- **Workbench**: Panel and sidebar management
- **Custom Productivity**: Enhanced terminal, file creation, and window management

### Code Snippets
- **JavaScript**: Comprehensive snippets for modern JS/ES6+ development
- **Python**: Full Python development snippets including testing and async
- **Rust**: Complete Rust development snippets including traits, async, and testing
- **C#**: Full C# .NET snippets including LINQ, async/await, and unit testing
- **TypeScript**: (shares JavaScript snippets)
- **Additional Languages**: Ready for expansion with more language snippets

## Installation

1. **Using Stow** (recommended):
   ```bash
   cd ~/dotfiles
   stow vscode
   ```

2. **Manual Installation**:
   ```bash
   # Backup existing config
   mv ~/.config/Code/User ~/.config/Code/User.backup
   
   # Link the new config
   ln -sf ~/dotfiles/vscode/.config/Code/User ~/.config/Code/User
   ```

## Recommended Extensions

To get the most out of this configuration, install these extensions:

### Essential
- **One Dark Pro** - Theme
- **Material Icon Theme** - Icons
- **Prettier** - Code formatter
- **ESLint** - JavaScript/TypeScript linting

### Language Support
- **Python** - Python language support
- **rust-analyzer** - Rust language support
- **Go** - Go language support
- **GitLens** - Enhanced Git capabilities

### Productivity
- **Auto Rename Tag** - HTML/XML tag renaming
- **Bracket Pair Colorizer 2** - (deprecated, using built-in)
- **Path Intellisense** - Path completion
- **TODO Highlight** - Highlight TODO comments
- **Live Server** - Local development server

### Development
- **REST Client** - API testing
- **Docker** - Container support
- **Remote - SSH** - Remote development
- **Bookmarks** - Code bookmarking

## Key Features Explained

### Font Configuration
- Primary: JetBrains Mono (with ligatures)
- Fallbacks: Fira Code, Cascadia Code, Consolas
- Font ligatures enabled for better code readability

### Code Quality
- Format on save enabled
- Auto-fix on save for ESLint and other linters
- Trim trailing whitespace automatically
- Insert final newline

### Performance Optimizations
- Telemetry completely disabled
- Auto-updates disabled
- File watching optimized
- Search exclusions for common build directories

### Privacy Settings
- All telemetry disabled
- No experiments
- No natural language search
- No usage data collection

## Customization

### Adding New Snippets
Create new snippet files in `snippets/` directory:
```bash
touch ~/.config/Code/User/snippets/rust.json
```

### Modifying Keybindings
Edit `keybindings.json` to customize shortcuts. Use Ctrl+K Ctrl+S to open the keybindings editor.

### Theme Customization
Modify the `workbench.colorTheme` setting in `settings.json` to change themes.

## Language-Specific Settings

### JavaScript/TypeScript
- Auto-imports enabled
- Single quotes preferred
- Smart commit disabled for safety
- Inlay hints for function parameters

### Python
- Black formatter integration
- Flake8 linting
- Type checking enabled
- Auto-import completions

### Rust
- rust-analyzer with clippy integration
- All Cargo features enabled
- Proc macros supported
- Code lenses for run/debug

### Go
- goimports for formatting
- golangci-lint for linting
- Language server enabled
- Test generation support

## Troubleshooting

### Settings Not Applied
1. Restart VSCode
2. Check if files are properly symlinked
3. Verify no syntax errors in JSON files

### Extensions Not Working
1. Install recommended extensions
2. Check extension compatibility
3. Reload window (Ctrl+R in development mode)

### Performance Issues
1. Check file watcher exclusions
2. Disable unused extensions
3. Clear cache: `code --user-data-dir=/tmp/vscode-temp`

## Maintenance

### Updating Configuration
```bash
cd ~/dotfiles/vscode
git add .
git commit -m "Update VSCode configuration"
### Extension Management

This configuration includes an automated extension management system:

### Extension List (`scripts/extensions.txt`)
All recommended extensions are listed in `extensions.txt`. This file is used by:
- The main dotfiles installation script
- The dedicated extension management script

### Installing Extensions

**Automatic Installation** (via main install script):
```bash
cd ~/dotfiles
./install.sh  # Extensions are installed automatically if VSCode is detected
```

**Manual Installation** (using the extension script):
```bash
cd ~/dotfiles/vscode/scripts
./install-extensions.sh install
```

### Extension Script Usage

The `install-extensions.sh` script supports multiple actions:

```bash
# Install all extensions
./install-extensions.sh install

# List extensions that would be installed
./install-extensions.sh list

# Update all extensions
./install-extensions.sh update

# Uninstall all listed extensions
./install-extensions.sh uninstall

# Show help
./install-extensions.sh help
```

### Managing the Extension List

**Adding Extensions**:
1. Add extension ID to `scripts/extensions.txt`
2. Run `./install-extensions.sh install`

**Finding Extension IDs**:
```bash
# List currently installed extensions
code --list-extensions

# Search for extensions in marketplace
code --list-extensions | grep -i "search-term"
```

**Backing Up Current Extensions**:
```bash
code --list-extensions > extensions-backup.txt
```

## Contributing

Feel free to submit improvements to this configuration:
1. Test changes thoroughly
2. Document new features
3. Ensure compatibility across platforms
4. Follow JSON formatting standards

---

**Note**: This configuration is optimized for development productivity and privacy. Some features like auto-updates and telemetry are disabled for performance and privacy reasons.

