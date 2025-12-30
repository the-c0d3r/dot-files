#!/bin/bash

# Retrieve the current layout mode of the focused space
current_layout=$(yabai -m query --spaces --space | jq -r '.type')

# Determine the next layout mode
case "$current_layout" in
  bsp)
    next_layout="stack"
    ;;
  stack)
    next_layout="float"
    ;;
  float)
    next_layout="bsp"
    ;;
  *)
    next_layout="bsp"
    ;;
esac

hs -c "hs.alert.show('Yabai Layout: $next_layout')"

# Apply the next layout mode
yabai -m space --layout "$next_layout"
