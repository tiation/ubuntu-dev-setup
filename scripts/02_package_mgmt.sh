#!/bin/bash

# Ubuntu Package Management Script
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

# Install APT packages
install_apt_packages() {
    log "Installing APT packages..."
    
    # Update package lists
    sudo apt update
    
    # Core development tools
    local apt_packages=(
        "build-essential"
        "git"
        "curl"
        "wget"
        "vim"
        "neovim"
        "htop"
        "tree"
        "unzip"
        "zip"
        "p7zip-full"
        "p7zip-rar"
        "software-properties-common"
        "apt-transport-https"
        "ca-certificates"
        "gnupg"
        "lsb-release"
        "jq"
        "ripgrep"
        "fd-find"
        "bat"
        "exa"
        "net-tools"
        "openssh-client"
        "openssh-server"
        "zsh"
        "tmux"
        "python3"
        "python3-pip"
        "python3-venv"
        "nodejs"
        "npm"
        "default-jdk"
        "docker.io"
        "docker-compose"
        "sqlite3"
        "postgresql-client"
        "mysql-client"
        "redis-tools"
        "imagemagick"
        "ffmpeg"
        "vlc"
        "gimp"
        "inkscape"
        "libreoffice"
        "thunderbird"
        "firefox"
        "chromium-browser"
        "terminator"
        "tilix"
        "code"
        "flatpak"
        "snapd"
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

# Install Snap packages
install_snap_packages() {
    log "Installing Snap packages..."
    
    # Ensure snapd is running
    sudo systemctl start snapd
    sudo systemctl enable snapd
    
    local snap_packages=(
        "code --classic"
        "flutter --classic"
        "android-studio --classic"
        "discord"
        "slack --classic"
        "obs-studio"
        "postman"
        "insomnia"
        "bitwarden"
        "telegram-desktop"
        "whatsapp-for-linux"
        "spotify"
        "vlc"
        "gimp"
        "inkscape"
        "blender --classic"
        "figma-linux"
        "zoom-client"
        "skype --classic"
        "teams-for-linux"
        "notion-snap"
        "drawio"
        "datagrip --classic"
        "intellij-idea-community --classic"
        "pycharm-community --classic"
        "webstorm --classic"
        "rider --classic"
        "goland --classic"
        "phpstorm --classic"
        "rubymine --classic"
        "clion --classic"
        "kubectl --classic"
        "helm --classic"
        "docker --classic"
        "microk8s --classic"
        "node --classic"
        "go --classic"
        "rustup --classic"
        "dotnet-sdk --classic"
        "heroku --classic"
        "aws-cli --classic"
        "gcloud --classic"
        "azure-cli --classic"
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

# Install Flatpak packages
install_flatpak_packages() {
    log "Installing Flatpak packages..."
    
    # Add Flathub repository
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    
    local flatpak_packages=(
        "org.signal.Signal"
        "com.slack.Slack"
        "org.gimp.GIMP"
        "org.inkscape.Inkscape"
        "org.blender.Blender"
        "com.obsproject.Studio"
        "org.audacityteam.Audacity"
        "org.videolan.VLC"
        "com.spotify.Client"
        "org.telegram.desktop"
        "com.discordapp.Discord"
        "com.github.IsmaelMartinez.teams_for_linux"
        "us.zoom.Zoom"
        "com.skype.Client"
        "md.obsidian.Obsidian"
        "com.notion.Notion"
        "org.mozilla.Firefox"
        "com.google.Chrome"
        "com.brave.Browser"
        "org.torproject.torbrowser-launcher"
        "com.microsoft.Edge"
        "com.github.tchx84.Flatseal"
        "org.gnome.Extensions"
        "com.mattjakeman.ExtensionManager"
        "org.gnome.Tweaks"
        "com.github.wwmm.easyeffects"
        "org.gnome.SoundRecorder"
        "org.gnome.Calculator"
        "org.gnome.Calendar"
        "org.gnome.Weather"
        "org.gnome.Maps"
        "org.gnome.Photos"
        "org.gnome.TextEditor"
        "org.gnome.FileRoller"
        "org.gnome.Evince"
        "org.libreoffice.LibreOffice"
        "org.thunderbird.Thunderbird"
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

# Install additional repositories
setup_additional_repos() {
    log "Setting up additional repositories..."
    
    # Google Chrome repository
    if [[ ! -f /etc/apt/sources.list.d/google-chrome.list ]]; then
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
        success "Google Chrome repository added"
    fi
    
    # Microsoft repository (for VS Code, Edge, etc.)
    if [[ ! -f /etc/apt/sources.list.d/vscode.list ]]; then
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        success "Microsoft repository added"
    fi
    
    # Docker repository
    if [[ ! -f /etc/apt/sources.list.d/docker.list ]]; then
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        success "Docker repository added"
    fi
    
    # Update package lists after adding repositories
    sudo apt update
    success "Additional repositories setup complete"
}

# Install from .deb files
install_deb_packages() {
    log "Installing .deb packages..."
    
    cd /tmp
    
    # Discord
    if ! dpkg -l | grep -q "discord"; then
        wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
        sudo dpkg -i discord.deb || sudo apt-get install -f -y
        rm discord.deb
        success "Discord installed"
    fi
    
    # Zoom
    if ! dpkg -l | grep -q "zoom"; then
        wget -O zoom.deb "https://zoom.us/client/latest/zoom_amd64.deb"
        sudo dpkg -i zoom.deb || sudo apt-get install -f -y
        rm zoom.deb
        success "Zoom installed"
    fi
    
    success ".deb packages installation complete"
}

# Configure package managers
configure_package_managers() {
    log "Configuring package managers..."
    
    # Configure Docker group
    if ! groups | grep -q docker; then
        sudo usermod -aG docker "$USER"
        success "User added to docker group"
    fi
    
    # Configure npm
    if command -v npm > /dev/null 2>&1; then
        mkdir -p ~/.npm-global
        npm config set prefix '~/.npm-global'
        success "NPM configured"
    fi
    
    success "Package managers configuration complete"
}

# Clean up package caches
cleanup_packages() {
    log "Cleaning up package caches..."
    
    sudo apt autoremove -y
    sudo apt autoclean
    sudo snap refresh
    
    success "Package cleanup complete"
}

# Main execution
main() {
    log "🚀 Starting Ubuntu Package Management Setup"
    
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
    
    confirm "Set up additional repositories?" && setup_additional_repos
    confirm "Install APT packages?" && install_apt_packages
    confirm "Install Snap packages?" && install_snap_packages
    confirm "Install Flatpak packages?" && install_flatpak_packages
    confirm "Install .deb packages?" && install_deb_packages
    confirm "Configure package managers?" && configure_package_managers
    confirm "Clean up package caches?" && cleanup_packages
    
    success "🎉 Ubuntu package management setup complete!"
    log "Please log out and log back in to apply group changes"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
