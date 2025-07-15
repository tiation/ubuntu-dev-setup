#!/bin/bash

# Ubuntu Development Environment Setup Script
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

# Setup Git configuration
setup_git_config() {
    log "Setting up Git configuration..."
    
    # Check if Git is already configured
    if git config --global user.name > /dev/null 2>&1; then
        log "Git is already configured for user: $(git config --global user.name)"
        return 0
    fi
    
    # Interactive Git setup
    read -p "Enter your Git global user.name: " git_name
    git config --global user.name "$git_name"
    
    read -p "Enter your Git global user.email: " git_email
    git config --global user.email "$git_email"
    
    # Configure Git settings
    git config --global core.editor "vim"
    git config --global init.defaultBranch main
    git config --global pull.rebase true
    git config --global log.decorate auto
    git config --global diff.tool vimdiff
    git config --global merge.tool vimdiff
    
    # Git aliases
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    git config --global alias.st "status"
    git config --global alias.co "checkout"
    git config --global alias.br "branch"
    git config --global alias.ci "commit"
    git config --global alias.unstage "reset HEAD --"
    git config --global alias.last "log -1 HEAD"
    git config --global alias.visual "!gitk"
    
    success "Git configuration complete"
}

# Setup SSH keys
setup_ssh_keys() {
    log "Setting up SSH keys..."
    
    # Check if SSH key already exists
    if [[ -f ~/.ssh/id_ed25519 ]]; then
        log "SSH key already exists at ~/.ssh/id_ed25519"
        return 0
    fi
    
    # Create SSH directory if it doesn't exist
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    
    # Generate SSH key
    read -p "Enter your email for SSH key: " ssh_email
    ssh-keygen -t ed25519 -C "$ssh_email" -f ~/.ssh/id_ed25519 -N ""
    
    # Start SSH agent and add key
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    
    # Configure SSH config
    cat > ~/.ssh/config << EOF
Host *
    AddKeysToAgent yes
    IdentityFile ~/.ssh/id_ed25519
    
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    
Host gitlab.com
    HostName gitlab.com
    User git
    IdentityFile ~/.ssh/id_ed25519
EOF
    
    chmod 600 ~/.ssh/config
    
    # Copy public key to clipboard
    if command -v xclip > /dev/null 2>&1; then
        cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
        success "SSH public key copied to clipboard"
    else
        log "Please install xclip to copy SSH key to clipboard"
        log "Your public key is:"
        cat ~/.ssh/id_ed25519.pub
    fi
    
    success "SSH keys setup complete"
}

# Install and configure Zsh with Oh My Zsh
setup_zsh() {
    log "Setting up Zsh with Oh My Zsh..."
    
    # Install Zsh if not already installed
    if ! command -v zsh > /dev/null 2>&1; then
        sudo apt install -y zsh
    fi
    
    # Install Oh My Zsh
    if [[ ! -d ~/.oh-my-zsh ]]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # Install Zsh plugins
    ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
    
    # zsh-autosuggestions
    if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    fi
    
    # zsh-completions
    if [[ ! -d $ZSH_CUSTOM/plugins/zsh-completions ]]; then
        git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
    fi
    
    # Update .zshrc with plugins
    sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/' ~/.zshrc
    
    # Install Starship prompt
    if ! command -v starship > /dev/null 2>&1; then
        curl -sS https://starship.rs/install.sh | sh -s -- --yes
    fi
    
    # Add Starship to .zshrc
    if ! grep -q "starship init zsh" ~/.zshrc; then
        echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    fi
    
    # Change default shell to Zsh
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        chsh -s $(which zsh)
        success "Default shell changed to Zsh"
    fi
    
    success "Zsh setup complete"
}

