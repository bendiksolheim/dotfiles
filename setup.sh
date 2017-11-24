DOTFILES="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup"

mkdir -p $BACKUP_DIR

declare -a FILES_TO_SYMLINK=(
    'git/.gitconfig'
    'git/.gitignore_global'
    'tig/.tigrc'
    'tmux/.tmux.conf'
    'zsh/.zshrc'
)

for i in ${FILES_TO_SYMLINK[@]}; do
    file="${i##*/}"
    file_dotfiles="$DOTFILES/$i"
    file_home="$HOME/$file"

    # Check if file exists and back up
    if [[ -f "$file_home" ]]; then
        file_backup="$BACKUP_DIR/$file"
        echo "$file already exists, backing up.."
        mv $file_home $file_backup
    fi

    # Don’t do anything if there is a symlink already, inform instead
    if [[ -L "$file_home" ]]; then
        echo "$file_home is already a symlink, please check this manually"
    else
        echo "Creating symlink from $file_home to $file_dotfiles"
        ln -s $file_dotfiles $file_home
    fi
done
