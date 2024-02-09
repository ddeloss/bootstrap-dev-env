#/bin/bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ARCH=uname

if [["$SARCH" == Darwin]]
    brew_path="$(/usr/bin/find /usr/local/bin /opt -maxdepth 3 -name brew 2>/dev/null)"

    if [[ -n $brew_path ]]; then
        logging "brew is already installed..."
    else
        logging "info" "Homebrew is not installed..."
        if [[ "$UNAME_MACHINE" == "arm64" ]]; then
          # M1/arm64 machines
          HOMEBREW_PREFIX="/opt/homebrew"
        else
          # Intel machines
          HOMEBREW_PREFIX="/usr/local/homebrew"
        fi
        mkdir ${HOMEBREW_PREFIX}
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C ${HOMEBREW_PREFIX}
        eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)" brew update --force --quiet chmod -R go-w "$(brew --prefix)/share/zsh"
    fi
    alias sys_intall = "sudo ${HOMEBREW_PREFIX}/bin/brew"
    brew tap homebrew/cask-fonts
    brew tap homebrew/cask-fonts/font-inconsolata-nerd-font
else
  alias sys_install = "sudo apt-get install"
  mkdir ~/.local/share/fonts
  curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/InconsolataNerdFont.tar.xz | tar xz --strip 1 -C ~/.local/share/fonts
fi

sys_install fzf nvim git lazygit ripgrep alacritty tmux
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"/zshrc
mkdir -p "$XDG_CONFIG_HOME"/alacritt

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cp horizon-dark.toml ~/.config/alacritty/themes/themes/horizon-dark.toml

ln -sf "$PWD/alacritty.toml" "$XDG_CONFIG_HOME"/alacritty/alacritty.toml
ln -sf "$PWD/.zshrc" "$HOME"/.zshrc
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim
