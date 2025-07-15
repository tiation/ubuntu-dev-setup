#!/bin/bash

# Ubuntu Development Environment Master Setup Script
# Part of Ubuntu Development Setup Suite

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

info() {
    echo -e "${CYAN}ℹ️ $1${NC}"
}

# Banner function
show_banner() {
    echo -e "${MAGENTA}"
    echo "╔═══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                               ║"
    echo "║                    🚀 Ubuntu Development Environment Setup 🚀                ║"
    echo "║                                                                               ║"
    echo "║                          Automated Setup Suite                               ║"
    echo "║                                                                               ║"
    echo "╚═══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Confirmation function
confirm() {
    [[ "$AUTO_RUN" == "--auto" ]] && return 0
    read -p "$(echo -e "${YELLOW}$1 [y/N]:${NC} ")" -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Progress tracking
declare -a COMPLETED_STEPS=()
declare -a FAILED_STEPS=()

# Function to track step completion
track_step() {
    local step="$1"
    local status="$2"
    
    if [[ "$status" == "success" ]]; then
        COMPLETED_STEPS+=("$step")
        success "✅ $step completed successfully"
    else
        FAILED_STEPS+=("$step")
        error "❌ $step failed"
    fi
}

# Function to run a script with error handling
run_script() {
    local script_name="$1"
    local script_path="$SCRIPT_DIR/$script_name"
    local description="$2"
    
    if [[ ! -f "$script_path" ]]; then
        error "Script not found: $script_path"
        track_step "$description" "failed"
        return 1
    fi
    
    if [[ ! -x "$script_path" ]]; then
        chmod +x "$script_path"
    fi
    
    log "Running: $description"
    
    if [[ "$AUTO_RUN" == "--auto" ]]; then
        if "$script_path" --auto; then
            track_step "$description" "success"
        else
            track_step "$description" "failed"
        fi
    else
        if "$script_path"; then
            track_step "$description" "success"
        else
            track_step "$description" "failed"
        fi
    fi
}

# Function to check system requirements
check_requirements() {
    log "Checking system requirements..."
    
    # Check if running on Ubuntu
    if [[ ! -f /etc/os-release ]] || ! grep -q "Ubuntu" /etc/os-release; then
        error "This script is designed for Ubuntu systems"
        exit 1
    fi
    
    # Check Ubuntu version
    local ubuntu_version=$(lsb_release -rs)
    local major_version=$(echo "$ubuntu_version" | cut -d. -f1)
    
    if [[ "$major_version" -lt 20 ]]; then
        error "Ubuntu 20.04 or later is required. Current version: $ubuntu_version"
        exit 1
    fi
    
    success "System requirements check passed"
    info "Ubuntu version: $ubuntu_version"
    
    # Check internet connectivity
    if ! ping -c 1 google.com > /dev/null 2>&1; then
        error "Internet connection required but not available"
        exit 1
    fi
    
    success "Internet connectivity check passed"
    
    # Check if running as root
    if [[ $EUID -eq 0 ]]; then
        error "This script should not be run as root"
        exit 1
    fi
    
    success "User permission check passed"
}

# Function to show available options
show_options() {
    echo -e "${CYAN}Available setup options:${NC}"
    echo "1. 🔧 System Preferences & Tweaks"
    echo "2. 📦 Package Management (APT, Snap, Flatpak)"
    echo "3. 🛠️  Development Environment Setup"
    echo "4. 📱 Mobile Development Tools"
    echo "5. ☁️  Cloud & DevOps Tools"
    echo "6. 📁 Workspace Structure Setup"
    echo "7. 🚀 Application Launcher"
    echo "8. 🎯 Complete Setup (All of the above)"
    echo "9. 🔄 Custom Setup (Choose individual components)"
    echo "0. ❌ Exit"
}

# Function to run individual setup modules
run_individual_setup() {
    local choice="$1"
    
    case $choice in
        1)
            confirm "Run System Preferences & Tweaks setup?" && 
            run_script "01_system_prefs.sh" "System Preferences & Tweaks"
            ;;
        2)
            confirm "Run Package Management setup?" && 
            run_script "02_package_mgmt.sh" "Package Management"
            ;;
        3)
            confirm "Run Development Environment setup?" && 
            run_script "03_dev_env.sh" "Development Environment"
            ;;
        4)
            confirm "Run Mobile Development setup?" && 
            run_script "04_mobile_dev.sh" "Mobile Development Tools"
            ;;
        5)
            confirm "Run Cloud & DevOps setup?" && 
            run_script "05_cloud_devops.sh" "Cloud & DevOps Tools"
            ;;
        6)
            confirm "Run Workspace Structure setup?" && 
            run_script "06_workspace_setup.sh" "Workspace Structure"
            ;;
        7)
            confirm "Run Application Launcher setup?" && 
            run_script "07_startup_launcher.sh" "Application Launcher"
            ;;
        *)
            error "Invalid choice: $choice"
            ;;
    esac
}

