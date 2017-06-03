local current_directory="%{$reset_color%}%c "
local ret_status="%(?:%{$fg[green]%}λ :%{$fg[red]%}λ %s)"

function git_prompt() {
    echo "$(parse_git_dirty)$(git_current_branch)%{$reset_color%} "
}

function git_status() {
    command git rev-parse 2>/dev/null
    is_git_dir=$?
    if [[ $is_git_dir -eq 0 ]]; then
        echo "$(git_prompt)"
    else
        echo ""
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}⟶ "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}"
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"

PROMPT='${current_directory}${ret_status} %{$reset_color%}'
RPROMPT='$(git_status)'

