---
layout: default
title: Ubuntu Development Environment Setup
---

<div class="hero">
  <div class="wrapper">
    <h1>🚀 Ubuntu Dev Setup</h1>
    <p class="hero-subtitle">Automated Ubuntu Development Environment Setup Scripts</p>
    <div class="hero-buttons">
      <a href="https://github.com/tiation/ubuntu-dev-setup" class="btn">View on GitHub</a>
      <a href="quick-start.html" class="btn">Quick Start</a>
      <a href="commands.html" class="btn">Commands</a>
    </div>
  </div>
</div>

<div class="wrapper">
  <div class="grid">
    <div class="card">
      <div class="card-header">
        <span class="card-icon">⚡</span>
        <h3 class="card-title">Quick Setup</h3>
      </div>
      <p>Get your Ubuntu development environment up and running in minutes with our automated scripts.</p>
      <a href="quick-start.html" class="btn-primary">Get Started</a>
    </div>

    <div class="card">
      <div class="card-header">
        <span class="card-icon">🛠️</span>
        <h3 class="card-title">Essential Commands</h3>
      </div>
      <p>Master Ubuntu with our curated collection of essential commands and utilities.</p>
      <a href="commands.html" class="btn-primary">View Commands</a>
    </div>

    <div class="card">
      <div class="card-header">
        <span class="card-icon">💡</span>
        <h3 class="card-title">Pro Tips</h3>
      </div>
      <p>Discover expert tips and tricks to boost your Ubuntu development productivity.</p>
      <a href="tips.html" class="btn-primary">Learn Tips</a>
    </div>
  </div>

  ## 🎯 What This Project Does

  This comprehensive collection of modular scripts sets up a complete development environment on Ubuntu systems, perfect for developers who want to quickly bootstrap their Ubuntu workstation.

  ### Core Features

  - **System Configuration**: Ubuntu system preferences and tweaks
  - **Package Management**: APT packages, Snap packages, and Flatpak applications
  - **Development Environment**: Git, SSH, shell configuration (Zsh + Oh My Zsh)
  - **Runtime Setup**: Node.js, Python, language-specific environments
  - **Mobile Development**: Flutter, Android SDK setup
  - **Container & Kubernetes**: Docker, Kubernetes tools
  - **Directory Structure**: Organized development workspace
  - **Application Launcher**: GUI app and service startup automation

  ## 🚀 One-Line Install

  <div class="command-block">
    <div class="command-title">Install Everything</div>
    <code>curl -fsSL https://raw.githubusercontent.com/tiation/ubuntu-dev-setup/main/install.sh | bash</code>
  </div>

  ## 📦 What Gets Installed

  <div class="grid">
    <div class="card">
      <div class="card-header">
        <span class="card-icon">💻</span>
        <h3 class="card-title">Development Tools</h3>
      </div>
      <ul>
        <li>Git, GitHub CLI</li>
        <li>VS Code, Vim/Neovim</li>
        <li>Docker, Docker Compose</li>
        <li>Node.js, Python, Java</li>
      </ul>
    </div>

    <div class="card">
      <div class="card-header">
        <span class="card-icon">🌐</span>
        <h3 class="card-title">Web Development</h3>
      </div>
      <ul>
        <li>Modern browsers</li>
        <li>Frontend frameworks</li>
        <li>API testing tools</li>
        <li>Database clients</li>
      </ul>
    </div>

    <div class="card">
      <div class="card-header">
        <span class="card-icon">📱</span>
        <h3 class="card-title">Mobile Development</h3>
      </div>
      <ul>
        <li>Flutter SDK</li>
        <li>Android Studio</li>
        <li>Android SDK tools</li>
        <li>Mobile emulators</li>
      </ul>
    </div>
  </div>

  <div class="tip">
    <div class="tip-title">💡 Pro Tip</div>
    Each script is modular and can be run independently. You can customize which components to install by editing the script variables or running individual modules.
  </div>

  ## 🔧 Customization Options

  The setup scripts are designed to be flexible and customizable:

  1. **Edit variables** at the top of each script to customize packages
  2. **Comment out** sections you don't need
  3. **Add your own** package lists or configurations
  4. **Run selectively** with individual module scripts

  ## 📖 Documentation

  - [Quick Start Guide](quick-start.html) - Get up and running fast
  - [Essential Commands](commands.html) - Must-know Ubuntu commands
  - [Pro Tips & Tricks](tips.html) - Boost your productivity
  - [Troubleshooting](troubleshooting.html) - Common issues and solutions

  ## 🤝 Contributing

  We welcome contributions! Check out our [GitHub repository](https://github.com/tiation/ubuntu-dev-setup) to:

  - Report bugs or request features
  - Submit pull requests
  - Improve documentation
  - Share your setup customizations

  <div class="info">
    <div class="info-title">🔒 Security First</div>
    Our scripts use official package repositories, generate secure SSH keys, handle environment variables safely, and never store credentials in scripts.
  </div>
</div>
