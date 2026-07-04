if status is-interactive
    # Remove the fish greeting
    set fish_greeting

    # Use nvim as editor
    set -gx EDITOR nvim
    set -gx VISUAL nvim
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/bendik.solheim/.lmstudio/bin
# End of LM Studio CLI section


# pnpm
set -gx PNPM_HOME "/Users/bendik.solheim/Library/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
