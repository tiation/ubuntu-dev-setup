#!/bin/bash

# Ubuntu System Preferences Configuration Script
# Part of Ubuntu Development Setup Suite

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

# Confirmation function
confirm() {
    [[ "$AUTO_RUN" == "--auto" ]] && return 0
    read -p "$(echo -e "${YELLOW}$1 [y/N]:${NC} ")" -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Update system packages
update_system() {
    log "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    success "System packages updated"
}

# Configure GNOME desktop preferences
setup_gnome_preferences() {
    log "Setting up GNOME desktop preferences..."
    
    # Set dark theme
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    success "Dark theme enabled"
    
    # Dock preferences (if Ubuntu dock extension is available)
    if gsettings list-schemas | grep -q "org.gnome.shell.extensions.dash-to-dock"; then
        gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
        gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
        gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
        gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
        success "Dock preferences configured"
    fi
    
    # File manager settings
    gsettings set org.gnome.nautilus.preferences show-hidden-files true
    gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
    gsettings set org.gnome.nautilus.list-view default-zoom-level 'small'
    success "Nautilus file manager configured"
    
    # Screenshot settings
    mkdir -p "$HOME/Pictures/Screenshots"
    gsettings set org.gnome.gnome-screenshot auto-save-directory "$HOME/Pictures/Screenshots"
    success "Screenshot settings configured"
    
    # Terminal preferences
    gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
    success "Terminal preferences configured"
    
    # Window management
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
    gsettings set org.gnome.desktop.wm.preferences focus-mode 'click'
    success "Window management configured"
}

# System optimizations
setup_system_optimizations() {
    log "Applying system optimizations..."
    
    # Reduce swappiness
    if ! grep -q "vm.swappiness=10" /etc/sysctl.conf; then
        echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
        success "Swappiness reduced to 10"
    fi
    
    # Enable firewall
    if ! sudo ufw status | grep -q "Status: active"; then
        sudo ufw enable
        success "UFW firewall enabled"
    fi
    
    # Install essential packages
    sudo apt install -y software-properties-common apt-transport-https ca-certificates gnupg lsb-release
    success "Essential packages installed"
}

# Install media codecs
install_media_codecs() {
    log "Installing media codecs..."
    sudo apt install -y ubuntu-restricted-extras
    success "Media codecs installed"
}

# Configure Git (if not already configured)
setup_git_basic() {
    if ! git config --global user.name > /dev/null 2>&1; then
        log "Setting up basic Git configuration..."
        read -p "Enter your Git global user.name: " git_name
        git config --global user.name "$git_name"
        read -p "Enter your Git global user.email: " git_email
        git config --global user.email "$git_email"
        success "Basic Git configuration complete"
    fi
}

# Install additional fonts
install_fonts() {
    log "Installing additional fonts..."
    sudo apt install -y fonts-firacode fonts-powerline fonts-noto-color-emoji
    
    # Install Nerd Fonts
    if [[ ! -d "$HOME/.local/share/fonts" ]]; then
        mkdir -p "$HOME/.local/share/fonts"
    fi
    
    # Download and install Hack Nerd Font
    if [[ ! -f "$HOME/.local/share/fonts/Hack Regular Nerd Font Complete.ttf" ]]; then
        cd /tmp
        wget -O hack-nerd-font.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Hack.zip
        unzip -o hack-nerd-font.zip -d "$HOME/.local/share/fonts/"
        fc-cache -fv
        rm hack-nerd-font.zip
        success "Hack Nerd Font installed"
    fi
}

# Main execution
main() {
    log "🚀 Starting Ubuntu System Preferences Setup"
    
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
    
    confirm "Update system packages?" && update_system
    confirm "Configure GNOME desktop preferences?" && setup_gnome_preferences
    confirm "Apply system optimizations?" && setup_system_optimizations
    confirm "Install media codecs?" && install_media_codecs
    confirm "Set up basic Git configuration?" && setup_git_basic
    confirm "Install additional fonts?" && install_fonts
    
    success "🎉 Ubuntu system preferences setup complete!"
    log "Please reboot your system to ensure all changes take effect"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
