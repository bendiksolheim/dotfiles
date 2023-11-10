if [[ $TERM == "dumb" ]]
then
    unsetopt zle 
    unsetopt prompt_cr
    unsetopt prompt_subst
    if whence -w precmd >/dev/null; then
        unfunction precmd
    fi
    if whence -w preexec >/dev/null; then
        unfunction preexec
    fi
    PS1='$ '
fi

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

# Shell colors
export CLICOLORS=1

setopt AUTO_CD

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

alias l="ls -laGh"
alias tigs="tig status"
alias markdown="pandoc"

# Zellij
alias zl='zellij ls'
alias zn='zellij -s'
alias za='zellij a'
alias zk='zellij kill-session'

# Docker
alias dps='docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Status}}\t{{.Ports}}"'
alias docker-start-exited="docker ps -f status=exited | awk '{ if (NR!=1) { print $1 }}' | xargs docker start"

# GPG
export GPG_TTY=$(tty)

# Use vim as editor
export EDITOR='vim'

#############
# Functions #
#############

# Find processes using a port
function port() {
    lsof -i :"$1"
}

# Start web server on given port
function webserver() {
    echo "a ${1}"
    PORT="${1:-3000}"
    echo "Starting webserver on port ${PORT}"
    python -m SimpleHTTPServer "$PORT"
}

###########################
# Java Version management #
###########################

# Utility function to extract version from release file in java folder
_java_version() {
    local version_path=$1
    if [[ -f $version_path/release ]]; then
        grep "JAVA_VERSION=" < "$version_path"/release | sed -E 's/JAVA_VERSION=|\"//g'
    else
        echo "$version_path"
    fi
}

# List current version with "jdk", or change with "jdk 12"
jdk() {
    local version=${1:-""}
    local silent=${2:-false}
    if [[ $version = "" ]]; then
        java -version
    else
        # Big Sur never changes version if JAVA_HOME is set. Unset it first.
        unset JAVA_HOME
        JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        export JAVA_HOME
        if [[ $silent = false ]]; then
            java -version
        fi
    fi
}

# List available, globally set, and locally set java versions with "jdks"
jdks() {
    echo "Java versions"
    /usr/libexec/java_home -V 2>&1 | sed 1d | sed '$d' | cut -d, -f1
    echo "Global: $(_java_version "$(/usr/libexec/java_home)")"
    if [[ -n $JAVA_HOME ]]; then
        echo "Local:  $(_java_version "$JAVA_HOME")"
    fi
}

# Automatically change java version froom .java-version file
autoload -U add-zsh-hook
_jdk_autoload_hook() {
    if [[ -f .java-version ]]; then
        jdk "$(cat .java-version)" true
    fi
}

add-zsh-hook chpwd _jdk_autoload_hook

###################
# Custom config   #
###################

source ~/.zshrc-custom

# bun completions
[ -s "/Users/bendik/.bun/_bun" ] && source "/Users/bendik/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
