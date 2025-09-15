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

# prevent zellij from going into vi mode
bindkey -e

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



# Start the SSH agent if it's not already running
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -s > "$HOME/.ssh/ssh-agent-info"
fi
if [ -f "$HOME/.ssh/ssh-agent-info" ]; then
    . "$HOME/.ssh/ssh-agent-info"
fi

# opencode
export PATH=/home/j/.opencode/bin:$PATH

# export EDITOR=nvim

# prevent zellij from going into vi mode
bindkey -e
