# Dotfiles

A collection of some of my dotfiles

## Clone to new machine

(Source: https://www.atlassian.com/git/tutorials/dotfiles)

```sh
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
echo ".dotfiles.git" >> .gitignore
git clone --bare git@github.com:bendiksolheim/dotfiles.git $HOME/.dotfiles.git
dot checkout

# if you get errors, backup the conflicting files and try again

dot config --local status.showUntrackedFiles no
```
