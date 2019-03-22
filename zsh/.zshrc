# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bendik"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git node)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'

# Aliases
alias tigs="tig status"
alias webserver="python -m SimpleHTTPServer 3000"
alias markdown="pandoc"

alias tn='tmux new -s'
alias tl='tmux list-sessions'
alias ts='tmux switch -t'
alias ta='tmux attach -t'

# Maven options
export MAVEN_OPTS="-Xmx16384m -Xms256m -XX:MaxPermSize=8192m"
export M2_REPO=~/.m2/repository

function port() {
    sudo lsof -i :$1
}

function f() {
    find . -iname $1
}
