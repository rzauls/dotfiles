# start shell profiler if ZSH_DEBUGRC=true
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# disable checking for auto updates
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# compile autocopmletions once a day and cache them
autoload -Uz compinit
setopt EXTENDEDGLOB
for dump in ~/.zcompdump(N.mh+24); do
    compinit
    if [[ -s "$dump" && (! -s "${dump}.zwc" || "$dump" -nt "${dump}.zwc") ]]; then
        zcompile "$dump"
    fi
done
unsetopt EXTENDEDGLOB
compinit -C

# ignore case for completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

unsetopt autocd

export PATH="$HOME/.local/bin:$PATH"
export EDITOR=nvim

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/zig
export PATH=$PATH:~/go/bin
export PATH=$PATH:~/projects/scripts/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
export PATH=$PATH:~/projects/godot/bin
export PATH=$PATH:~/.config/composer/vendor/bin
export PATH=$PATH:~/.scripts/bin
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

test -f $HOME/.shell-alias && source $HOME/.shell-alias
test -f $HOME/.secrets && source $HOME/.secrets

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# rust
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# fzf
if [[ $- == *i* ]]; then  # only in interactive shells
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    eval "$(fzf --zsh)"
    eval "$(direnv hook zsh)"
fi

PROMPT='%F{green}%n@%m% %F{blue} %~%f: '

# end of profiler
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rihards/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rihards/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rihards/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rihards/Downloads/google-cloud-sdk/completion.zsh.inc'; fi


export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

PATH=$(pyenv root)/shims:$PATH

bindkey -s ^f "tmux-sessionizer\n"
