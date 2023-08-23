#!/usr/bin/env sh

BASEDIR="$(readlink -f $(dirname $0))"

# Setup nvim
mkdir -p ~/.config/nvim
cp -r .docker/lua ~/.config/nvim
cp .docker/init.lua ~/.config/nvim

# Setup packer for nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install plugins in headless mode and quit
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Set safe directory for git
git config --global --add safe.directory /home/porter/app
git config --global core.autocrlf true

# Install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Change default shell to zsh
echo "" | chsh -s $(which zsh)

# Zsh config
echo "export SHELL=$(which zsh)" >> ~/.zshrc
echo "export EDITOR=nvim" >> ~/.zshrc
