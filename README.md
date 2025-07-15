# Ubuntu Development Environment Setup

🚀 **Automated Ubuntu Development Environment Setup Scripts**

A comprehensive collection of modular scripts to set up a complete development environment on Ubuntu systems. Perfect for developers who want to quickly bootstrap their Ubuntu workstation with all essential tools and configurations.

## 🎯 What This Does

- **System Configuration**: Ubuntu system preferences and tweaks
- **Package Management**: APT packages, Snap packages, and Flatpak applications
- **Development Environment**: Git, SSH, shell configuration (Zsh + Oh My Zsh)
- **Runtime Setup**: Node.js, Python, language-specific environments
- **Mobile Development**: Flutter, Android SDK setup
- **Container & Kubernetes**: Docker, Kubernetes tools
- **Directory Structure**: Organized development workspace
- **Application Launcher**: GUI app and service startup automation

## 📁 Repository Structure

```
ubuntu-dev-setup/
├── scripts/
│   ├── 01_system_prefs.sh      # System preferences and tweaks
│   ├── 02_package_mgmt.sh      # Package installation (APT/Snap/Flatpak)
│   ├── 03_dev_env.sh           # Development environment setup
│   ├── 04_mobile_dev.sh        # Mobile development tools
│   ├── 05_cloud_devops.sh      # Cloud and DevOps tools
│   ├── 06_workspace_setup.sh   # Directory structure and workspace
│   ├── 07_startup_launcher.sh  # Application startup automation
│   └── setup_master.sh         # Master orchestration script
├── docs/
│   └── ubuntu_setup.md         # Detailed setup documentation
├── README.md                   # This file
├── SCRIPT_ANALYSIS.md          # Script analysis and categorization
├── FUNCTIONS_REFERENCE.md      # Common functions reference
└── LICENSE                     # MIT License
```

## 🚀 Quick Start

### Option 1: Run Everything (Recommended for new setups)
```bash
git clone https://github.com/yourusername/ubuntu-dev-setup.git
cd ubuntu-dev-setup
chmod +x scripts/*.sh
./scripts/setup_master.sh
```

### Option 2: Run Individual Modules
```bash
# System preferences and tweaks
./scripts/01_system_prefs.sh

# Install packages
./scripts/02_package_mgmt.sh

# Development environment
./scripts/03_dev_env.sh

# Mobile development tools
./scripts/04_mobile_dev.sh

# Cloud and DevOps tools
./scripts/05_cloud_devops.sh

# Workspace setup
./scripts/06_workspace_setup.sh

# Application launcher
./scripts/07_startup_launcher.sh
```

### Option 3: Auto-run Mode (No prompts)
```bash
./scripts/setup_master.sh --auto
```

## 🛠️ What Gets Installed

### Core Development Tools
- **Version Control**: Git, GitHub CLI
- **Editors**: VS Code, Vim/Neovim
- **Terminals**: Terminator, Tilix
- **Languages**: Node.js (via NVM), Python 3.11, Java, .NET

### Development Frameworks
- **Frontend**: React, Vue, Angular tooling
- **Backend**: Node.js, Python frameworks
- **Mobile**: Flutter, Android SDK
- **Containers**: Docker, Docker Compose, Kubernetes tools

### Productivity Applications
- **Browsers**: Firefox, Chrome, Brave
- **Communication**: Slack, Discord, Signal
- **Media**: VLC, OBS Studio
- **Utilities**: Raycast alternative (Ulauncher), Rectangle alternative (gTile)

### System Enhancements
- **Shell**: Zsh with Oh My Zsh, Starship prompt
- **File Management**: Improved file managers, better defaults
- **Shortcuts**: Custom keyboard shortcuts and aliases
- **Themes**: Dark mode, icon themes, fonts

## 🔧 Customization

Each script is modular and can be customized:

1. **Edit variables** at the top of each script
2. **Comment out** sections you don't need
3. **Add your own** package lists or configurations
4. **Modify prompts** for different confirmation behavior

## 📋 Prerequisites

- Ubuntu 20.04 LTS or later
- Internet connection
- User with sudo privileges
- Basic terminal knowledge

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on a clean Ubuntu installation
5. Submit a pull request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## 📖 Documentation

- [Detailed Setup Guide](docs/ubuntu_setup.md)
- [Script Analysis](SCRIPT_ANALYSIS.md)
- [Functions Reference](FUNCTIONS_REFERENCE.md)

## 🔒 Security

- Scripts use official package repositories
- SSH keys are generated with secure defaults
- Environment variables are handled safely
- No credentials are stored in scripts

## 📜 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by various Ubuntu setup scripts and dotfiles
- Built for developers who value automation and consistency
- Designed with security and modularity in mind

---

**⚡ Ready to supercharge your Ubuntu development environment?**

```bash
git clone https://github.com/yourusername/ubuntu-dev-setup.git && cd ubuntu-dev-setup && ./scripts/setup_master.sh
```
