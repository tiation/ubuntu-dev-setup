#!/bin/bash

# Ubuntu Workspace Setup Script
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

# Create workspace directory structure
create_workspace_structure() {
    log "Creating workspace directory structure..."
    
    # Create main workspace directories
    mkdir -p ~/workspace/{00_org,10_projects,20_assets,30_docs,40_ops,70_data,99_tmp}
    
    # Create organization directories
    mkdir -p ~/workspace/00_org/{brand,onboarding,templates,guidelines}
    mkdir -p ~/workspace/00_org/onboarding/{scripts,docs,checklists}
    
    # Create project directories
    mkdir -p ~/workspace/10_projects/{web,mobile,desktop,backend,frontend,fullstack}
    mkdir -p ~/workspace/10_projects/web/{react,vue,angular,static,wordpress}
    mkdir -p ~/workspace/10_projects/mobile/{flutter,react-native,ionic,android,ios}
    mkdir -p ~/workspace/10_projects/backend/{node,python,java,go,rust,php}
    mkdir -p ~/workspace/10_projects/desktop/{electron,tauri,flutter,native}
    
    # Create assets directories
    mkdir -p ~/workspace/20_assets/{images,videos,audio,graphics,fonts,icons}
    mkdir -p ~/workspace/20_assets/images/{photos,screenshots,diagrams,logos}
    mkdir -p ~/workspace/20_assets/graphics/{designs,mockups,prototypes,animations}
    
    # Create docs directories
    mkdir -p ~/workspace/30_docs/{technical,business,legal,marketing,presentations}
    mkdir -p ~/workspace/30_docs/technical/{architecture,api,deployment,troubleshooting}
    mkdir -p ~/workspace/30_docs/business/{requirements,specifications,proposals,reports}
    
    # Create operations directories
    mkdir -p ~/workspace/40_ops/{scripts,configs,docker,kubernetes,terraform,ansible}
    mkdir -p ~/workspace/40_ops/scripts/{deployment,monitoring,backup,maintenance}
    mkdir -p ~/workspace/40_ops/configs/{nginx,apache,ssl,database,cache}
    
    # Create data directories
    mkdir -p ~/workspace/70_data/{databases,datasets,models,backups,logs}
    mkdir -p ~/workspace/70_data/datasets/{training,testing,validation,reference}
    mkdir -p ~/workspace/70_data/models/{ml,ai,trained,pretrained}
    
    # Create temp directories
    mkdir -p ~/workspace/99_tmp/{downloads,experiments,scratch,archive}
    
    success "Workspace directory structure created"
}

# Create traditional development directories
create_traditional_directories() {
    log "Creating traditional development directories..."
    
    # Create traditional project structure
    mkdir -p ~/Projects/{web,mobile,desktop,scripts,tools,learning}
    mkdir -p ~/Documents/Development/{notes,tutorials,references,cheatsheets}
    mkdir -p ~/Development/{local,remote,forks,contributions}
    
    # Create coding practice directories
    mkdir -p ~/Practice/{algorithms,data-structures,coding-challenges,tutorials}
    mkdir -p ~/Learning/{courses,books,videos,articles}
    
    success "Traditional development directories created"
}

# Setup git repositories structure
setup_git_repositories() {
    log "Setting up git repositories structure..."
    
    # Create git repositories directory
    mkdir -p ~/git-repos/{personal,work,forks,contributions,archived}
    
    # Create symlinks for easy access
    ln -sf ~/workspace/10_projects ~/git-repos/workspace-projects
    ln -sf ~/Projects ~/git-repos/traditional-projects
    
    success "Git repositories structure created"
}

# Create configuration directories
create_config_directories() {
    log "Creating configuration directories..."
    
    # Create config directories
    mkdir -p ~/.config/{scripts,templates,profiles,themes}
    mkdir -p ~/.local/{bin,share,lib,etc}
    
    # Create development tools directories
    mkdir -p ~/.dev-tools/{scripts,utilities,templates,configs}
    
    success "Configuration directories created"
}

# Setup project templates
setup_project_templates() {
    log "Setting up project templates..."
    
    # Create templates directory
    mkdir -p ~/workspace/00_org/templates/{web,mobile,desktop,backend,scripts}
    
    # Create basic web template
    cat > ~/workspace/00_org/templates/web/basic-html.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Project</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
    </style>
</head>
<body>
    <div class="container">
        <h1>New Project</h1>
        <p>Welcome to your new project!</p>
    </div>
</body>
</html>
EOF
    
    # Create basic package.json template
    cat > ~/workspace/00_org/templates/web/package.json << 'EOF'
{
  "name": "new-project",
  "version": "1.0.0",
  "description": "A new project",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js",
    "test": "jest"
  },
  "keywords": [],
  "author": "",
  "license": "MIT",
  "dependencies": {},
  "devDependencies": {
    "nodemon": "^3.0.0",
    "jest": "^29.0.0"
  }
}
EOF
    
    # Create basic README template
    cat > ~/workspace/00_org/templates/README.md << 'EOF'
# Project Name

Brief description of the project.

