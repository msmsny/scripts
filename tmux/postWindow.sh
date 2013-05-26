#!/bin/sh
#
# new-windowまたはsplit-windowしたあとに行う処理のスクリプト
#

# path
## ローカルにtmuxがあればそれを使う
if `type "$HOME/local/opt/bin/tmux" > /dev/null 2>&1`; then
  _TMUX="$HOME/local/opt/bin/tmux"
## なければ/usr/local/bin/tmuxにする
else
  _TMUX="/usr/local/bin/tmux"
fi
GET_LAST_HOSTNAME_SH="$HOME/git/scripts/tmux/getLastPaneHostName.sh"

# 直前のwindow/paneに戻るコマンドを決める
case "$1" in
  'new' )
    lastCommand='last-window'
    ;;
  'split' )
    lastCommand='last-pane'
    ;;
  * )
    return
    ;;
esac

# split前のwindow/paneに移動
$_TMUX $lastCommand

# ホスト名取得
hostname="`$GET_LAST_HOSTNAME_SH`"

# split前のwindow/paneに移動
$_TMUX $lastCommand

# ホスト名があればssh
if [ -n "$hostname" ]; then
  ssh "$hostname"

# ないとき(sshしてないとき)はreturn
# @note 呼び出し側で結果を判定してexec $SHELLを実行する
else
  return
fi

# シェルを起動(sshの前に一番はじめに実行される)
## $ZSHがあるとき
if [ -x "$ZSH" ]; then
  exec "$ZSH" -l

## Darwinのとき
elif `uname -a | grep Darwin > /dev/null 2>&1`; then
  exec "/bin/zsh" -l

## その他はデフォルトのshell
else
  exec "$SHELL"
fi
