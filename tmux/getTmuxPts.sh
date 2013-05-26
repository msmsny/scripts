#!/bin/sh
#
# tmux server-infoから起動しているtmuxの端末名を出力する
#

# path
if `type "$HOME/local/opt/bin/tmux" > /dev/null 2>&1`; then
  _TMUX="$HOME/local/opt/bin/tmux"
else
  _TMUX="/usr/local/bin/tmux"
fi

if `$_TMUX ls > /dev/null 2>&1`; then
  SIP=$($_TMUX display -p "#S:#I:#P")
  PTY=$($_TMUX info |
    egrep flags=\|bytes |
    awk '/windows/ { s = $2 }
         /references/ { i = $1 }
         /bytes/ { print s i $1 $2 } ' |
    grep "$SIP" |
    cut -d: -f4)
  echo ${PTY#/dev/}
fi
