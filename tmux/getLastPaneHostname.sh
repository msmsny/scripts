#!/bin/sh
#
# tmux server-infoからアクティブペインを取得し, sshしていればssh先のhostname取得
#

# path
if `type "$HOME/local/opt/bin/tmux" > /dev/null 2>&1`; then
  _TMUX="$HOME/local/opt/bin/tmux"
else
  _TMUX="/usr/local/bin/tmux"
fi

SIP=$($_TMUX display -p "#S:#I:#P")
PTY=$($_TMUX info |
  egrep flags=\|bytes |
  awk '/windows/ { s = $2 }
       /references/ { i = $1 }
       /bytes/ { print s i $1 $2 } ' |
  grep "$SIP" |
  cut -d: -f4)
PTS=${PTY#/dev/}
echo -n `ps -U $USER -o pid,tty,command -ww | awk '$2 == "'$PTS'" && match($0, /ssh\ .+$/) {print substr($0, RSTART + 4, RLENGTH)}'`