# Install and configure NVM and Node.js
setup_node_nvm() {
    log "Setting up Node.js and NVM..."
    
    # Install NVM
    if [[ ! -d ~/.nvm ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    fi
    
    # Source NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    
    # Add NVM to shell profiles
    for profile in ~/.bashrc ~/.zshrc; do
        if [[ -f "$profile" ]] && ! grep -q "NVM_DIR" "$profile"; then
            cat >> "$profile" << 'EOF'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
        fi
    done
    
    # Install Node.js versions
    nvm install --lts
    nvm install 18
    nvm use --lts
    
    # Install global npm packages
    npm install -g npm@latest
    npm install -g pnpm yarn
    npm install -g @vue/cli @angular/cli create-react-app
    npm install -g commitizen cz-conventional-changelog
    npm install -g typescript ts-node
    npm install -g eslint prettier
    npm install -g nodemon pm2
    npm install -g http-server serve
    
    # Configure npm
    mkdir -p ~/.npm-global
    npm config set prefix '~/.npm-global'
    
    # Add npm global to PATH
    for profile in ~/.bashrc ~/.zshrc; do
        if [[ -f "$profile" ]] && ! grep -q "npm-global" "$profile"; then
            echo 'export PATH=~/.npm-global/bin:$PATH' >> "$profile"
        fi
    done
    
    success "Node.js and NVM setup complete"
}

# Setup Python development environment
setup_python() {
    log "Setting up Python development environment..."
    
    # Install Python and pip
    sudo apt install -y python3 python3-pip python3-venv python3-dev
    
    # Install Python 3.11 if available
    if apt-cache search python3.11 | grep -q python3.11; then
        sudo apt install -y python3.11 python3.11-pip python3.11-venv python3.11-dev
    fi
    
    # Create virtual environment for AI development
    if [[ ! -d ~/ai-dev ]]; then
        python3 -m venv ~/ai-dev
        source ~/ai-dev/bin/activate
        
        # Upgrade pip
        pip install --upgrade pip
        
        # Install common packages
        pip install numpy pandas scipy matplotlib seaborn
        pip install jupyter jupyterlab notebook
        pip install requests beautifulsoup4 lxml
        pip install flask django fastapi uvicorn
        pip install pytest pytest-cov black flake8 mypy
        pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
        pip install tensorflow
        pip install transformers datasets
        pip install scikit-learn
        
        deactivate
        success "Python AI development environment created"
    fi
    
    # Install global Python tools
    pip3 install --user pipenv poetry
    pip3 install --user cookiecutter
    pip3 install --user black flake8 mypy
    pip3 install --user jupyter jupyterlab
    
    success "Python development environment setup complete"
}

# Setup shell aliases and functions
setup_shell_aliases() {
    log "Setting up shell aliases and functions..."
    
    # Create aliases file
    cat > ~/.shell_aliases << 'EOF'
# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Listing
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -altrF'

# Better tools
alias cat='batcat'
alias find='fd'
alias grep='rg'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias gm='git merge'
alias gr='git remote'
alias gf='git fetch'
alias glog='git log --oneline --graph --decorate'

# Docker aliases
alias dps='docker ps'
alias dpa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dex='docker exec -it'
alias dlog='docker logs'
alias dcp='docker-compose'
alias dcup='docker-compose up -d'
alias dcdown='docker-compose down'
alias dcps='docker-compose ps'
alias dclogs='docker-compose logs'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kgn='kubectl get namespaces'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdd='kubectl describe deployment'
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kex='kubectl exec -it'
alias klog='kubectl logs'
alias kctx='kubectx'
alias kns='kubens'

# System
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime='date +"%d-%m-%Y %T"'
alias myip='curl -s https://httpbin.org/ip | jq -r .origin'
alias ports='netstat -tulanp'
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
alias cpuinfo='lscpu'
alias gpumeminfo='grep -i --color memory /proc/meminfo'

# Development
alias serve='python3 -m http.server'
alias npmls='npm list -g --depth=0'
alias pipls='pip list'
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'
alias deactivate='deactivate'
alias aidev='source ~/ai-dev/bin/activate'

# Utilities
alias weather='curl wttr.in'
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -'
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'
alias reload='source ~/.zshrc'
alias zshconfig='code ~/.zshrc'
alias aliasconfig='code ~/.shell_aliases'
EOF
    
    # Add aliases to shell profiles
    for profile in ~/.bashrc ~/.zshrc; do
        if [[ -f "$profile" ]] && ! grep -q "shell_aliases" "$profile"; then
            echo 'source ~/.shell_aliases' >> "$profile"
        fi
    done
    
    success "Shell aliases and functions setup complete"
}

# Configure development environment variables
setup_env_vars() {
    log "Setting up environment variables..."
    
    # Create environment variables file
    cat > ~/.dev_env << 'EOF'
# Development paths
export DEV_ROOT="$HOME/workspace/10_projects"
export AI_ROOT="$HOME/workspace/70_data"
export WORKSPACE="$HOME/workspace"

# History settings
export HISTSIZE=100000
export SAVEHIST=100000
export HISTCONTROL=ignoredups:erasedups

# Editor
export EDITOR=vim
export VISUAL=code

# FZF settings
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --border"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Python
export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

# Node.js
export NODE_OPTIONS="--max-old-space-size=4096"

# Docker
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# Path additions
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/bin:$PATH"
EOF
    
    # Add environment variables to shell profiles
    for profile in ~/.bashrc ~/.zshrc; do
        if [[ -f "$profile" ]] && ! grep -q "dev_env" "$profile"; then
            echo 'source ~/.dev_env' >> "$profile"
        fi
    done
    
    success "Environment variables setup complete"
}

# Main execution
main() {
    log "🚀 Starting Ubuntu Development Environment Setup"
    
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
    
    confirm "Setup Git configuration?" && setup_git_config
    confirm "Setup SSH keys?" && setup_ssh_keys
    confirm "Setup Zsh with Oh My Zsh?" && setup_zsh
    confirm "Setup Node.js and NVM?" && setup_node_nvm
    confirm "Setup Python development environment?" && setup_python
    confirm "Setup shell aliases and functions?" && setup_shell_aliases
    confirm "Setup environment variables?" && setup_env_vars
    
    success "🎉 Ubuntu development environment setup complete!"
    log "Please restart your terminal or run 'source ~/.zshrc' to apply changes"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