# Function to run complete setup
run_complete_setup() {
    log "Starting complete Ubuntu development environment setup..."
    
    # Array of scripts to run in order
    local scripts=(
        "01_system_prefs.sh:System Preferences & Tweaks"
        "02_package_mgmt.sh:Package Management"
        "03_dev_env.sh:Development Environment"
        "04_mobile_dev.sh:Mobile Development Tools"
        "05_cloud_devops.sh:Cloud & DevOps Tools"
        "06_workspace_setup.sh:Workspace Structure"
        "07_startup_launcher.sh:Application Launcher"
    )
    
    for script_info in "${scripts[@]}"; do
        local script_name=$(echo "$script_info" | cut -d: -f1)
        local description=$(echo "$script_info" | cut -d: -f2)
        
        if [[ "$AUTO_RUN" == "--auto" ]]; then
            run_script "$script_name" "$description"
        else
            if confirm "Run $description setup?"; then
                run_script "$script_name" "$description"
            else
                log "Skipping $description setup"
            fi
        fi
    done
}

# Function to run custom setup
run_custom_setup() {
    log "Starting custom setup..."
    
    local choices
    read -p "Enter your choices (e.g., 1,3,5): " choices
    
    IFS=',' read -ra CHOICE_ARRAY <<< "$choices"
    for choice in "${CHOICE_ARRAY[@]}"; do
        choice=$(echo "$choice" | xargs) # trim whitespace
        run_individual_setup "$choice"
    done
}

# Function to show completion report
show_completion_report() {
    echo -e "\n${CYAN}╔══════════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║                                Setup Complete!                                      ║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════════╝${NC}"
    
    if [[ ${#COMPLETED_STEPS[@]} -gt 0 ]]; then
        echo -e "\n${GREEN}✅ Completed Steps:${NC}"
        for step in "${COMPLETED_STEPS[@]}"; do
            echo -e "${GREEN}  • $step${NC}"
        done
    fi
    
    if [[ ${#FAILED_STEPS[@]} -gt 0 ]]; then
        echo -e "\n${RED}❌ Failed Steps:${NC}"
        for step in "${FAILED_STEPS[@]}"; do
            echo -e "${RED}  • $step${NC}"
        done
        echo -e "\n${YELLOW}⚠️ Please review the failed steps and run them manually if needed.${NC}"
    fi
    
    echo -e "\n${CYAN}📋 Next Steps:${NC}"
    echo "1. 🔄 Restart your terminal or run 'source ~/.zshrc' to apply shell changes"
    echo "2. 🔑 Add your SSH public key to GitHub/GitLab if you generated one"
    echo "3. 🐳 Log out and log back in to apply Docker group changes"
    echo "4. 🔧 Customize your development environment as needed"
    echo "5. 📖 Check the documentation in the docs/ folder for more details"
    
    echo -e "\n${MAGENTA}🎉 Your Ubuntu development environment is ready! Happy coding! 🎉${NC}"
}

# Function to create missing scripts placeholders
create_missing_scripts() {
    local missing_scripts=(
        "04_mobile_dev.sh"
        "05_cloud_devops.sh"
        "06_workspace_setup.sh"
        "07_startup_launcher.sh"
    )
    
    for script in "${missing_scripts[@]}"; do
        if [[ ! -f "$SCRIPT_DIR/$script" ]]; then
            warning "Creating placeholder for $script"
            cat > "$SCRIPT_DIR/$script" << 'EOF'
#!/bin/bash
# Placeholder script - to be implemented
echo "This script is not yet implemented"
exit 0
EOF
            chmod +x "$SCRIPT_DIR/$script"
        fi
    done
}

# Main execution
main() {
    show_banner
    
    # Check for auto-run mode
    if [[ "$1" == "--auto" ]]; then
        AUTO_RUN="--auto"
        log "Running in auto mode (no prompts)"
    fi
    
    # System requirements check
    check_requirements
    
    # Create missing scripts if needed
    create_missing_scripts
    
    # If auto-run, run complete setup
    if [[ "$AUTO_RUN" == "--auto" ]]; then
        run_complete_setup
        show_completion_report
        return 0
    fi
    
    # Interactive mode
    while true; do
        echo
        show_options
        echo
        read -p "Choose an option [0-9]: " choice
        
        case $choice in
            0)
                log "Exiting setup..."
                exit 0
                ;;
            1|2|3|4|5|6|7)
                run_individual_setup "$choice"
                ;;
            8)
                run_complete_setup
                break
                ;;
            9)
                run_custom_setup
                break
                ;;
            *)
                error "Invalid choice. Please select 0-9."
                ;;
        esac
    done
    
    show_completion_report
}

# Display usage information
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --auto    Run complete setup without prompts"
    echo "  --help    Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                # Interactive mode"
    echo "  $0 --auto         # Auto mode (no prompts)"
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        show_usage
        exit 0
        ;;
    --auto)
        main "$@"
        ;;
    "")
        main "$@"
        ;;
    *)
        error "Unknown option: $1"
        show_usage
        exit 1
        ;;
esac
