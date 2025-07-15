#!/bin/bash

# Ubuntu Mobile Development Tools Script
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

# Install Flutter
install_flutter() {
    log "Installing Flutter..."
    
    # Install Flutter via snap (recommended for Linux)
    if ! command -v flutter > /dev/null 2>&1; then
        sudo snap install flutter --classic
        success "Flutter installed via snap"
    else
        log "Flutter is already installed"
    fi
    
    # Configure Flutter
    flutter config --enable-linux-desktop
    flutter config --enable-android
    flutter config --no-analytics
    
    # Run Flutter doctor
    flutter doctor
    
    success "Flutter setup complete"
}

# Install Android Studio and Android SDK
install_android_development() {
    log "Installing Android development tools..."
    
    # Install Android Studio via snap
    if ! command -v android-studio > /dev/null 2>&1; then
        sudo snap install android-studio --classic
        success "Android Studio installed"
    else
        log "Android Studio is already installed"
    fi
    
    # Set up Android SDK environment variables
    local android_home="$HOME/Android/Sdk"
    
    # Create Android SDK directory
    mkdir -p "$android_home"
    
    # Add Android environment variables to shell profiles
    for profile in ~/.bashrc ~/.zshrc; do
        if [[ -f "$profile" ]] && ! grep -q "ANDROID_HOME" "$profile"; then
            cat >> "$profile" << EOF

# Android SDK
export ANDROID_HOME="$android_home"
export PATH="\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="\$PATH:\$ANDROID_HOME/platform-tools"
export PATH="\$PATH:\$ANDROID_HOME/tools"
export PATH="\$PATH:\$ANDROID_HOME/tools/bin"
EOF
        fi
    done
    
    success "Android development tools setup complete"
}

# Install Java Development Kit
install_java() {
    log "Installing Java Development Kit..."
    
    # Install OpenJDK 11 (recommended for Android development)
    sudo apt update
    sudo apt install -y openjdk-11-jdk openjdk-11-jre
    
    # Set JAVA_HOME
    local java_home="/usr/lib/jvm/java-11-openjdk-amd64"
    
    for profile in ~/.bashrc ~/.zshrc; do
        if [[ -f "$profile" ]] && ! grep -q "JAVA_HOME" "$profile"; then
            echo "export JAVA_HOME=\"$java_home\"" >> "$profile"
        fi
    done
    
    success "Java Development Kit installed"
}

# Install React Native CLI
install_react_native() {
    log "Installing React Native CLI..."
    
    # Install React Native CLI globally
    if command -v npm > /dev/null 2>&1; then
        npm install -g @react-native-community/cli
        success "React Native CLI installed"
    else
        warning "npm not found. Please install Node.js first"
    fi
}

# Install Ionic CLI
install_ionic() {
    log "Installing Ionic CLI..."
    
    # Install Ionic CLI globally
    if command -v npm > /dev/null 2>&1; then
        npm install -g @ionic/cli
        success "Ionic CLI installed"
    else
        warning "npm not found. Please install Node.js first"
    fi
}

# Install Cordova CLI
install_cordova() {
    log "Installing Cordova CLI..."
    
    # Install Cordova CLI globally
    if command -v npm > /dev/null 2>&1; then
        npm install -g cordova
        success "Cordova CLI installed"
    else
        warning "npm not found. Please install Node.js first"
    fi
}

# Install mobile development utilities
install_mobile_utilities() {
    log "Installing mobile development utilities..."
    
    # Install ADB (Android Debug Bridge)
    sudo apt install -y android-tools-adb android-tools-fastboot
    
    # Install scrcpy for Android screen mirroring
    sudo apt install -y scrcpy
    
    # Install Genymotion dependencies
    sudo apt install -y virtualbox
    
    success "Mobile development utilities installed"
}

# Setup Android SDK licenses
setup_android_licenses() {
    log "Setting up Android SDK licenses..."
    
    # Accept all Android SDK licenses
    if command -v flutter > /dev/null 2>&1; then
        flutter doctor --android-licenses
        success "Android SDK licenses accepted"
    else
        warning "Flutter not found. Please install Flutter first"
    fi
}

# Install mobile development VS Code extensions
install_vscode_extensions() {
    log "Installing VS Code extensions for mobile development..."
    
    if command -v code > /dev/null 2>&1; then
        # Flutter and Dart extensions
        code --install-extension dart-code.flutter
        code --install-extension dart-code.dart-code
        
        # React Native extensions
        code --install-extension msjsdiag.vscode-react-native
        code --install-extension ms-vscode.vscode-typescript-next
        
        # Ionic extensions
        code --install-extension ionic.ionic
        
        # Android development extensions
        code --install-extension mathiasfrohlich.kotlin
        code --install-extension redhat.java
        code --install-extension vscjava.vscode-java-pack
        
        success "VS Code extensions installed"
    else
        warning "VS Code not found. Extensions will be skipped"
    fi
}

# Create mobile development project directories
create_mobile_directories() {
    log "Creating mobile development directories..."
    
    # Create directory structure
    mkdir -p ~/workspace/10_projects/mobile/{flutter,react-native,ionic,cordova,android,ios}
    mkdir -p ~/workspace/10_projects/mobile/templates
    mkdir -p ~/workspace/10_projects/mobile/tools
    
    success "Mobile development directories created"
}

# Main execution
main() {
    log "🚀 Starting Ubuntu Mobile Development Setup"
    
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
    
    confirm "Install Java Development Kit?" && install_java
    confirm "Install Flutter?" && install_flutter
    confirm "Install Android Studio and SDK?" && install_android_development
    confirm "Setup Android SDK licenses?" && setup_android_licenses
    confirm "Install React Native CLI?" && install_react_native
    confirm "Install Ionic CLI?" && install_ionic
    confirm "Install Cordova CLI?" && install_cordova
    confirm "Install mobile development utilities?" && install_mobile_utilities
    confirm "Install VS Code extensions?" && install_vscode_extensions
    confirm "Create mobile development directories?" && create_mobile_directories
    
    success "🎉 Ubuntu mobile development setup complete!"
    log "Please restart your terminal to apply environment variable changes"
    log "Run 'flutter doctor' to verify your Flutter installation"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
