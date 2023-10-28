#!/usr/bin/env sh
deps="
curl
git
neofetch
neovim
neovim-doc
openssh
tmux
wget
ripgrep
nodejs
shadow
htop
exa
bat
parallel
openssl
zsh
build-base
"
deps=$(printf "$deps" | tr '\n' ' ' | sed -e 's/^[[:space:]]*//')

apk add --no-cache $deps
