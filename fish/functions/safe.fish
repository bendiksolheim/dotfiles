function safe
  safehouse \
      --append-profile="$HOME/.config/agent-safehouse/local-overrides.sb" \
      --env-pass=REX_BIN_DIR,REX_BLOCK,REX_SESSION,REX_SERVER \
      $argv
end
