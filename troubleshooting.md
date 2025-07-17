---
layout: default
title: Troubleshooting Guide
---

# 🔧 Troubleshooting Guide

Common issues and solutions for Ubuntu development environment setup.

## Installation Issues

### Permission Errors

<div class="warning">
  <div class="warning-title">Error: Permission denied</div>
  <p>This occurs when scripts don't have executable permissions or when running without sudo privileges.</p>
</div>

**Solution:**

<div class="command-block">
  <div class="command-title">Fix Permissions</div>
  <code>chmod +x scripts/*.sh<br>
# Or for specific script<br>
chmod +x scripts/setup_master.sh</code>
</div>

### Network Issues

<div class="warning">
  <div class="warning-title">Error: Cannot connect to repositories</div>
  <p>Network connectivity or proxy issues preventing package downloads.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Test Connectivity</div>
  <code>ping -c 4 google.com<br>
curl -I https://archive.ubuntu.com<br>
nslookup archive.ubuntu.com</code>
</div>

<div class="command-block">
  <div class="command-title">Configure Proxy (if needed)</div>
  <code>export http_proxy=http://proxy.example.com:8080<br>
export https_proxy=https://proxy.example.com:8080</code>
</div>

### Repository Issues

<div class="warning">
  <div class="warning-title">Error: Unable to locate package</div>
  <p>Package repositories are outdated or package name has changed.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Update Package Lists</div>
  <code>sudo apt update<br>
sudo apt upgrade</code>
</div>

<div class="command-block">
  <div class="command-title">Fix Broken Dependencies</div>
  <code>sudo apt --fix-broken install<br>
sudo apt autoremove<br>
sudo apt autoclean</code>
</div>

## Docker Issues

### Docker Service Not Running

<div class="warning">
  <div class="warning-title">Error: Cannot connect to Docker daemon</div>
  <p>Docker service is not started or user is not in docker group.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Start Docker Service</div>
  <code>sudo systemctl start docker<br>
sudo systemctl enable docker</code>
</div>

<div class="command-block">
  <div class="command-title">Add User to Docker Group</div>
  <code>sudo usermod -aG docker $USER<br>
newgrp docker</code>
</div>

### Docker Storage Issues

<div class="warning">
  <div class="warning-title">Error: No space left on device</div>
  <p>Docker images and containers are consuming too much disk space.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Clean Docker System</div>
  <code>docker system prune -a<br>
docker volume prune<br>
docker image prune -a</code>
</div>

## Node.js Issues

### Node Version Conflicts

<div class="warning">
  <div class="warning-title">Error: Node version incompatibility</div>
  <p>Multiple Node.js versions installed or wrong version for project.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Use Node Version Manager (NVM)</div>
  <code>curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash<br>
source ~/.bashrc<br>
nvm install --lts<br>
nvm use --lts</code>
</div>

### NPM Permission Issues

<div class="warning">
  <div class="warning-title">Error: EACCES permission denied</div>
  <p>NPM trying to install packages globally without proper permissions.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Configure NPM Global Directory</div>
  <code>mkdir ~/.npm-global<br>
npm config set prefix '~/.npm-global'<br>
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc<br>
source ~/.bashrc</code>
</div>

## Git Issues

### SSH Key Authentication

<div class="warning">
  <div class="warning-title">Error: Permission denied (publickey)</div>
  <p>SSH key not configured properly for Git operations.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Generate and Add SSH Key</div>
  <code>ssh-keygen -t rsa -b 4096 -C "your_email@example.com"<br>
eval "$(ssh-agent -s)"<br>
ssh-add ~/.ssh/id_rsa<br>
cat ~/.ssh/id_rsa.pub</code>
</div>

Then add the public key to your GitHub/GitLab account.

### Git Configuration

<div class="warning">
  <div class="warning-title">Error: Please tell me who you are</div>
  <p>Git user identity not configured.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Configure Git Identity</div>
  <code>git config --global user.name "Your Name"<br>
git config --global user.email "your.email@example.com"</code>
</div>

## Python Issues

### Python Version Conflicts

<div class="warning">
  <div class="warning-title">Error: Python version mismatch</div>
  <p>Multiple Python versions causing conflicts.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Use Python Virtual Environments</div>
  <code>python3 -m venv myenv<br>
source myenv/bin/activate<br>
pip install package-name</code>
</div>

<div class="command-block">
  <div class="command-title">Use pyenv for Version Management</div>
  <code>curl https://pyenv.run | bash<br>
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc<br>
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc<br>
echo 'eval "$(pyenv init -)"' >> ~/.bashrc</code>
</div>

## System Performance Issues

### High Memory Usage

<div class="warning">
  <div class="warning-title">Issue: System running slowly</div>
  <p>High memory usage affecting system performance.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Check Memory Usage</div>
  <code>free -h<br>
top<br>
htop</code>
</div>

<div class="command-block">
  <div class="command-title">Find Memory-Heavy Processes</div>
  <code>ps aux --sort=-%mem | head<br>
sudo kill -9 PID</code>
</div>

### Disk Space Issues

<div class="warning">
  <div class="warning-title">Error: No space left on device</div>
  <p>Disk space is full or nearly full.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Check Disk Usage</div>
  <code>df -h<br>
du -sh * | sort -hr</code>
</div>

<div class="command-block">
  <div class="command-title">Clean System</div>
  <code>sudo apt autoremove<br>
sudo apt autoclean<br>
sudo journalctl --vacuum-time=3d</code>
</div>

## Snap Package Issues

### Snap Store Not Loading

<div class="warning">
  <div class="warning-title">Error: Snap store not responding</div>
  <p>Snap store or snap daemon issues.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Restart Snap Services</div>
  <code>sudo systemctl restart snapd<br>
sudo snap refresh</code>
</div>

## Graphics Issues

### NVIDIA Driver Issues

<div class="warning">
  <div class="warning-title">Issue: Graphics not working properly</div>
  <p>NVIDIA graphics driver conflicts or installation issues.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Install NVIDIA Drivers</div>
  <code>sudo apt update<br>
sudo apt install nvidia-driver-470<br>
sudo reboot</code>
</div>

<div class="command-block">
  <div class="command-title">Check Graphics Status</div>
  <code>nvidia-smi<br>
lspci | grep -i nvidia</code>
</div>

## Network Configuration

### Wi-Fi Issues

<div class="warning">
  <div class="warning-title">Issue: Wi-Fi not connecting</div>
  <p>Wi-Fi adapter not recognized or driver issues.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Check Network Interfaces</div>
  <code>ip link show<br>
sudo lshw -class network</code>
</div>

<div class="command-block">
  <div class="command-title">Restart Network Manager</div>
  <code>sudo systemctl restart NetworkManager<br>
sudo systemctl restart systemd-resolved</code>
</div>

## Boot Issues

### Grub Boot Loader Problems

<div class="warning">
  <div class="warning-title">Error: Grub boot failure</div>
  <p>Boot loader configuration issues.</p>
</div>

**Solutions:**

<div class="command-block">
  <div class="command-title">Repair Grub (from Live USB)</div>
  <code>sudo mount /dev/sdaX /mnt<br>
sudo grub-install --root-directory=/mnt /dev/sda<br>
sudo update-grub</code>
</div>

## Getting Help

### System Information for Support

When seeking help, provide system information:

<div class="command-block">
  <div class="command-title">Gather System Info</div>
  <code>uname -a<br>
lsb_release -a<br>
free -h<br>
df -h<br>
lscpu<br>
lspci</code>
</div>

### Log Files

Check relevant log files for error details:

<div class="command-block">
  <div class="command-title">Check Logs</div>
  <code>sudo journalctl -xe<br>
sudo dmesg | tail<br>
cat /var/log/syslog<br>
cat /var/log/apt/history.log</code>
</div>

### Community Resources

- **Ubuntu Forums**: [https://ubuntuforums.org/](https://ubuntuforums.org/)
- **Ask Ubuntu**: [https://askubuntu.com/](https://askubuntu.com/)
- **Ubuntu Documentation**: [https://help.ubuntu.com/](https://help.ubuntu.com/)
- **Launchpad**: [https://launchpad.net/](https://launchpad.net/)

<div class="info">
  <div class="info-title">💡 Pro Tip</div>
  Always backup your important data before making significant system changes. Use tools like <code>rsync</code> or <code>timeshift</code> for system backups.
</div>

If you encounter issues not covered here, please check our [GitHub Issues](https://github.com/tiation/ubuntu-dev-setup/issues) or create a new issue with detailed information about your problem.
