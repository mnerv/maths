#!/usr/bin/env sh

BASEDIR="$(readlink -f $(dirname $0))"

# Setup nvim
mkdir -p ~/.config/nvim
cp -r .docker/lazy/* ~/.config/nvim

# Install plugins in headless mode and quit
nvim --headless "+Lazy! sync" +qa

# git configuration
git config --global --add safe.directory /home/porter/app
git config --global core.autocrlf true

# Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change default shell to zsh
echo "" | chsh -s $(which zsh)

# zsh config
echo "export SHELL=$(which zsh)" >> ~/.zshrc
echo "export EDITOR=nvim" >> ~/.zshrc
echo "alias ls=exa" >> ~/.zshrc
echo "alias cat='bat -p --paging=never'" >> ~/.zshrc

