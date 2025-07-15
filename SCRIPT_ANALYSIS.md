# Ubuntu Setup Scripts Analysis and Categorization

## Overview
This document analyzes Ubuntu development environment setup scripts and categorizes their functionalities for creating modular scripts. The analysis covers Ubuntu-specific configurations, package management, and development environment setup.

## Scripts Structure
1. `01_system_prefs.sh` - Ubuntu System Preferences and Tweaks
2. `02_package_mgmt.sh` - Package Management (APT, Snap, Flatpak)
3. `03_dev_env.sh` - Development Environment Setup
4. `04_mobile_dev.sh` - Mobile Development Tools
5. `05_cloud_devops.sh` - Cloud and DevOps Tools
6. `06_workspace_setup.sh` - Directory Structure and Workspace
7. `07_startup_launcher.sh` - Application Launcher and Services
8. `setup_master.sh` - Master Orchestration Script

## Functional Categories

### 1. SYSTEM PREFERENCES & TWEAKS
Ubuntu-specific configurations and system enhancements:

**Desktop Environment Settings:**
```bash
# Set dark theme
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Dock/Panel preferences
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

# File manager settings
gsettings set org.gnome.nautilus.preferences show-hidden-files true
gsettings set org.gnome.nautilus.preferences show-image-thumbnails 'always'
gsettings set org.gnome.nautilus.list-view default-zoom-level 'small'

# Screenshot format
gsettings set org.gnome.gnome-screenshot auto-save-directory "$HOME/Pictures/Screenshots"

# Terminal preferences
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false
```

**System Optimizations:**
```bash
# Reduce swappiness
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf

# Enable firewall
sudo ufw enable

# Update system
sudo apt update && sudo apt upgrade -y
```

### 2. PACKAGE MANAGEMENT
**APT Package Installation:**
```bash
# Update package lists
sudo apt update

# Core development tools
sudo apt install -y git wget curl build-essential

# Development languages
sudo apt install -y python3 python3-pip python3-venv nodejs npm

# System utilities
sudo apt install -y htop neofetch tree exa bat fd-find ripgrep

# Media codecs
sudo apt install -y ubuntu-restricted-extras

# Archive tools
sudo apt install -y zip unzip p7zip-full p7zip-rar
```

**Snap Package Installation:**
```bash
# Enable snapd
sudo apt install -y snapd

# Development tools
sudo snap install --classic code
sudo snap install --classic android-studio
sudo snap install --classic flutter

# Applications
sudo snap install firefox
sudo snap install discord
sudo snap install obs-studio
sudo snap install vlc
```

**Flatpak Installation:**
```bash
# Install flatpak
sudo apt install -y flatpak

# Add flathub repository
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install applications
flatpak install -y flathub org.signal.Signal
flatpak install -y flathub com.slack.Slack
flatpak install -y flathub org.gimp.GIMP
```

### 3. DEVELOPMENT ENVIRONMENT SETUP
**Git Configuration:**
```bash
# User setup (interactive)
read -p "Enter your Git global user.name: " git_name
git config --global user.name "$git_name"
read -p "Enter your Git global user.email: " git_email
git config --global user.email "$git_email"

# Editor and tools
git config --global core.editor "vim"
git config --global init.defaultBranch main
git config --global pull.rebase true

# Aliases
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global alias.st "status"
git config --global alias.co "checkout"
git config --global alias.br "branch"
```

**Shell Environment Setup:**
```bash
# Install Zsh
sudo apt install -y zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Configure plugins
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

### 4. RUNTIME SETUP
**Node.js & NVM:**
```bash
# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Source NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node.js
nvm install --lts
nvm install 18
nvm use --lts

# Global packages
npm install -g pnpm yarn commitizen @vue/cli @angular/cli
```

**Python Environment:**
```bash
# Install Python 3.11
sudo apt install -y python3.11 python3.11-pip python3.11-venv

# Create virtual environment
python3.11 -m venv ~/ai-dev
source ~/ai-dev/bin/activate

# Install packages
pip install --upgrade pip
pip install numpy pandas scipy matplotlib jupyter torch tensorflow transformers
```

### 5. MOBILE DEVELOPMENT
**Flutter Setup:**
```bash
# Install via snap
sudo snap install --classic flutter

# Configure
flutter config --enable-linux-desktop
flutter config --enable-android
flutter doctor

# Accept Android licenses
flutter doctor --android-licenses
```

**Android SDK:**
```bash
# Install Android Studio
sudo snap install --classic android-studio

# Set environment variables
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

### 6. CONTAINER & KUBERNETES
**Docker Installation:**
```bash
# Install Docker
sudo apt install -y docker.io docker-compose

# Add user to docker group
sudo usermod -aG docker $USER

# Start Docker service
sudo systemctl enable docker
sudo systemctl start docker
```

**Kubernetes Tools:**
```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Install k9s
curl -sS https://webinstall.dev/k9s | bash

# Install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube /usr/local/bin/
```

### 7. DIRECTORY STRUCTURE
**Development Workspace:**
```bash
# Create workspace directories
mkdir -p ~/workspace/{00_org,10_projects,20_assets,30_docs,40_ops,70_data,99_tmp}

# Traditional dev structure
mkdir -p ~/Projects/{web,mobile,backend,devops,scripts}
mkdir -p ~/AI/{models,datasets,notebooks,experiments}

# Local bins and configs
mkdir -p ~/.local/bin ~/.config
```

### 8. APPLICATION LAUNCHER
**GUI Applications:**
```bash
# Development tools
code &
android-studio &

# Browsers
firefox &
google-chrome &

# Communication
slack &
discord &

# Terminal
gnome-terminal &
```

**Service Management:**
```bash
# Start Docker
sudo systemctl start docker

# Start SSH agent
eval "$(ssh-agent -s)"

# Activate Python environment
source ~/ai-dev/bin/activate
```

## Ubuntu-Specific Considerations

### Desktop Environment Differences
- **GNOME**: Default Ubuntu desktop, uses `gsettings` for configuration
- **KDE**: Alternative desktop, uses different configuration tools
- **XFCE**: Lightweight option, different settings approach

### Package Management Hierarchy
1. **APT**: Primary package manager, use for system packages
2. **Snap**: Universal packages, good for development tools
3. **Flatpak**: Sandboxed applications, good for GUI apps
4. **AppImage**: Portable applications, manual installation

### Security Considerations
- **Firewall**: UFW (Uncomplicated Firewall) enabled by default
- **SSH**: Generate secure keys with proper permissions
- **Sudo**: Proper sudo configuration for development tools

## Script Modularity

Each script includes:
- Error handling with `set -e`
- Interactive confirmation prompts
- Logging with timestamps
- Idempotent operations
- Cleanup functions
- Progress indicators

## Recommended Execution Order

1. **01_system_prefs.sh** - System tweaks and preferences
2. **02_package_mgmt.sh** - Install packages and applications
3. **03_dev_env.sh** - Development environment setup
4. **04_mobile_dev.sh** - Mobile development tools
5. **05_cloud_devops.sh** - Cloud and DevOps tools
6. **06_workspace_setup.sh** - Directory structure
7. **07_startup_launcher.sh** - Application launcher
