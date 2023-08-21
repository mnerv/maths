FROM alpine:latest

RUN apk update && apk upgrade;\
    apk add doas;\
    adduser -g 'Porter' porter;\
    echo "porter:" | chpasswd;\
    adduser porter wheel;\
    echo "permit persist :wheel" > "/etc/doas.d/doas.conf"

RUN apk add --no-cache \
    curl \
    git \
    neofetch \
    neovim \
    openssh \
    tmux \
    wget \
    ripgrep \
    nodejs \
    shadow \
    htop \
    zsh

# Neovim config
RUN mkdir -p /root/.config/nvim
COPY .docker/mini.lua /root/.config/nvim/init.lua

# Install LaTeX full distribution, use texmf-dist for smaller size
RUN apk add texmf-dist-full texlive biber

USER porter
WORKDIR /home/porter

## Set zsh as default shell
#RUN echo "porter:" | chsh -s $(which zsh) porter

# Setup script
COPY .docker /home/porter/.docker
RUN sh .docker/setup.sh

# Set final working directory
RUN mkdir -p /home/porter/app
WORKDIR /home/porter/app

CMD ["zsh"]

