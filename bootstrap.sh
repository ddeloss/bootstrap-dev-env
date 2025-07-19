#!/bin/bash

# Bootstrap Development Environment
# Usage: ./bootstrap.sh [--no-zsh]
#   --no-zsh: Skip Oh My Zsh and Zsh-related installations

# Parse command line arguments
INSTALL_ZSH=true
if [[ "$1" == "--no-zsh" ]]; then
    INSTALL_ZSH=false
    echo "Zsh tooling will be skipped (minimal setup)"
else
    echo "Full setup with Zsh tooling will be installed"
fi

ARCH=$(uname -m)
OS=$(uname)

if [[ "$OS" == "Darwin" ]]; then
    # Find Homebrew
    brew_path=$(/usr/bin/find /usr/local/bin /opt -maxdepth 3 -name brew 2>/dev/null)

    if [[ -n $brew_path ]]; then
        echo "brew is already installed..."
    else
        echo "Homebrew is not installed..."
        if [[ "$ARCH" == "arm64" ]]; then
            # M1/arm64 machines
            HOMEBREW_PREFIX="/opt/homebrew"
        else
            # Intel machines
            HOMEBREW_PREFIX="/usr/local/homebrew"
        fi
        mkdir -p ${HOMEBREW_PREFIX}
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ${HOMEBREW_PREFIX}
        eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"
        brew update --force --quiet
        chmod -R go-w "$(brew --prefix)/share/zsh"
    fi
    alias sys_install="${HOMEBREW_PREFIX}/bin/brew install"
    brew tap homebrew/cask-fonts
    brew install --cask font-jetbrains-mono-nerd-font iterm2
else
    alias sys_install="sudo apt-get install -y"
    mkdir -p ~/.local/share/fonts
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.gz
    tar xzvf JetBrainsMono.tar.gz --strip 1 -C ~/.local/share/fonts
    rm JetBrainsMono.tar.gz
fi

sys_install btop eza fd fzf neovim thefuck neofetch tldr git lazygit ripgrep alacritty tmux zoxide
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
git clone https://github.com/catppuccin/tmux ~/.config/tmux/plugins/catppuccin

# Backup existing config and clone new one
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

export XDG_CONFIG_HOME="$HOME"/.config

# Install zsh themes and plugins only if Zsh tooling is requested
if [[ "$INSTALL_ZSH" == true ]]; then
    echo "Installing Oh My Zsh and Zsh tooling..."
    
    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    sys_install zsh-vi-mode 
    # Install zsh themes and plugins
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    git clone https://github.com/jeffreytse/zsh-vi-mode "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-vi-mode"
    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"
    git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
else
    echo "Skipping Zsh tooling installation..."
fi

# Copy dotfiles configurations
cp -R "$PWD"/dotfiles/* "$XDG_CONFIG_HOME"/.
cp -R "$PWD"/dotfiles/.p10k.zsh "~/.p10k.zsh"/.

echo ""
echo "✅ Bootstrap complete!"
if [[ "$INSTALL_ZSH" == true ]]; then
    echo "🔄 Please restart your terminal or run: source ~/.zshrc"
else
    echo "🔄 Please restart your terminal to apply changes"
fi
