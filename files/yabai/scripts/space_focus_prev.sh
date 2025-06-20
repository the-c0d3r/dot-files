#!/bin/bash

info=$(yabai -m query --spaces --display)
first=$(echo $info | jq '.[0]."has-focus"')

if [[ $first == "false" ]]; then
    yabai -m space --focus prev
    sleep 0.1
    current_space=$(yabai -m query --spaces --space | jq -r '.index')
    hs -c '
        if _G.ca then _G.ca:delete() end
        local w = hs.window.frontmostWindow()
        local txt = "'$current_space'" .. " • " .. (w and w:application():name() or "?")
        local f = hs.screen.mainScreen():frame()
        _G.ca = hs.canvas.new{
          x = f.x + f.w/2 - 100, y = f.y + f.h/2 - 15, w = 150, h = 30
        }:appendElements(
          {type="rectangle", action="fill", fillColor={white=0,alpha=0.8}, roundedRectRadii={8,8}},
          {type="text", text=txt, textSize=24, textColor={white=1}, textAlignment="center"}
        ):show()
        hs.timer.doAfter(1, function() if _G.ca then _G.ca:delete(); _G.ca=nil end end)
    '
fi
