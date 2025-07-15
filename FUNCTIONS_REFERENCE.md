# Functions Reference

This document provides a comprehensive reference for all functions used across the Ubuntu Development Setup scripts.

## Table of Contents

- [Common Functions](#common-functions)
- [Logging Functions](#logging-functions)
- [Utility Functions](#utility-functions)
- [System Functions](#system-functions)
- [Package Management Functions](#package-management-functions)
- [Configuration Functions](#configuration-functions)

## Common Functions

### `confirm()`
Interactive confirmation function with auto-run support.

```bash
confirm() {
    [[ "$AUTO_RUN" == "--auto" ]] && return 0
    read -p "$(echo -e "${YELLOW}$1 [y/N]:${NC} ")" -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}
```

**Usage:**
```bash
confirm "Install packages?" && install_packages
```

**Parameters:**
- `$1`: Confirmation message

**Returns:**
- `0`: User confirmed (y/Y) or auto-run mode
- `1`: User declined (n/N or any other input)

### `main()`
Standard main function template for all scripts.

```bash
main() {
    log "🚀 Starting [Script Name]"
    
    # Check if running on Ubuntu
    if [[ ! -f /etc/os-release ]] || ! grep -q "Ubuntu" /etc/os-release; then
        error "This script is designed for Ubuntu systems"
        exit 1
    fi
    
    # Auto-run check
    if [[ "$1" == "--auto" ]]; then
        AUTO_RUN="--auto"
        log "Running in auto mode (no prompts)"
    fi
    
    # Script logic here...
    
    success "🎉 [Script Name] complete!"
}
```

## Logging Functions

### `log()`
Standard logging function with timestamp.

```bash
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}
```

**Usage:**
```bash
log "Installing packages..."
```

### `success()`
Success message with green checkmark.

```bash
success() {
    echo -e "${GREEN}✅ $1${NC}"
}
```

**Usage:**
```bash
success "Package installation complete"
```

### `warning()`
Warning message with yellow warning icon.

```bash
warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}
```

**Usage:**
```bash
warning "Package not found, skipping"
```

### `error()`
Error message with red X icon.

```bash
error() {
    echo -e "${RED}❌ $1${NC}"
}
```

**Usage:**
```bash
error "Installation failed"
```

### `info()`
Information message with blue info icon.

```bash
info() {
    echo -e "${CYAN}ℹ️ $1${NC}"
}
```

**Usage:**
```bash
info "Ubuntu version: 22.04"
```

## Utility Functions

### `track_step()`
Track completion status of setup steps.

```bash
track_step() {
    local step="$1"
    local status="$2"
    
    if [[ "$status" == "success" ]]; then
        COMPLETED_STEPS+=("$step")
        success "✅ $step completed successfully"
    else
        FAILED_STEPS+=("$step")
        error "❌ $step failed"
    fi
}
```

**Usage:**
```bash
track_step "System Preferences" "success"
track_step "Package Installation" "failed"
```

### `run_script()`
Execute a script with error handling and tracking.

```bash
run_script() {
    local script_name="$1"
    local script_path="$SCRIPT_DIR/$script_name"
    local description="$2"
    
    if [[ ! -f "$script_path" ]]; then
        error "Script not found: $script_path"
        track_step "$description" "failed"
        return 1
    fi
    
    if [[ ! -x "$script_path" ]]; then
        chmod +x "$script_path"
    fi
    
    log "Running: $description"
    
    if [[ "$AUTO_RUN" == "--auto" ]]; then
        if "$script_path" --auto; then
            track_step "$description" "success"
        else
            track_step "$description" "failed"
        fi
    else
        if "$script_path"; then
            track_step "$description" "success"
        else
            track_step "$description" "failed"
        fi
    fi
}
```

**Usage:**
```bash
run_script "01_system_prefs.sh" "System Preferences Setup"
```

## System Functions

### `check_requirements()`
Verify system requirements before running scripts.

```bash
check_requirements() {
    log "Checking system requirements..."
    
    # Check if running on Ubuntu
    if [[ ! -f /etc/os-release ]] || ! grep -q "Ubuntu" /etc/os-release; then
        error "This script is designed for Ubuntu systems"
        exit 1
    fi
    
    # Check Ubuntu version
    local ubuntu_version=$(lsb_release -rs)
    local major_version=$(echo "$ubuntu_version" | cut -d. -f1)
    
    if [[ "$major_version" -lt 20 ]]; then
        error "Ubuntu 20.04 or later is required. Current version: $ubuntu_version"
        exit 1
    fi
    
    success "System requirements check passed"
}
```

### `update_system()`
Update system packages.

```bash
update_system() {
    log "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    success "System packages updated"
}
```

## Package Management Functions

### `install_apt_packages()`
Install packages using APT package manager.

```bash
install_apt_packages() {
    log "Installing APT packages..."
    
    sudo apt update
    
    local apt_packages=(
        "package1"
        "package2"
        "package3"
    )
    
    for package in "${apt_packages[@]}"; do
        if ! dpkg -l | grep -q "^ii  $package "; then
            log "Installing $package..."
            sudo apt install -y "$package" || warning "Failed to install $package"
        else
            log "$package is already installed"
        fi
    done
    
    success "APT packages installation complete"
}
```

### `install_snap_packages()`
Install packages using Snap package manager.

```bash
install_snap_packages() {
    log "Installing Snap packages..."
    
    sudo systemctl start snapd
    sudo systemctl enable snapd
    
    local snap_packages=(
        "package1 --classic"
        "package2"
        "package3 --classic"
    )
    
    for package_info in "${snap_packages[@]}"; do
        package_name=$(echo "$package_info" | cut -d' ' -f1)
        if ! snap list | grep -q "^$package_name "; then
            log "Installing snap package: $package_info"
            sudo snap install $package_info || warning "Failed to install snap package: $package_info"
        else
            log "Snap package $package_name is already installed"
        fi
    done
    
    success "Snap packages installation complete"
}
```

### `install_flatpak_packages()`
Install packages using Flatpak package manager.

```bash
install_flatpak_packages() {
    log "Installing Flatpak packages..."
    
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    
    local flatpak_packages=(
        "org.package1.App"
        "org.package2.App"
        "org.package3.App"
    )
    
    for package in "${flatpak_packages[@]}"; do
        if ! flatpak list | grep -q "$package"; then
            log "Installing Flatpak package: $package"
            flatpak install -y flathub "$package" || warning "Failed to install Flatpak package: $package"
        else
            log "Flatpak package $package is already installed"
        fi
    done
    
    success "Flatpak packages installation complete"
}
```

## Configuration Functions

### `setup_git_config()`
Configure Git with user information and aliases.

```bash
setup_git_config() {
    log "Setting up Git configuration..."
    
    if git config --global user.name > /dev/null 2>&1; then
        log "Git is already configured for user: $(git config --global user.name)"
        return 0
    fi
    
    read -p "Enter your Git global user.name: " git_name
    git config --global user.name "$git_name"
    
    read -p "Enter your Git global user.email: " git_email
    git config --global user.email "$git_email"
    
    # Configure Git settings
    git config --global core.editor "vim"
    git config --global init.defaultBranch main
    git config --global pull.rebase true
    
    # Git aliases
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    git config --global alias.st "status"
    git config --global alias.co "checkout"
    git config --global alias.br "branch"
    
    success "Git configuration complete"
}
```

### `setup_ssh_keys()`
Generate and configure SSH keys.

```bash
setup_ssh_keys() {
    log "Setting up SSH keys..."
    
    if [[ -f ~/.ssh/id_ed25519 ]]; then
        log "SSH key already exists at ~/.ssh/id_ed25519"
        return 0
    fi
    
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    
    read -p "Enter your email for SSH key: " ssh_email
    ssh-keygen -t ed25519 -C "$ssh_email" -f ~/.ssh/id_ed25519 -N ""
    
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    
    success "SSH keys setup complete"
}
```

### `setup_zsh()`
Install and configure Zsh with Oh My Zsh.

```bash
setup_zsh() {
    log "Setting up Zsh with Oh My Zsh..."
    
    if ! command -v zsh > /dev/null 2>&1; then
        sudo apt install -y zsh
    fi
    
    if [[ ! -d ~/.oh-my-zsh ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # Install plugins
    ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
    
    if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    fi
    
    if [[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    fi
    
    # Change default shell
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        chsh -s $(which zsh)
    fi
    
    success "Zsh setup complete"
}
```

## Color Codes

Standard color codes used across all scripts:

```bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color
```

## Error Handling

Standard error handling pattern:

```bash
set -e  # Exit on error

# Function with error handling
safe_operation() {
    if ! command_that_might_fail; then
        error "Operation failed"
        return 1
    fi
    success "Operation completed"
    return 0
}
```

## Script Execution Pattern

Standard pattern for script execution:

```bash
# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

This allows scripts to be both executed directly and sourced from other scripts.
