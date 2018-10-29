#!/bin/env sh

pkill -f pbar
sleep 1;

polybar -c bottom.bar bottombar &
polybar -c top.bar topbar &
