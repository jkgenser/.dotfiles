# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Setup: Ubuntu Dev VM

One-liner to set up a fresh Ubuntu VM for development:

```bash
curl -sSL https://raw.githubusercontent.com/jkgenser/.dotfiles/main/scripts/setup-dev-vm.sh | bash
```

Or clone first, then run:

```bash
git clone https://github.com/jkgenser/.dotfiles ~/.dotfiles
~/.dotfiles/scripts/setup-dev-vm.sh
```

### What gets installed

| Tool | Description |
|------|-------------|
| zsh + starship | Shell with fancy prompt |
| neovim | Editor (LazyVim config) |
| zellij | Terminal multiplexer |
| fzf | Fuzzy finder |
| rust/cargo | Rust toolchain |
| uv + ty | Python package manager + type checker |
| nvm + node | Node.js version manager |
| gcloud | Google Cloud CLI |
| terraform | Infrastructure as code |
| docker | Container CLI |
| opencode | AI coding assistant |

### Dotfiles linked

The script uses `stow` to symlink these configs:

- `zsh/` - Shell config (`.zshrc`)
- `git/` - Git config (`.gitconfig`)
- `nvim/` - Neovim/LazyVim setup
- `zellij/` - Terminal multiplexer config
- `opencode/` - OpenCode config

## Manual Stow Usage

To link individual configs on any machine:

```bash
cd ~/.dotfiles
stow zsh      # Links .zshrc
stow git      # Links .gitconfig
stow nvim     # Links nvim config
stow zellij   # Links zellij config
```

Desktop-only configs (not used in VMs):

```bash
stow i3       # i3 window manager
stow sway     # Sway (Wayland)
stow alacritty # Terminal emulator
stow polybar  # Status bar
stow rofi     # App launcher
```

## Structure

```
~/.dotfiles/
├── scripts/
│   └── setup-dev-vm.sh    # VM bootstrap script
├── zsh/
│   └── .zshrc
├── git/
│   └── .gitconfig
├── nvim/
│   └── .config/nvim-lazy/
├── zellij/
│   └── .config/zellij/
├── opencode/
│   └── .config/opencode/
└── ... (desktop configs)
```
