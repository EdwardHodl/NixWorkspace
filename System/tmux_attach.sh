#!/bin/sh
##
## Configure NixOS to automatically attach users to existing Tmux sessions or create new ones

if [ -n "$SSH_TTY" ]; then
  if [ -z "$TMUX" ]; then
    tmux has-session -t "$USER" 2>/dev/null
      if [ $? != 0 ]; then
          tmux new-session -s "$USER" -n "$USER" -d
          tmux attach-session -t "$USER"
      else
          tmux attach-session -t "$USER"
      fi
    else
      /bin/sh
  fi
fi

