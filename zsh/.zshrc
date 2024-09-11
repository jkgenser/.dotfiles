eval "$(starship init zsh)"

HISTSIZE=1000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt SHARE_HISTORY

alias rpmo='rpm-ostree'
alias tb='toolbox'
alias db='distrobox'

# maybe uncomment this when we get a more recent version of fzf
# source <(fzf --zsh)

# make sure that electron apps like slack use wayland
# otherwise there are blurry fonts
# uncomment this if I ever use wayland/sway again
# export ELECTRON_OZONE_PLATFORM_HINT=wayland

alias nvimc="~/.local/scripts/start-nvim-container.sh"
alias dev="distrobox enter dev"
export NVIM_APPNAME="nvim-lazy"

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
export PATH="$PATH:/home/j/.local/bin"

# more path
export PATH="$PATH:/home/j/.local/scripts"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



# Start SSH agent if not already running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi


# Created by `pipx` on 2024-09-07 15:33:37
export PATH="$PATH:/home/j/.local/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/j/google-cloud-sdk/path.zsh.inc' ]; then . '/home/j/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/j/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/j/google-cloud-sdk/completion.zsh.inc'; fi
