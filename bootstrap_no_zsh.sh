#!/bin/bash

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
    brew install --cask font-jetbrains-mono-nerd-font
else
    alias sys_install="sudo apt-get install -y"
    mkdir -p ~/.local/share/fonts
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.gz
    tar xzvf JetBrainsMono.tar.gz --strip 1 -C ~/.local/share/fonts
    rm JetBrainsMono.tar.gz
fi

sys_install fzf neovim thefuck neofetch tldr git lazygit ripgrep alacritty tmux
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

# Copy dotfiles configurations
cp -R "$PWD"/dotfiles/* "$XDG_CONFIG_HOME"/.
