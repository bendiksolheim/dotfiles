#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

# FOCUSED_WORKSPACE comes from AeroSpace, but is not available in the
# 'on-focus-changed' AeroSpace event. We therefore query it when it is
# not available
if [ -z "${FOCUSED_WORKSPACE}" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

# Map of app name to icon
# Use https://www.nerdfonts.com/cheat-sheet or SF Symbols for icons
declare -A apps
apps=(
    [Reminders]=""
    [Claude]="󱜙"
    [Safari]="􀎭"
    [Orion]="􀎭"
    [FreeTube]="󰗃"
    [Rio]="􀪏"
    [Ghostty]="􀪏"
    [Zed]=""
    [IntelliJ IDEA]=""
    [Slack]="󰒱"
    [Firefox Developer Edition]="󰈹"
    [Firefox]="󰈹"
    [1Password]="􀠩"
    [Messages]="􀌥"
    [SF Symbols]="􀆔"
    [System Settings]="􀍟"
    [Godspeed]="􀋲"
    [Microsoft Outlook]="􀈣"
    [OrbStack]="󰡨"
    [Notion]=""
    [Bambu Studio]=""
    [TextEdit]="􀌀"
    [Azure Data Studio]=""
    [Preview]=""
    [Boosteroid]="󱎓"
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
