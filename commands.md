---
layout: default
title: Essential Ubuntu Commands
---

# 🛠️ Essential Ubuntu Commands

Master Ubuntu with this comprehensive collection of essential commands and utilities for development.

## System Information

<div class="grid">
  <div class="card">
    <div class="card-header">
      <span class="card-icon">📊</span>
      <h3 class="card-title">System Status</h3>
    </div>
    <div class="command-block">
      <div class="command-title">System Information</div>
      <code>uname -a          # System info<br>
lsb_release -a     # Ubuntu version<br>
hostnamectl        # Host details<br>
uptime             # System uptime</code>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">💾</span>
      <h3 class="card-title">Memory & Storage</h3>
    </div>
    <div class="command-block">
      <div class="command-title">Resource Usage</div>
      <code>free -h            # Memory usage<br>
df -h              # Disk usage<br>
du -sh *           # Directory sizes<br>
lsblk              # Block devices</code>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">⚡</span>
      <h3 class="card-title">Process Management</h3>
    </div>
    <div class="command-block">
      <div class="command-title">Process Control</div>
      <code>ps aux             # Running processes<br>
htop               # Interactive process viewer<br>
kill -9 PID        # Kill process<br>
killall name       # Kill by name</code>
    </div>
  </div>
</div>

## Package Management

### APT Commands

<div class="command-block">
  <div class="command-title">Package Operations</div>
  <code># Update package lists<br>
sudo apt update<br><br>
# Upgrade packages<br>
sudo apt upgrade<br><br>
# Install package<br>
sudo apt install package-name<br><br>
# Remove package<br>
sudo apt remove package-name<br><br>
# Search packages<br>
apt search keyword<br><br>
# Show package info<br>
apt show package-name<br><br>
# List installed packages<br>
apt list --installed</code>
</div>

### Snap Commands

<div class="command-block">
  <div class="command-title">Snap Package Management</div>
  <code># Install snap package<br>
sudo snap install package-name<br><br>
# List installed snaps<br>
snap list<br><br>
# Update snaps<br>
sudo snap refresh<br><br>
# Remove snap<br>
sudo snap remove package-name<br><br>
# Find snaps<br>
snap find keyword</code>
</div>

### Flatpak Commands

<div class="command-block">
  <div class="command-title">Flatpak Management</div>
  <code># Install flatpak<br>
flatpak install app-id<br><br>
# List installed<br>
flatpak list<br><br>
# Update apps<br>
flatpak update<br><br>
# Remove app<br>
flatpak uninstall app-id<br><br>
# Search apps<br>
flatpak search keyword</code>
</div>

## File Operations

<div class="grid">
  <div class="card">
    <div class="card-header">
      <span class="card-icon">📁</span>
      <h3 class="card-title">Navigation</h3>
    </div>
    <div class="command-block">
      <code>pwd                # Current directory<br>
ls -la             # List files (detailed)<br>
cd directory       # Change directory<br>
cd ..              # Go up one level<br>
cd ~               # Go to home</code>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">📄</span>
      <h3 class="card-title">File Management</h3>
    </div>
    <div class="command-block">
      <code>cp file dest       # Copy file<br>
mv file dest       # Move/rename file<br>
rm file            # Delete file<br>
mkdir dir          # Create directory<br>
rmdir dir          # Remove empty directory</code>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">🔍</span>
      <h3 class="card-title">Search & Find</h3>
    </div>
    <div class="command-block">
      <code>find . -name "*.py" # Find Python files<br>
grep -r "text" .   # Search text in files<br>
locate filename    # Find file by name<br>
which command      # Find command location</code>
    </div>
  </div>
</div>

## Development Tools

### Git Commands

<div class="command-block">
  <div class="command-title">Essential Git Commands</div>
  <code># Initialize repository<br>
git init<br><br>
# Clone repository<br>
git clone https://github.com/user/repo.git<br><br>
# Check status<br>
git status<br><br>
# Add files<br>
git add .<br>
git add filename<br><br>
# Commit changes<br>
git commit -m "message"<br><br>
# Push to remote<br>
git push origin main<br><br>
# Pull from remote<br>
git pull origin main<br><br>
# Create branch<br>
git checkout -b branch-name<br><br>
# Switch branch<br>
git checkout branch-name<br><br>
# Merge branch<br>
git merge branch-name</code>
</div>

### Docker Commands

<div class="command-block">
  <div class="command-title">Docker Essentials</div>
  <code># List containers<br>
docker ps -a<br><br>
# Run container<br>
docker run -it ubuntu:latest<br><br>
# Build image<br>
docker build -t image-name .<br><br>
# Stop container<br>
docker stop container-id<br><br>
# Remove container<br>
docker rm container-id<br><br>
# List images<br>
docker images<br><br>
# Remove image<br>
docker rmi image-id<br><br>
# Docker compose<br>
docker-compose up -d<br>
docker-compose down</code>
</div>

### Node.js & npm

<div class="command-block">
  <div class="command-title">Node.js Development</div>
  <code># Check versions<br>
node --version<br>
npm --version<br><br>
# Initialize project<br>
npm init -y<br><br>
# Install packages<br>
npm install package-name<br>
npm install -g package-name  # Global install<br><br>
# Run scripts<br>
npm run script-name<br>
npm start<br><br>
# List packages<br>
npm list<br>
npm list -g --depth=0       # Global packages</code>
</div>

## Network & Connectivity

