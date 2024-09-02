#!/bin/bash

NVIM_CONFIG_NAME=nvim-lazy
IMAGE_NAME=neovim-dev

podman run --rm --name neovim-container --replace -it \
  -v $HOME/.config/$NVIM_CONFIG_NAME:/root/.config/nvim:Z \
  -v $(pwd):/workspace:Z \
  -w /workspace \
  $IMAGE_NAME /bin/bash -c "$@"
