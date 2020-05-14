###############
# Completions #
###############

autoload -U compinit
compinit -c

# Arrow key menu for completions
zstyle ':completion:*' menu select

# Case-insensitive (all),partial-word and the substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#################
# Shell options #
#################

setopt AUTO_CD
setopt CORRECT
setopt CORRECT_ALL

# Restore ctrl+r, ctrl+a and so on
bindkey -e

###########
# History #
###########

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

##########
# Prompt #
##########

# Left prompt show current dir and color coded return status
PROMPT='%F{240}%1~%f %(?.%F{green}λ%f.%F{red}λ%f) '

# Right prompt show git info
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' formats '%b'
zstyle 'vcs_info:*' enable git
precmd() {
    vcs_info

    if [[ -n ${vcs_info_msg_0_} ]]; then
        STATUS=$(command git status --porcelain 2> /dev/null | tail -n1)
        if [[ -n $STATUS ]]; then
            RPROMPT='%F{red}${vcs_info_msg_0_}%f'
        else
            RPROMPT='%F{green}${vcs_info_msg_0_}%f'
        fi
    fi
}


###########
# Aliases #
###########

alias l="ls -la"
alias tigs="tig status"
alias markdown="pandoc"

alias tn='tmux new -s'
alias tl='tmux list-sessions'
alias ts='tmux switch -t'
alias ta='tmux attach -t'
alias ec='emacsclient'

# GPG
export GPG_TTY=$(tty)

# Use vim as editor
export EDITOR='vim'

#############
# Functions #
#############

# Find processes using a port
function port() {
    sudo lsof -i :$1
}

# Convenience version of find
function f() {
    find -E . -regex ".*$1.*"
}

# Start web server on given port
function webserver() {
    echo "a ${1}"
    PORT="${1:-3000}"
    echo "Starting webserver on port ${PORT}"
    python -m SimpleHTTPServer $PORT
}
