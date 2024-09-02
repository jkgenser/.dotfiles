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

