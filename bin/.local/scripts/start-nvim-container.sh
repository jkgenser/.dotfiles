#!/bin/bash

NVIM_APPNAME=nvim-lazy
IMAGE_NAME=neovim-dev
CONTAINER_NAME="neovim-container-$(date +%s)"

podman run --rm --name ${CONTAINER_NAME} -it \
  -v $HOME/.dotfiles/nvim/.config/$NVIM_APPNAME:/root/.config/nvim:z \
  -v $(pwd):/workspace:z \
  -w /workspace \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /dev/shm:/dev/shm \
  --user $(id -u)$(id -g) \
  $IMAGE_NAME /bin/bash -c "nvim $@"
