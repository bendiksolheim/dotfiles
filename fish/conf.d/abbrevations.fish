# vim -> nvim
if type -q nvim
    abbr --add vim nvim
end

# ls -> exa
if type -q eza
    abbr --add l 'eza --long --classify --all --header --git --tree --level 1'
end

# tig
if type -q tig
    abbr --add tigs tig status
end

abbr --add dot '/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
