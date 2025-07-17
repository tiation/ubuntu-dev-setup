---
layout: default
title: Tips and Tricks for Ubuntu
---

# 💡 Tips and Tricks for Ubuntu Development

Unlock the full potential of your Ubuntu setup with these expert tips and tricks.

## General Tips

### Optimize Startup

- **Disable startup applications** to speed up boot time.

  ```bash
  sudo apt install gnome-tweak-tool
  gnome-tweaks
  ```

- **Enable Startup Disk Creator** for creating bootable USB drives.

  ```bash
  sudo apt install usb-creator-gtk
  ```

### Use Workspaces

- Improve multitasking with virtual desktops.

  ```bash
  gsettings set org.gnome.mutter dynamic-workspaces true
  ```

- Switch workspaces:
  - `Super + PageUp` or `Super + PageDown`

## Terminal Productivity

### Custom Aliases

Customize your terminal experience by adding useful aliases.

- **Add to `~/.bashrc` or `~/.zshrc`:**

  ```bash
  alias update='sudo apt update && sudo apt upgrade'
  alias gs='git status'
  alias ll='ls -la'
  ```

- **Apply changes:**

  ```bash
  source ~/.bashrc
  ```

### Efficient File Navigation

- **Use `cd` shortcuts:**

  ```bash
  alias ..='cd ..'
  alias ...='cd ../..'
  ```

- **Find files quickly:**

  ```bash
  alias findpy='find . -name "*.py"'
  ```

## Development Environment

### Code Formatting

- Automatically format code on save with editors like VS Code.

  ```json
  // settings.json
  {
    "editor.formatOnSave": true
  }
  ```

### Version Control

- **Commit wisely:**
  - Always write clear and descriptive commit messages.

- **Branching strategy:**
  - Use `git-flow` to manage feature branches effectively.

  ```bash
  sudo apt install git-flow
  git flow init
  ```

## System Performance

### Manage Background Services

- **Control services with `systemctl`:**

  ```bash
  sudo systemctl disable unwanted-service
  sudo systemctl enable wanted-service
  ```

- **Monitor system performance:**

  ```bash
  top
  htop
  ```

### Reduce Resource Usage

- **Install and use a lightweight desktop environment** like Xfce or LXDE for older machines.

  ```bash
  sudo apt install xubuntu-desktop
  ```

## Security Enhancements

### Secure SSH

- **Generate strong SSH keys:**

  ```bash
  ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
  ```

- **Copy SSH keys to new host:**

  ```bash
  ssh-copy-id user@host
  ```

### Firewall Setup

- **Configure UFW firewall for basic protection:**

  ```bash
  sudo ufw enable
  sudo ufw allow ssh
  ```

- **Check firewall status:**

  ```bash
  sudo ufw status
  ```

Enjoy improved productivity and efficiency with these Ubuntu tips and tricks!
