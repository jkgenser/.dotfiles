#!/bin/bash

cp -r ../nvim/.config/nvim-lazy .

podman build -t neovim-dev .

rm -R nvim-lazy
