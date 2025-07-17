---
layout: default
title: Quick Start Guide
---

# 🚀 Quick Start Guide

Get your Ubuntu development environment up and running in minutes with our automated setup scripts.

## Prerequisites

<div class="info">
  <div class="info-title">System Requirements</div>
  <ul>
    <li>Ubuntu 20.04 LTS or later</li>
    <li>Internet connection</li>
    <li>User with sudo privileges</li>
    <li>At least 4GB of free disk space</li>
  </ul>
</div>

## Installation Methods

### Method 1: One-Line Install (Recommended)

<div class="command-block">
  <div class="command-title">Quick Install</div>
  <code>curl -fsSL https://raw.githubusercontent.com/tiation/ubuntu-dev-setup/main/install.sh | bash</code>
</div>

### Method 2: Manual Clone and Run

<div class="command-block">
  <div class="command-title">Clone and Execute</div>
  <code>git clone https://github.com/tiation/ubuntu-dev-setup.git<br>
cd ubuntu-dev-setup<br>
chmod +x scripts/*.sh<br>
./scripts/setup_master.sh</code>
</div>

### Method 3: Selective Installation

Run individual modules based on your needs:

<div class="grid">
  <div class="card">
    <div class="card-header">
      <span class="card-icon">⚙️</span>
      <h3 class="card-title">System Setup</h3>
    </div>
    <div class="command-block">
      <code>./scripts/01_system_prefs.sh</code>
    </div>
    <p>Configure system preferences and essential tweaks</p>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">📦</span>
      <h3 class="card-title">Package Management</h3>
    </div>
    <div class="command-block">
      <code>./scripts/02_package_mgmt.sh</code>
    </div>
    <p>Install APT packages, Snap packages, and Flatpak applications</p>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">💻</span>
      <h3 class="card-title">Development Environment</h3>
    </div>
    <div class="command-block">
      <code>./scripts/03_dev_env.sh</code>
    </div>
    <p>Set up Git, SSH, shell configuration, and development tools</p>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">📱</span>
      <h3 class="card-title">Mobile Development</h3>
    </div>
    <div class="command-block">
      <code>./scripts/04_mobile_dev.sh</code>
    </div>
    <p>Install Flutter, Android SDK, and mobile development tools</p>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">☁️</span>
      <h3 class="card-title">Cloud & DevOps</h3>
    </div>
    <div class="command-block">
      <code>./scripts/05_cloud_devops.sh</code>
    </div>
    <p>Install Docker, Kubernetes tools, and cloud utilities</p>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">🗂️</span>
      <h3 class="card-title">Workspace Setup</h3>
    </div>
    <div class="command-block">
      <code>./scripts/06_workspace_setup.sh</code>
    </div>
    <p>Create organized development directory structure</p>
  </div>
</div>

## Silent Installation

For automated setups or CI/CD pipelines:

<div class="command-block">
  <div class="command-title">Auto Mode (No Prompts)</div>
  <code>./scripts/setup_master.sh --auto</code>
</div>

## What Happens During Installation

<div class="tip">
  <div class="tip-title">Installation Process</div>
  <ol>
    <li><strong>System Update:</strong> Updates package lists and upgrades system</li>
    <li><strong>Repository Setup:</strong> Adds necessary PPAs and repositories</li>
    <li><strong>Package Installation:</strong> Installs development tools and applications</li>
    <li><strong>Environment Configuration:</strong> Sets up shell, Git, and SSH</li>
    <li><strong>Directory Creation:</strong> Creates organized workspace structure</li>
    <li><strong>Service Setup:</strong> Configures and starts necessary services</li>
    <li><strong>Final Verification:</strong> Verifies installations and configurations</li>
  </ol>
</div>

## Post-Installation Steps

After the installation completes:

### 1. Restart Your Session

<div class="command-block">
  <div class="command-title">Logout and Login</div>
  <code>gnome-session-quit --logout --no-prompt</code>
</div>

### 2. Verify Installation

<div class="command-block">
  <div class="command-title">Check Installed Tools</div>
  <code>node --version<br>
python3 --version<br>
docker --version<br>
git --version</code>
</div>

### 3. Configure Git (If Not Done Already)

<div class="command-block">
  <div class="command-title">Git Configuration</div>
  <code>git config --global user.name "Your Name"<br>
git config --global user.email "your.email@example.com"</code>
</div>

### 4. Generate SSH Key (Optional)

<div class="command-block">
  <div class="command-title">SSH Key Generation</div>
  <code>ssh-keygen -t rsa -b 4096 -C "your.email@example.com"</code>
</div>

## Customization

### Before Installation

Edit the script variables to customize your installation:

<div class="command-block">
  <div class="command-title">Edit Configuration</div>
  <code>nano scripts/setup_master.sh</code>
</div>

### Key Variables to Customize

```bash
# Package lists
APT_PACKAGES="git curl wget vim"
SNAP_PACKAGES="code discord"
FLATPAK_PACKAGES="com.spotify.Client"

# Development tools
INSTALL_NODEJS=true
INSTALL_PYTHON=true
INSTALL_DOCKER=true
INSTALL_FLUTTER=false

# Shell configuration
INSTALL_ZSH=true
INSTALL_OH_MY_ZSH=true
```

## Troubleshooting

### Common Issues

<div class="warning">
  <div class="warning-title">Permission Errors</div>
  Ensure you have sudo privileges and the scripts are executable:
  <div class="command-block">
    <code>chmod +x scripts/*.sh</code>
  </div>
</div>

<div class="warning">
  <div class="warning-title">Network Issues</div>
  Check your internet connection and proxy settings:
  <div class="command-block">
    <code>curl -I https://google.com</code>
  </div>
</div>

<div class="warning">
  <div class="warning-title">Repository Errors</div>
  Update your package lists:
  <div class="command-block">
    <code>sudo apt update</code>
  </div>
</div>

For more detailed troubleshooting, see our [Troubleshooting Guide](troubleshooting.html).

## Next Steps

After installation, explore:

- [Essential Commands](commands.html) - Master Ubuntu command line
- [Pro Tips & Tricks](tips.html) - Boost your productivity
- [GitHub Repository](https://github.com/tiation/ubuntu-dev-setup) - Contribute and customize

<div class="info">
  <div class="info-title">🎉 You're All Set!</div>
  Your Ubuntu development environment is now ready. Happy coding!
</div>
