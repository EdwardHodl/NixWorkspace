#!/bin/sh
##
# Linux unlock gnome keyring
# see: https://unix.stackexchange.com/a/676655#
#
     read -rsp "Password: " pass
     export $(echo -n "$pass" | gnome-keyring-daemon --replace --unlock)
     unset pass
