eval "$(starship init zsh)"

HISTSIZE=1000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt SHARE_HISTORY

alias rpmo='rpm-ostree'
alias tb='toolbox'
alias db='distrobox'

source <(fzf --zsh)

# make sure that electron apps like slack use wayland
# otherwise there are blurry fonts
# uncomment this if I ever use wayland/sway again
# export ELECTRON_OZONE_PLATFORM_HINT=wayland

alias nvimc="~/.local/scripts/start-nvim-container.sh"
alias dev="distrobox enter dev"

# docker() {
#   podman "$@"
# }
#
# gcloud() {
#   distrobox enter dev -- gcloud "$@"
# }

# . "$HOME/.cargo/env"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by `pipx` on 2024-09-03 16:25:18
export PATH="$PATH:/var/home/j/.local/bin"

# more path
export PATH="$PATH:/var/home/j/.local/scripts"
