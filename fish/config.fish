if status is-interactive
    # Remove the fish greeting
    set fish_greeting

    # Use nvim as editor
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end
