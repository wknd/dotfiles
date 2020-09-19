#!/bin/bash

sleep 2
hexchat &
export QT_QPA_PLATFORMTHEME=gtk3
export TDESKTOP_I_KNOW_ABOUT_GTK_INCOMPATIBILITY=1
telegram-desktop &
signal-desktop &

