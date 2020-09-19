#!/usr/bin/env bash



echo "Trying to start autohide" | tee -a /tmp/polybar-autohide.log

# TODO: use relative path
lockfile='/home/weekend/.config/polybar/autohide.lock'

if ( set -o noclobber; echo "$$" > "$lockfile") 2> /dev/null; 
then
   trap 'rm -f "$lockfile"; exit $?' INT TERM EXIT

    # TODO: we alreay also check every 30 second, we should also debounce
    xprop -spy -root _NET_CLIENT_LIST_STACKING |
    while read -t 30 -r line || status=$?
    do
        activ_win_id=`xprop -root _NET_ACTIVE_WINDOW`
        propid=`xprop -id ${activ_win_id:40:9}`
        #echo "$propid"
        if [[ $propid ==  *"_NET_WM_STATE_FULLSCREEN"* ]]; then
        	# window is fullscreen
        	xdo hide -N Polybar
        else
        	xdo show -N Polybar
        fi
    done

    echo "end" | tee -a /tmp/polybar-autohide.log
    rm -f "$lockfile"
    trap - INT TERM EXIT
else
   echo "Failed to acquire lockfile: $lockfile." | tee -a /tmp/polybar-autohide.log
   echo "Held by $(cat $lockfile)" | tee -a /tmp/polybar-autohide.log
fi

echo "done" | tee -a /tmp/polybar-autohide.log