<div class="grid">
  <div class="card">
    <div class="card-header">
      <span class="card-icon">🌐</span>
      <h3 class="card-title">Network Info</h3>
    </div>
    <div class="command-block">
      <code>ip addr show       # IP addresses<br>
ifconfig           # Network interfaces<br>
netstat -tuln      # Open ports<br>
ss -tuln           # Socket statistics</code>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">📡</span>
      <h3 class="card-title">Connectivity</h3>
    </div>
    <div class="command-block">
      <code>ping google.com    # Test connectivity<br>
wget url           # Download file<br>
curl url           # HTTP request<br>
nslookup domain    # DNS lookup</code>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">🔒</span>
      <h3 class="card-title">SSH & Security</h3>
    </div>
    <div class="command-block">
      <code>ssh user@host      # SSH connection<br>
ssh-keygen -t rsa  # Generate SSH key<br>
ssh-copy-id user@host # Copy public key<br>
scp file user@host:path # Secure copy</code>
    </div>
  </div>
</div>

## System Services

<div class="command-block">
  <div class="command-title">Systemd Service Management</div>
  <code># Start service<br>
sudo systemctl start service-name<br><br>
# Stop service<br>
sudo systemctl stop service-name<br><br>
# Restart service<br>
sudo systemctl restart service-name<br><br>
# Enable service (start at boot)<br>
sudo systemctl enable service-name<br><br>
# Disable service<br>
sudo systemctl disable service-name<br><br>
# Check service status<br>
sudo systemctl status service-name<br><br>
# List all services<br>
sudo systemctl list-units --type=service</code>
</div>

## Text Processing

<div class="grid">
  <div class="card">
    <div class="card-header">
      <span class="card-icon">📝</span>
      <h3 class="card-title">File Viewing</h3>
    </div>
    <div class="command-block">
      <code>cat file           # Display file<br>
less file          # Page through file<br>
head -n 10 file    # First 10 lines<br>
tail -n 10 file    # Last 10 lines<br>
tail -f file       # Follow file changes</code>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">✂️</span>
      <h3 class="card-title">Text Processing</h3>
    </div>
    <div class="command-block">
      <code>grep pattern file  # Search pattern<br>
sed 's/old/new/g' file # Replace text<br>
awk '{print $1}' file # Print first column<br>
cut -d',' -f1 file # Cut by delimiter<br>
sort file          # Sort lines</code>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <span class="card-icon">🔗</span>
      <h3 class="card-title">Text Manipulation</h3>
    </div>
    <div class="command-block">
      <code>wc -l file         # Count lines<br>
tr 'a-z' 'A-Z' < file # Convert case<br>
uniq file          # Remove duplicates<br>
comm file1 file2   # Compare files<br>
diff file1 file2   # Show differences</code>
    </div>
  </div>
</div>

## Permissions & Ownership

<div class="command-block">
  <div class="command-title">File Permissions</div>
  <code># Change permissions<br>
chmod 755 file     # rwxr-xr-x<br>
chmod +x file      # Make executable<br>
chmod -x file      # Remove executable<br><br>
# Change ownership<br>
sudo chown user:group file<br>
sudo chown -R user:group directory<br><br>
# View permissions<br>
ls -la file        # Detailed listing<br>
stat file          # File statistics</code>
</div>

## Archive & Compression

<div class="command-block">
  <div class="command-title">Archive Operations</div>
  <code># Create tar archive<br>
tar -czf archive.tar.gz directory/<br><br>
# Extract tar archive<br>
tar -xzf archive.tar.gz<br><br>
# List archive contents<br>
tar -tzf archive.tar.gz<br><br>
# Create zip archive<br>
zip -r archive.zip directory/<br><br>
# Extract zip archive<br>
unzip archive.zip</code>
</div>

## Environment & Variables

<div class="command-block">
  <div class="command-title">Environment Management</div>
  <code># Show environment variables<br>
env<br>
printenv<br><br>
# Set environment variable<br>
export VAR_NAME=value<br><br>
# Show specific variable<br>
echo $VAR_NAME<br><br>
# Show PATH<br>
echo $PATH<br><br>
# Which shell<br>
echo $SHELL<br><br>
# Current user<br>
whoami<br>
id</code>
</div>

<div class="tip">
  <div class="tip-title">💡 Pro Tips</div>
  <ul>
    <li>Use <code>man command</code> to read manual pages</li>
    <li>Use <code>history</code> to see command history</li>
    <li>Use <code>!</code> to repeat previous commands</li>
    <li>Use <code>Tab</code> for auto-completion</li>
    <li>Use <code>Ctrl+R</code> for reverse search</li>
  </ul>
</div>

## Useful Aliases

Add these to your `~/.bashrc` or `~/.zshrc`:

<div class="command-block">
  <div class="command-title">Productivity Aliases</div>
  <code># Navigation<br>
alias ..='cd ..'<br>
alias ...='cd ../..'<br>
alias ll='ls -la'<br>
alias la='ls -A'<br><br>
# Git shortcuts<br>
alias gs='git status'<br>
alias ga='git add'<br>
alias gc='git commit'<br>
alias gp='git push'<br>
alias gl='git log --oneline'<br><br>
# System shortcuts<br>
alias c='clear'<br>
alias h='history'<br>
alias df='df -h'<br>
alias free='free -h'<br><br>
# Development<br>
alias python='python3'<br>
alias pip='pip3'<br>
alias serve='python3 -m http.server'</code>
</div>

For more advanced usage and troubleshooting, check out our [Pro Tips & Tricks](tips.html) page.
