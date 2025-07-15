# Contributing to Ubuntu Development Setup

🙏 Thank you for considering contributing to the Ubuntu Development Setup project! 

## How to Contribute

### Reporting Issues

1. **Check existing issues** first to avoid duplicates
2. **Use the issue templates** when creating new issues
3. **Provide detailed information** including:
   - Ubuntu version
   - Error messages
   - Steps to reproduce
   - Expected vs actual behavior

### Submitting Changes

1. **Fork the repository**
2. **Create a feature branch** from `main`
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Test thoroughly** on a clean Ubuntu installation
5. **Follow the coding standards** (see below)
6. **Update documentation** if needed
7. **Submit a pull request**

### Coding Standards

#### Shell Scripts
- Use `#!/bin/bash` shebang
- Set `set -e` for error handling
- Use consistent indentation (4 spaces)
- Include function documentation
- Use descriptive variable names
- Add error checking for critical operations

#### Documentation
- Use clear, concise language
- Include code examples
- Update README.md if adding new features
- Use markdown formatting consistently

#### Testing
- Test on clean Ubuntu 20.04 LTS and later
- Test both interactive and auto modes
- Verify idempotent behavior (safe to run multiple times)
- Test individual scripts as well as the master script

### Script Structure

Each script should follow this structure:

```bash
#!/bin/bash

# Script Name
# Part of Ubuntu Development Setup Suite

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
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

# Main functions here...

# Main execution
main() {
    log "🚀 Starting [Script Name]"
    
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
    
    # Script logic here...
    
    success "🎉 [Script Name] complete!"
}

# Run main function if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

### Adding New Scripts

1. **Follow the naming convention**: `##_script_name.sh`
2. **Add to the master script** in `scripts/setup_master.sh`
3. **Update documentation** in `SCRIPT_ANALYSIS.md`
4. **Add to README.md** if it's a major feature

### Development Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/tiation/ubuntu-dev-setup.git
   cd ubuntu-dev-setup
   ```

2. **Test your changes**
   ```bash
   # Test individual scripts
   ./scripts/01_system_prefs.sh
   
   # Test master script
   ./scripts/setup_master.sh
   ```

3. **Make scripts executable**
   ```bash
   chmod +x scripts/*.sh
   ```

### Pull Request Guidelines

- **Use a clear, descriptive title**
- **Reference related issues** with `Fixes #issue-number`
- **Provide a detailed description** of changes
- **Include testing information**
- **Update documentation** if needed
- **Keep commits atomic** and well-documented

### Code Review Process

1. **Automated checks** will run on your PR
2. **Maintainers will review** your changes
3. **Address feedback** promptly
4. **Squash commits** if requested
5. **Merge** once approved

### Areas for Contribution

- **New package installations** and configurations
- **Bug fixes** and improvements
- **Documentation** enhancements
- **Testing** and validation
- **Performance** optimizations
- **Security** improvements
- **Platform support** (different Ubuntu versions)

### Getting Help

- **Discord**: [Community Server](https://discord.gg/ubuntu-dev-setup)
- **GitHub Issues**: For bug reports and feature requests
- **GitHub Discussions**: For questions and ideas

### Recognition

Contributors will be:
- **Listed in CONTRIBUTORS.md**
- **Mentioned in release notes**
- **Given credit** in documentation

### License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Happy contributing! 🚀**
