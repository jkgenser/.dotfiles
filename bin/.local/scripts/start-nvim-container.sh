#!/bin/bash

NVIM_APPNAME=nvim-lazy
IMAGE_NAME=neovim-dev

podman run --rm --name neovim-container --replace -it \
  -v $HOME/.dotfiles/nvim/.config/$NVIM_APPNAME:/root/.config/nvim:z \
  -v $(pwd):/workspace:z \
  -w /workspace \
  $IMAGE_NAME /bin/bash -c "nvim $@"
