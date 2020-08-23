#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ connected /{print $1}')"

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Dim the screen after 500 seconds, undim if user becomes active` \
  --timer 500 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .5' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 10 more seconds` \
  --timer 180 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1; blurlock' \
    '' \
  `# Finally, suspend an hour after it locks` \
  --timer 1800 \
    'systemctl suspend' \
    ''
