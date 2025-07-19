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

# Initialize sys_install variable
sys_install=""

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
	sys_install="${HOMEBREW_PREFIX}/bin/brew install"
	brew install --cask font-jetbrains-mono-nerd-font iterm2
else
	sys_install="sudo apt-get install -y"
	mkdir -p ~/.local/share/fonts
	curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.gz
	tar xzvf JetBrainsMono.tar.gz --strip 1 -C ~/.local/share/fonts
	rm JetBrainsMono.tar.gz
fi

# Install system packages
$sys_install btop eza fd fzf neovim thefuck neofetch tldr git lazygit ripgrep alacritty tmux zoxide

# Create tmux plugin directories and clone plugins
mkdir -p ~/.config/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm 2>/dev/null || (rm -rf ~/.config/tmux/plugins/tpm && git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm)
git clone https://github.com/catppuccin/tmux ~/.config/tmux/plugins/catppuccin 2>/dev/null || (rm -rf ~/.config/tmux/plugins/catppuccin && git clone https://github.com/catppuccin/tmux ~/.config/tmux/plugins/catppuccin)

# Install tmux plugins automatically
echo "Installing tmux plugins..."
~/.config/tmux/plugins/tpm/bin/install_plugins

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

	# Check if Oh My Zsh is already installed
	if [[ -d "$HOME/.oh-my-zsh" ]]; then
		echo "Oh My Zsh is already installed. Skipping installation..."
	else
		# Install Oh My Zsh
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi

	# Install zsh-vi-mode via package manager
	$sys_install zsh-vi-mode

	# Create custom directory if it doesn't exist
	mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes"
	mkdir -p "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

	# Install zsh themes and plugins with cleanup for existing installations
	echo "Installing zsh themes and plugins..."
	
	# Powerlevel10k theme
	rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" 2>/dev/null
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
	
	# Zsh plugins
	rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" 2>/dev/null
	git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
	
	rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" 2>/dev/null
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
	
	rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-vi-mode" 2>/dev/null
	git clone https://github.com/jeffreytse/zsh-vi-mode "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-vi-mode"
	
	rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions" 2>/dev/null
	git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"
	
	rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search" 2>/dev/null
	git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"
	
	# Install fzf-git.sh
	echo "Installing fzf-git.sh..."
	rm -rf "$HOME/fzf-git.sh" 2>/dev/null
	git clone https://github.com/junegunn/fzf-git.sh.git "$HOME/fzf-git.sh"

	echo "Copying .zshrc configuration..."
	# Backup existing .zshrc
	mv "$HOME/.zshrc" "$HOME/.zshrc.bak" 2>/dev/null
	# Copy the dotfiles .zshrc
	cp "$PWD"/dotfiles/.zshrc "$HOME"/.zshrc
else
	echo "Skipping Zsh tooling installation..."
fi

# Copy dotfiles configurations
cp -R "$PWD"/dotfiles/* "$XDG_CONFIG_HOME"/.
cp -R "$PWD"/dotfiles/.p10k.zsh "$HOME"/.

echo ""
echo "✅ Bootstrap complete!"
if [[ "$INSTALL_ZSH" == true ]]; then
	echo "🔄 Please restart your terminal or run: source ~/.zshrc"
else
	echo "🔄 Please restart your terminal to apply changes"
fi
