# Go to directory of currently opened file
cd $(dirname "$ZED_FILE")

# Check if this folder is inside a git repository
is_git_repo=$(git rev-parse --is-inside-work-tree 2>/dev/null)
if [ "$is_git_repo" = "true" ]; then

    # Get URL to remote
    git_url=$(git config --get remote.origin.url)

    # Make it a valid http URL
    git_url=$(sed 's/git@github.com:/https:\/\/github.com\//' <<< $git_url)

    # Remove .git from the end of git_url
    github_url=${git_url%.git}
    open "$github_url"
fi