## Installation

```bash
# Clone the repository
git clone <repository-url>

# Navigate to project directory
cd project-name

# Install dependencies
npm install  # or yarn install, pip install -r requirements.txt, etc.
```

## Usage

```bash
# Run the project
npm start  # or python main.py, ./run.sh, etc.
```

## Features

- Feature 1
- Feature 2
- Feature 3

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License.
EOF
    
    # Create basic .gitignore template
    cat > ~/workspace/00_org/templates/.gitignore << 'EOF'
# Dependencies
node_modules/
venv/
vendor/

# Build outputs
dist/
build/
*.o
*.exe

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE files
.vscode/
.idea/
*.swp
*.swo

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp
.cache/
EOF
    
    success "Project templates created"
}

# Create development scripts
create_development_scripts() {
    log "Creating development scripts..."
    
    # Create scripts directory
    mkdir -p ~/workspace/40_ops/scripts/development
    
    # Create new project script
    cat > ~/workspace/40_ops/scripts/development/new-project.sh << 'EOF'
#!/bin/bash

# New Project Creation Script

set -e

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Get project details
read -p "Project name: " project_name
read -p "Project type (web/mobile/desktop/backend): " project_type
read -p "Project location (workspace/projects/custom): " project_location

# Validate inputs
if [[ -z "$project_name" ]]; then
    echo -e "${RED}Error: Project name is required${NC}"
    exit 1
fi

# Determine project directory
case $project_location in
    workspace)
        project_dir="$HOME/workspace/10_projects/$project_type/$project_name"
        ;;
    projects)
        project_dir="$HOME/Projects/$project_type/$project_name"
        ;;
    custom)
        read -p "Enter custom path: " custom_path
        project_dir="$custom_path/$project_name"
        ;;
    *)
        echo -e "${RED}Error: Invalid project location${NC}"
        exit 1
        ;;
esac

# Create project directory
mkdir -p "$project_dir"
cd "$project_dir"

# Copy templates
cp ~/workspace/00_org/templates/README.md .
cp ~/workspace/00_org/templates/.gitignore .

# Initialize git repository
git init
git add .
git commit -m "Initial commit"

echo -e "${GREEN}✅ Project '$project_name' created successfully at: $project_dir${NC}"
echo -e "${YELLOW}📁 Opening project in VS Code...${NC}"

# Open in VS Code if available
if command -v code > /dev/null 2>&1; then
    code "$project_dir"
fi
EOF
    
    chmod +x ~/workspace/40_ops/scripts/development/new-project.sh
    
    # Create project backup script
    cat > ~/workspace/40_ops/scripts/development/backup-projects.sh << 'EOF'
#!/bin/bash

# Project Backup Script

set -e

BACKUP_DIR="$HOME/workspace/70_data/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup workspace projects
tar -czf "$BACKUP_DIR/workspace_projects_$TIMESTAMP.tar.gz" -C "$HOME/workspace/10_projects" .

# Backup traditional projects
if [[ -d "$HOME/Projects" ]]; then
    tar -czf "$BACKUP_DIR/traditional_projects_$TIMESTAMP.tar.gz" -C "$HOME/Projects" .
fi

echo "✅ Projects backed up to: $BACKUP_DIR"
EOF
    
    chmod +x ~/workspace/40_ops/scripts/development/backup-projects.sh
    
    success "Development scripts created"
}

# Setup workspace environment variables
setup_workspace_env() {
    log "Setting up workspace environment variables..."
    
    # Create workspace environment file
    cat > ~/.workspace_env << 'EOF'
# Workspace Environment Variables

# Main workspace paths
export WORKSPACE="$HOME/workspace"
export PROJECTS="$HOME/workspace/10_projects"
export ASSETS="$HOME/workspace/20_assets"
export DOCS="$HOME/workspace/30_docs"
export OPS="$HOME/workspace/40_ops"
export DATA="$HOME/workspace/70_data"
export TMP="$HOME/workspace/99_tmp"

# Project type paths
export WEB_PROJECTS="$PROJECTS/web"
export MOBILE_PROJECTS="$PROJECTS/mobile"
export DESKTOP_PROJECTS="$PROJECTS/desktop"
export BACKEND_PROJECTS="$PROJECTS/backend"

# Development paths
export DEV_SCRIPTS="$OPS/scripts"
export DEV_CONFIGS="$OPS/configs"
export DEV_TEMPLATES="$WORKSPACE/00_org/templates"

# Data paths
export DATASETS="$DATA/datasets"
export MODELS="$DATA/models"
export BACKUPS="$DATA/backups"

# Utility functions
workon() {
    if [[ -d "$PROJECTS/$1" ]]; then
        cd "$PROJECTS/$1"
    else
        echo "Project $1 not found"
        return 1
    fi
}

newproject() {
    bash "$DEV_SCRIPTS/development/new-project.sh"
}

backup_projects() {
    bash "$DEV_SCRIPTS/development/backup-projects.sh"
}

list_projects() {
    echo "📁 Available projects:"
    find "$PROJECTS" -mindepth 2 -maxdepth 2 -type d | sort
}

# Aliases
alias ws='cd $WORKSPACE'
alias projects='cd $PROJECTS'
alias assets='cd $ASSETS'
alias docs='cd $DOCS'
alias ops='cd $OPS'
alias data='cd $DATA'
alias tmp='cd $TMP'
alias templates='cd $DEV_TEMPLATES'
alias lsprojects='list_projects'
EOF
    
    # Add to shell profiles
    for profile in ~/.bashrc ~/.zshrc; do
        if [[ -f "$profile" ]] && ! grep -q "workspace_env" "$profile"; then
            echo 'source ~/.workspace_env' >> "$profile"
        fi
    done
    
    success "Workspace environment variables setup complete"
}

