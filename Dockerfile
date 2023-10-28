FROM alpine:latest

RUN apk update && apk upgrade;\
    apk add doas;\
    adduser -g 'Porter' porter;\
    echo "porter:" | chpasswd;\
    adduser porter wheel;\
    echo "permit persist :wheel" > "/etc/doas.d/doas.conf"

# Run system config script
COPY .docker/config.sh /root/config.sh
RUN sh /root/config.sh

# Neovim config
RUN mkdir -p /root/.config/nvim
COPY .docker/mini.lua /root/.config/nvim/init.lua

# Install LaTeX full distribution, use texmf-dist for smaller size
RUN apk add texmf-dist-full texlive biber

# Copy and change owner of setup scripts
COPY .docker /home/porter/.docker
COPY compile.sh /home/porter
RUN chown -R porter /home/porter/.docker &&\
    chown porter /home/porter/compile.sh

USER porter
WORKDIR /home/porter

## Set zsh as default shell
#RUN echo "porter:" | chsh -s $(which zsh) porter

# Run setup.sh as porter
RUN sh .docker/setup.sh

# Set final working directory
RUN mkdir -p /home/porter/app
WORKDIR /home/porter/app

CMD ["zsh"]

