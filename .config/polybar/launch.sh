#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch top and not bar2
echo "---" | tee -a /tmp/polybar1.log
sleep 1
polybar overlay >>/tmp/polybar1.log 2>&1 & disown
sleep 1
# gotta make sure we're on top of xfce4-panel
xdo raise -m -N Polybar

echo "Bars launched..."