# Create documentation
create_workspace_docs() {
    log "Creating workspace documentation..."
    
    # Create workspace documentation
    cat > ~/workspace/30_docs/workspace-guide.md << 'EOF'
# Workspace Organization Guide

## Directory Structure

```
~/workspace/
├── 00_org/          # Organization assets, templates, guidelines
├── 10_projects/     # Development projects
├── 20_assets/       # Media files, graphics, images
├── 30_docs/         # Documentation and references
├── 40_ops/          # Operations, scripts, configurations
├── 70_data/         # Datasets, models, backups
└── 99_tmp/          # Temporary files and experiments
```

## Project Organization

### 10_projects/
- **web/**: Web development projects
- **mobile/**: Mobile app projects
- **desktop/**: Desktop application projects
- **backend/**: Server-side projects
- **frontend/**: Client-side projects
- **fullstack/**: Full-stack applications

### 20_assets/
- **images/**: Photos, screenshots, diagrams
- **videos/**: Video files and recordings
- **audio/**: Audio files and sound effects
- **graphics/**: Design files and mockups
- **fonts/**: Font files
- **icons/**: Icon sets and resources

### 30_docs/
- **technical/**: Technical documentation
- **business/**: Business documents
- **legal/**: Legal documents
- **marketing/**: Marketing materials
- **presentations/**: Slide decks and presentations

### 40_ops/
- **scripts/**: Automation scripts
- **configs/**: Configuration files
- **docker/**: Docker-related files
- **kubernetes/**: Kubernetes manifests
- **terraform/**: Infrastructure as code
- **ansible/**: Automation playbooks

### 70_data/
- **databases/**: Database files
- **datasets/**: Data for analysis
- **models/**: Machine learning models
- **backups/**: Backup files
- **logs/**: Log files

## Usage

### Environment Variables
- `$WORKSPACE`: Main workspace directory
- `$PROJECTS`: Projects directory
- `$ASSETS`: Assets directory
- `$DOCS`: Documentation directory
- `$OPS`: Operations directory
- `$DATA`: Data directory

### Utility Functions
- `workon <project>`: Navigate to project directory
- `newproject`: Create new project
- `backup_projects`: Backup all projects
- `list_projects`: List available projects

### Aliases
- `ws`: Go to workspace
- `projects`: Go to projects directory
- `assets`: Go to assets directory
- `docs`: Go to documentation directory
- `ops`: Go to operations directory
- `data`: Go to data directory
- `tmp`: Go to temporary directory
- `templates`: Go to templates directory
- `lsprojects`: List all projects

## Best Practices

1. **Naming Conventions**
   - Use lowercase with hyphens for directories
   - Use descriptive names for projects
   - Group related projects together

2. **Project Structure**
   - Each project should have a README.md
   - Use .gitignore for version control
   - Include documentation in docs/ subfolder

3. **Asset Management**
   - Store raw assets in 20_assets/
   - Keep processed assets in project directories
   - Use version control for important assets

4. **Documentation**
   - Document all processes and procedures
   - Keep technical docs up to date
   - Use markdown for consistency

5. **Operations**
   - Automate repetitive tasks with scripts
   - Keep configurations in version control
   - Document deployment procedures

## Getting Started

1. Use `newproject` to create a new project
2. Organize files according to the structure
3. Use the provided aliases for navigation
4. Backup regularly with `backup_projects`
5. Document your work in the docs/ directory
EOF
    
    success "Workspace documentation created"
}

# Main execution
main() {
    log "🚀 Starting Ubuntu Workspace Setup"
    
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
    
    confirm "Create workspace directory structure?" && create_workspace_structure
    confirm "Create traditional development directories?" && create_traditional_directories
    confirm "Setup git repositories structure?" && setup_git_repositories
    confirm "Create configuration directories?" && create_config_directories
    confirm "Setup project templates?" && setup_project_templates
    confirm "Create development scripts?" && create_development_scripts
    confirm "Setup workspace environment variables?" && setup_workspace_env
    confirm "Create workspace documentation?" && create_workspace_docs
    
    success "🎉 Ubuntu workspace setup complete!"
    log "Workspace structure created at: ~/workspace"
    log "Run 'source ~/.workspace_env' or restart your terminal to use new commands"
    log "Use 'newproject' to create a new project"
    log "Use 'lsprojects' to list available projects"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
