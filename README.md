# bootstrap-dev-env

A tool to help set up my personal terminal based development environment on new systems from scratch. Going from zero to development in minutes.

## 🚀 Features

This repository provides a single bootstrap script to set up a complete development environment:

- **`bootstrap.sh`** - Full setup with Oh My Zsh and Zsh plugins by default
    - Use `--no-zsh` to skip Zsh-related tooling for a minimal setup

## 🛠️ What Gets Installed

### Core Tools
- **Neovim** - Modern Vim with LazyVim configuration
- **Alacritty** - Fast, GPU-accelerated terminal emulator
- **Tmux** - Catppuccin theme with TPM plugin manager
- **Btop** - Custom themes and configuration
- **iTerm2** - Profile configuration (macOS) - Installed automatically on macOS
- **Zsh** - Optimized shell configuration with aliases and functions
- **FZF** - Fuzzy finder with enhanced previews
- **Ripgrep** - Fast text search
- **Eza** - Modern `ls` replacement
- **Fd** - Fast file finder
- **Zoxide** - Smart `cd` replacement
- **Lazygit** - Git TUI
- **Thefuck** - Command correction
- **Neofetch** - System info display
- **Tldr** - Simplified man pages

### Fonts
- **JetBrains Mono Nerd Font** - Programming font with icons

### Shell Enhancements (default, unless `--no-zsh` is used)
- **Oh My Zsh** - Zsh configuration framework
- **Powerlevel10k** - Fast, feature-rich Zsh theme
- **Zsh Plugins:**
  - **zsh-autosuggestions** - Fish-like autosuggestions
  - **zsh-syntax-highlighting** - Command syntax highlighting
  - **zsh-vi-mode** - Vi keybindings for Zsh
  - **zsh-completions** - Additional completion definitions
  - **zsh-history-substring-search** - Substring search for history

## 📁 Configuration Files

The repository includes pre-configured dotfiles for:

- **Neovim** - LazyVim-based configuration with LSP, Telescope, and more
- **Alacritty** - Catppuccin Mocha theme
- **Tmux** - Catppuccin theme with TPM plugin manager
- **Btop** - Custom themes and configuration
- **iTerm2** - Profile configuration (macOS) - Installed automatically on macOS
- **Zsh** - Optimized shell configuration with aliases and functions

## 🚀 Quick Start

### Prerequisites
- macOS or Linux
- curl

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ddeloss/bootstrap-dev-env.git
   cd bootstrap-dev-env
   ```

2. **Run the setup script:**

   **Full setup (recommended):**
   ```bash
   chmod +x bootstrap.sh
   ./bootstrap.sh
   ```

   **Minimal setup (no Zsh customization):**
   ```bash
   ./bootstrap.sh --no-zsh
   ```

3. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc  # if using Zsh setup
   ```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🛠️ Make It Your Own

This setup is tailored to my personal workflow, but you’re welcome to clone, fork, or adapt it for your own use.
Feel free to use it as a starting point and customize it to fit your preferences and needs!

If you found this useful, consider sharing your own dotfiles or setup scripts to help others in the community.

---

**Happy coding! 🎉** 