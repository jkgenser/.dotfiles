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
export PATH="$PATH:/home/j/.local/bin"

# more path
export PATH="$PATH:/home/j/.local/scripts"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


din() {
    # Check if an argument is provided
    if [ -z "$1" ]; then
        echo "Usage: din <container_name_part>"
        return 1
    fi

    # Find the first container ID that contains the argument in its name
    CONTAINER_ID=$(podman ps --format "{{.ID}} {{.Names}}" | grep "$1" | awk '{print $1}' | head -n 1)

    # Check if a container was found
    if [ -z "$CONTAINER_ID" ]; then
        echo "No running container found with name containing: $1"
        return 1
    fi

    # Exec into the container
    podman exec -it "$CONTAINER_ID" /bin/bash
}

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
