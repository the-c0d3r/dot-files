#!/bin/env sh

pkill -f bottombar
pkill -f topbar
sleep 1;

polybar -c ~/.config/polybar/bottom.bar bottombar &
polybar -c ~/.config/polybar/top.bar topbar &
