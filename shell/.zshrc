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

test -f $HOME/.shell-alias && source $HOME/.shell-alias
test -f $HOME/.secrets && source $HOME/.secrets

# lazy initialize nvm/node/npm/npx
export NVM_DIR="$HOME/.nvm"
nvm() {
    unfunction nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

node() {
    unfunction node
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    node "$@"
}

npm() {
    unfunction npm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    npm "$@"
}

npx() {
    unfunction npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    npx "$@"
}

# old way of initializing nvm
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


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
