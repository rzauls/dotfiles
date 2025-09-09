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
setopt CORRECT

export EDITOR=nvim
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# show running jobs in prompt
setopt PROMPT_SUBST
job_status() {
    local stopped=$(jobs -s | wc -l | tr -d ' ')
    local running=$(jobs -r | wc -l | tr -d ' ')
    local output=""
    if [[ $stopped -gt 0 ]]; then
        output="${output}%F{yellow}⏸${stopped}%f"
    fi

    if [[ $running -gt 0 ]]; then
        output="${output}%F{green}▶${running}%f"
    fi

    if [[ -n "$output" ]]; then
        JOB_STATUS="[${output}] "
    else
        JOB_STATUS=""
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd job_status

PROMPT='${JOB_STATUS}%F{green}%n@%m% %F{blue} %~%f: '

test -f $HOME/.shell-alias && source $HOME/.shell-alias
test -f $HOME/.secrets && source $HOME/.secrets

# path
export PATH="$HOME/.local/bin:$PATH"
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

# node
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

# keybinds
bindkey -s ^f "tmux-sessionizer\n" # <leader>f to switch projects

# edit cmdline in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line # v in normal mode

# display block/beam cursor depending on current vi mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'  # Block cursor for normal mode
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'  # Beam cursor for insert mode
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    echo -ne "\e[5 q"  # Beam cursor on startup
}
zle -N zle-line-init
preexec() { echo -ne '\e[5 q' ;}

# end of profiler
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
