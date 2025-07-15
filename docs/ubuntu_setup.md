# Ubuntu Development Environment Setup Guide

This guide provides detailed instructions for setting up a complete development environment on Ubuntu systems using the automated scripts.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Setup](#detailed-setup)
- [Script Overview](#script-overview)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Post-Setup](#post-setup)

## Prerequisites

### System Requirements

- **Ubuntu 20.04 LTS or later**
- **Internet connection** for downloading packages
- **User with sudo privileges**
- **At least 10GB free disk space**

### Before You Begin

1. **Update your system**:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Install Git** (if not already installed):
   ```bash
   sudo apt install git -y
   ```

3. **Clone the repository**:
   ```bash
   git clone https://github.com/tiation/ubuntu-dev-setup.git
   cd ubuntu-dev-setup
   ```

4. **Make scripts executable**:
   ```bash
   chmod +x scripts/*.sh
   ```

## Quick Start

### Option 1: Complete Automated Setup

Run everything automatically without prompts:

```bash
./scripts/setup_master.sh --auto
```

### Option 2: Interactive Setup

Run the master script with prompts for each component:

```bash
./scripts/setup_master.sh
```

### Option 3: Individual Scripts

Run specific setup scripts as needed:

```bash
# System preferences
./scripts/01_system_prefs.sh

# Package management
./scripts/02_package_mgmt.sh

# Development environment
./scripts/03_dev_env.sh
```

## Detailed Setup

### 1. System Preferences & Tweaks

**Script**: `01_system_prefs.sh`

**What it does**:
- Enables dark theme
- Configures GNOME settings
- Optimizes system performance
- Installs media codecs
- Sets up basic Git configuration
- Installs additional fonts

**Manual run**:
```bash
./scripts/01_system_prefs.sh
```

### 2. Package Management

**Script**: `02_package_mgmt.sh`

**What it does**:
- Installs APT packages (development tools, utilities)
- Installs Snap packages (development applications)
- Installs Flatpak packages (GUI applications)
- Configures additional repositories
- Installs .deb packages (Discord, Zoom)

**Manual run**:
```bash
./scripts/02_package_mgmt.sh
```

### 3. Development Environment

**Script**: `03_dev_env.sh`

**What it does**:
- Configures Git with user information and aliases
- Generates SSH keys
- Installs and configures Zsh with Oh My Zsh
- Sets up Node.js and NVM
- Creates Python virtual environments
- Configures shell aliases and functions
- Sets up development environment variables

**Manual run**:
```bash
./scripts/03_dev_env.sh
```

### 4. Mobile Development

**Script**: `04_mobile_dev.sh`

**What it does**:
- Installs Java Development Kit
- Installs Flutter SDK
- Installs Android Studio and SDK
- Sets up React Native CLI
- Installs Ionic and Cordova
- Configures mobile development utilities
- Installs VS Code extensions

**Manual run**:
```bash
./scripts/04_mobile_dev.sh
```

### 5. Workspace Setup

**Script**: `06_workspace_setup.sh`

**What it does**:
- Creates organized workspace directory structure
- Sets up project templates
- Creates development scripts
- Configures workspace environment variables
- Generates comprehensive documentation

**Manual run**:
```bash
./scripts/06_workspace_setup.sh
```

## Script Overview

### Master Script Features

The `setup_master.sh` script provides:

- **Interactive menu** for selecting components
- **Auto-run mode** for unattended installation
- **Progress tracking** with success/failure reporting
- **Error handling** and recovery options
- **Completion report** with next steps

### Individual Script Features

Each script includes:

- **Modular design** for specific functionality
- **Error handling** with detailed logging
- **Idempotent operations** (safe to run multiple times)
- **Interactive confirmations** or auto-run support
- **Progress indicators** and status messages

## Customization

### Modifying Package Lists

Edit the package arrays in `02_package_mgmt.sh`:

```bash
# Add or remove APT packages
local apt_packages=(
    "existing-package"
    "your-new-package"
)

# Add or remove Snap packages
local snap_packages=(
    "existing-package --classic"
    "your-new-package"
)
```

### Customizing Git Configuration

Modify the Git setup in `03_dev_env.sh`:

```bash
# Add custom Git aliases
git config --global alias.your-alias "your-command"

# Change default editor
git config --global core.editor "your-editor"
```

### Adding Custom Scripts

1. Create a new script following the template
2. Add it to the master script's array
3. Update documentation

### Workspace Structure

Customize the workspace structure in `06_workspace_setup.sh`:

```bash
# Modify directory structure
mkdir -p ~/workspace/{your-custom-dirs}
```

## Troubleshooting

### Common Issues

#### Permission Errors
```bash
# Fix script permissions
chmod +x scripts/*.sh

# Check sudo access
sudo -v
```

#### Package Installation Failures
```bash
# Update package lists
sudo apt update

# Fix broken packages
sudo apt --fix-broken install

# Clear package cache
sudo apt clean
```

#### Git Configuration Issues
```bash
# Check Git configuration
git config --list

# Reset Git configuration
git config --global --unset user.name
git config --global --unset user.email
```

#### SSH Key Problems
```bash
# Check SSH agent
eval "$(ssh-agent -s)"

# Add SSH key
ssh-add ~/.ssh/id_ed25519

# Test SSH connection
ssh -T git@github.com
```

### Getting Help

1. **Check the logs** for error messages
2. **Run individual scripts** to isolate issues
3. **Review the documentation** for specific components
4. **Open an issue** on GitHub with:
   - Ubuntu version
   - Error messages
   - Steps to reproduce

## Post-Setup

### Essential Next Steps

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Add SSH key to GitHub/GitLab**:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

3. **Log out and log back in** to apply group changes (Docker, etc.)

4. **Test your setup**:
   ```bash
   # Test Node.js
   node --version
   npm --version
   
   # Test Python
   python3 --version
   pip3 --version
   
   # Test Docker
   docker --version
   docker run hello-world
   
   # Test Flutter (if installed)
   flutter doctor
   ```

### Workspace Usage

After setup, you can use these commands:

```bash
# Navigate to workspace
ws

# List projects
lsprojects

# Create new project
newproject

# Backup projects
backup_projects

# Work on specific project
workon project-name
```

### Development Workflow

1. **Create a new project**:
   ```bash
   newproject
   ```

2. **Navigate to project**:
   ```bash
   cd ~/workspace/10_projects/web/my-project
   ```

3. **Open in VS Code**:
   ```bash
   code .
   ```

4. **Start development**:
   ```bash
   npm start  # or python main.py, etc.
   ```

### Maintenance

#### Regular Updates

```bash
# Update system packages
sudo apt update && sudo apt upgrade -y

# Update Snap packages
sudo snap refresh

# Update Flatpak packages
flatpak update

# Update npm packages
npm update -g

# Update Python packages
pip3 list --outdated
```

#### Backup Your Work

```bash
# Backup projects
backup_projects

# Backup configurations
cp -r ~/.config ~/workspace/70_data/backups/config-$(date +%Y%m%d)
```

## Additional Resources

- **GitHub Repository**: https://github.com/tiation/ubuntu-dev-setup
- **Ubuntu Documentation**: https://ubuntu.com/server/docs
- **Development Tools**: Check individual tool documentation
- **Community Support**: GitHub Issues and Discussions

---

**Happy coding on Ubuntu! 🚀**
