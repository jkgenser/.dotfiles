eval "$(starship init zsh)"

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history
HISTORY_IGNORE="export*"
setopt APPEND_HISTORY
setopt SHARE_HISTORY

alias tf='terraform'
alias z='zellij'


# make sure that electron apps like slack use wayland
export ELECTRON_OZONE_PLATFORM_HINT=wayland

alias ac="source .venv/bin/activate"
export NVIM_APPNAME="nvim-lazy"
export PYTHONBREAKPOINT=ipdb.set_trace

# zsh key bindings
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word


# . "$HOME/.cargo/env"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by `pipx` on 2024-09-03 16:25:18
export PATH="$PATH:/home/j/.local/bin"

# more path
export PATH="$PATH:/home/j/.local/scripts"

export PATH="$PATH:$HOME/.cargo/bin"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Created by `pipx` on 2024-09-07 15:33:37
export PATH="$PATH:/home/j/.local/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/j/google-cloud-sdk/path.zsh.inc' ]; then . '/home/j/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/j/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/j/google-cloud-sdk/completion.zsh.inc'; fi



export PYTHONPATH="$HOME/oler-ta:$HOME/oler:$HOME/oler/server:$HOME/oler/rpa:$HOME/oler/olerlib:$PYTHONPATH"


# SSH
# GPG-Agent as SSH Agent
# Ensures that the SSH_AUTH_SOCK environment variable points
# to the gpg-agent's SSH socket.
# This makes gpg-agent handle SSH authentication for all new Zsh shells.
if command -v gpgconf >/dev/null 2>&1; then
    # Get the gpg-agent SSH socket path.
    # We use `gpgconf` as it's the most reliable way to get the active socket.
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

    # Add any specific SSH keys to the gpg-agent if they are not already added.
    # This assumes your default keys are in ~/.ssh/.
    # You might not need this if you already use `ssh-add` manually or if
    # the agent remembers keys from previous sessions.
    # Consider if you want this to run every time or only if keys are missing.
    # if ! ssh-add -l >/dev/null 2>&1; then
    #    ssh-add ~/.ssh/id_rsa ~/.ssh/id_ed25519 # Add your specific key paths here
    # fi
fi

# Prevent system-wide ssh-agent from interfering.
# This helps avoid spawning redundant ssh-agent instances.
unset SSH_AGENT_PID
