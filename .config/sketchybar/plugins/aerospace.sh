#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

# FOCUSED_WORKSPACE comes from AeroSpace, but is not available in the
# 'on-focus-changed' AeroSpace event. We therefore query it when it is
# not available
if [ -z "${FOCUSED_WORKSPACE}" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

# Map of app name to icon
declare -A apps
apps=(
    [Safari]="􀎭"
    [FreeTube]="󰗃"
    [Rio]="􀪏"
    [Zed]=""
    [Slack]="󰒱"
    [Firefox Developer Edition]="󰈹"
    [1Password]="􀠩"
    [Messages]="􀌥"
    [SF Symbols]="􀆔"
    [System Settings]="􀍟"
)

# Create list of app icons in requested workspace
current_workspace_apps=$(
  aerospace list-windows --workspace $1 \
      | awk -F'|' '{print $2}' \
      | sort \
      | uniq \
      | while read -r app; do
          app="${app## }"
          app="${app%% }"
          echo "${apps[$app]:-󰘔}"
        done \
      | tr -d '\n'
)

sketchybar --set $NAME label="$1 $current_workspace_apps"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.color=$ACTIVE_COLOR
else
    sketchybar --set $NAME label.color=$LABEL_COLOR
fi
