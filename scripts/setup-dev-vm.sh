#!/bin/bash
#
# Development VM Setup Script
# Installs development tools and links dotfiles for an ephemeral coding environment
#
# Usage:
#   curl -sSL https://raw.githubusercontent.com/jkgenser/.dotfiles/main/scripts/setup-dev-vm.sh | bash
#   OR
#   git clone https://github.com/jkgenser/.dotfiles ~/.dotfiles && ~/.dotfiles/scripts/setup-dev-vm.sh
#

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

command_exists() {
    command -v "$1" &> /dev/null
}

# -----------------------------------------------------------------------------
# APT PACKAGES
# -----------------------------------------------------------------------------
install_apt_packages() {
    log_info "Installing system packages via apt..."
    
    sudo apt-get update
    sudo apt-get install -y \
        git \
        git-lfs \
        curl \
        wget \
        unzip \
        build-essential \
        zsh \
        stow \
        ripgrep \
        fd-find \
        jq \
        htop \
        tree \
        ca-certificates \
        gnupg \
        lsb-release
    
    # Initialize git-lfs
    git lfs install
    
    log_success "System packages installed"
}

# -----------------------------------------------------------------------------
# STARSHIP
# -----------------------------------------------------------------------------
install_starship() {
    if command_exists starship; then
        log_success "Starship already installed"
        return
    fi
    
    log_info "Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    log_success "Starship installed"
}

# -----------------------------------------------------------------------------
# FZF
# -----------------------------------------------------------------------------
install_fzf() {
    if [ -d "$HOME/.fzf" ]; then
        log_success "fzf already installed"
        return
    fi
    
    log_info "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash --no-fish
    log_success "fzf installed"
}

# -----------------------------------------------------------------------------
# RUST + CARGO
# -----------------------------------------------------------------------------
install_rust() {
    if command_exists rustc; then
        log_success "Rust already installed"
        return
    fi
    
    log_info "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    log_success "Rust installed"
}

# -----------------------------------------------------------------------------
# ZELLIJ
# -----------------------------------------------------------------------------
install_zellij() {
    if command_exists zellij; then
        log_success "Zellij already installed"
        return
    fi
    
    log_info "Installing Zellij..."
    
    # Ensure cargo is available
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
    
    # Download pre-built binary (faster than cargo install)
    local zellij_version
    zellij_version=$(curl -s https://api.github.com/repos/zellij-org/zellij/releases/latest | jq -r .tag_name)
    local zellij_url="https://github.com/zellij-org/zellij/releases/download/${zellij_version}/zellij-x86_64-unknown-linux-musl.tar.gz"
    
    curl -sSL "$zellij_url" | sudo tar -xz -C /usr/local/bin
    sudo chmod +x /usr/local/bin/zellij
    
    log_success "Zellij installed (${zellij_version})"
}

# -----------------------------------------------------------------------------
# NEOVIM
# -----------------------------------------------------------------------------
install_neovim() {
    if command_exists nvim; then
        log_success "Neovim already installed"
        return
    fi
    
    log_info "Installing Neovim..."
    
    # Get latest stable release
    local nvim_version
    nvim_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r .tag_name)
    local nvim_url="https://github.com/neovim/neovim/releases/download/${nvim_version}/nvim-linux-x86_64.tar.gz"
    
    curl -sSL "$nvim_url" | sudo tar -xz -C /opt
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
    
    log_success "Neovim installed (${nvim_version})"
}

# -----------------------------------------------------------------------------
# UV (Python package manager)
# -----------------------------------------------------------------------------
install_uv() {
    if command_exists uv; then
        log_success "uv already installed"
        return
    fi
    
    log_info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    # Source the env to make uv available
    export PATH="$HOME/.local/bin:$PATH"
    
    log_success "uv installed"
}

# -----------------------------------------------------------------------------
# TY (Python type checker)
# -----------------------------------------------------------------------------
install_ty() {
    if command_exists ty; then
        log_success "ty already installed"
        return
    fi
    
    log_info "Installing ty..."
    
    # Ensure uv is available
    export PATH="$HOME/.local/bin:$PATH"
    
    uv tool install ty
    log_success "ty installed"
}

# -----------------------------------------------------------------------------
# NVM + NODE
# -----------------------------------------------------------------------------
install_nvm() {
    log_info "Installing nvm (no profile edits)..."
    export NVM_DIR="$HOME/.config/nvm"
    mkdir -p "$NVM_DIR"

    # Clone nvm directly instead of using install script (avoids profile modifications)
    if [ ! -s "$NVM_DIR/nvm.sh" ]; then
        git clone --depth=1 https://github.com/nvm-sh/nvm.git "$NVM_DIR"
        (cd "$NVM_DIR" && git checkout v0.40.1 2>/dev/null)
    else
        log_success "nvm already installed"
    fi

    . "$NVM_DIR/nvm.sh"

    log_info "Installing Node.js LTS..."
    if command -v timeout >/dev/null 2>&1; then
        timeout 10m bash -c "source $NVM_DIR/nvm.sh && nvm install --lts --latest-npm" || log_warn "Node install timed out/failed"
    else
        nvm install --lts --latest-npm || log_warn "Node install failed"
    fi

    nvm alias default 'lts/*' >/dev/null 2>&1 || true
    log_success "nvm installed"
}

# -----------------------------------------------------------------------------
# GCLOUD CLI
# -----------------------------------------------------------------------------
install_gcloud() {
    if command_exists gcloud; then
        log_success "gcloud CLI already installed"
        return
    fi
    
    log_info "Installing Google Cloud CLI..."
    
    # Install to ~/google-cloud-sdk to match your zshrc config
    curl -sSL https://sdk.cloud.google.com | bash -s -- --disable-prompts --install-dir="$HOME"
    
    log_success "gcloud CLI installed"
}

# -----------------------------------------------------------------------------
# TERRAFORM
# -----------------------------------------------------------------------------
install_terraform() {
    if command_exists terraform; then
        log_success "Terraform already installed"
        return
    fi
    
    log_info "Installing Terraform..."
    
    # Add HashiCorp GPG key and repo
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
        sudo tee /etc/apt/sources.list.d/hashicorp.list
    
    sudo apt-get update
    sudo apt-get install -y terraform
    
    log_success "Terraform installed"
}

# -----------------------------------------------------------------------------
# DOCKER CLI
# -----------------------------------------------------------------------------
install_docker() {
    if command_exists docker; then
        log_success "Docker already installed"
        return
    fi
    
    log_info "Installing Docker CLI..."
    
    # Add Docker's official GPG key
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    
    # Add the repository
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt-get update
    sudo apt-get install -y docker-ce-cli docker-compose-plugin
    
    log_success "Docker CLI installed"
}

# -----------------------------------------------------------------------------
# OPENCODE
# -----------------------------------------------------------------------------
install_opencode() {
    if command_exists opencode; then
        log_success "OpenCode already installed"
        return
    fi
    
    log_info "Installing OpenCode..."
    curl -fsSL https://opencode.ai/install | bash
    log_success "OpenCode installed"
}

# -----------------------------------------------------------------------------
# DOTFILES
# -----------------------------------------------------------------------------
setup_dotfiles() {
    log_info "Setting up dotfiles..."
    
    local DOTFILES_DIR="$HOME/.dotfiles"
    local DOTFILES_REPO="https://github.com/jkgenser/.dotfiles"
    
    # Clone if not already present
    if [ ! -d "$DOTFILES_DIR" ]; then
        log_info "Cloning dotfiles..."
        git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
    else
        log_info "Dotfiles already cloned, pulling latest..."
        git -C "$DOTFILES_DIR" pull --ff-only || true
    fi
    
    cd "$DOTFILES_DIR"
    
    # Backup existing files that would conflict
    local configs=(.zshrc .gitconfig)
    for config in "${configs[@]}"; do
        if [ -f "$HOME/$config" ] && [ ! -L "$HOME/$config" ]; then
            log_warn "Backing up existing $config to ${config}.bak"
            mv "$HOME/$config" "$HOME/${config}.bak"
        fi
    done
    
    # Stow the dotfiles (VM-relevant ones only)
    log_info "Linking dotfiles with stow..."
    stow -v --restow zsh
    stow -v --restow git
    stow -v --restow nvim
    stow -v --restow zellij
    stow -v --restow opencode
    
    log_success "Dotfiles linked"
}

# -----------------------------------------------------------------------------
# POST-INSTALL
# -----------------------------------------------------------------------------
post_install() {
    log_info "Running post-install tasks..."
    
    # Change default shell to zsh
    if [ "$SHELL" != "$(which zsh)" ]; then
        log_info "Changing default shell to zsh..."
        sudo chsh -s "$(which zsh)" "$USER"
    fi
    
    # Bootstrap Neovim plugins (headless)
    log_info "Bootstrapping Neovim plugins (this may take a minute)..."
    export NVIM_APPNAME="nvim-lazy"
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    
    log_success "Post-install complete"
}

# -----------------------------------------------------------------------------
# MAIN
# -----------------------------------------------------------------------------
main() {
    echo ""
    echo "========================================"
    echo "  Development VM Setup Script"
    echo "========================================"
    echo ""
    
    # Check if running as root
    if [ "$EUID" -eq 0 ]; then
        log_error "Please run this script as a normal user (not root)"
        exit 1
    fi
    
    # Run installations
    install_apt_packages
    install_starship
    install_fzf
    install_rust
    install_zellij
    install_neovim
    install_uv
    install_ty
    install_nvm
    install_gcloud
    install_terraform
    install_docker
    install_opencode
    setup_dotfiles
    post_install
    
    echo ""
    echo "========================================"
    echo "  Setup Complete!"
    echo "========================================"
    echo ""
    echo "Installed:"
    echo "  - zsh + starship prompt"
    echo "  - neovim + LazyVim"
    echo "  - zellij"
    echo "  - fzf"
    echo "  - rust/cargo"
    echo "  - uv + ty"
    echo "  - nvm + node.js"
    echo "  - gcloud cli"
    echo "  - terraform"
    echo "  - docker cli"
    echo "  - opencode"
    echo ""
    echo "Dotfiles linked: zsh, git, nvim, zellij, opencode"
    echo ""
    log_warn "Please log out and back in (or run 'exec zsh') to use zsh as your shell"
    echo ""
}

main "$@"
