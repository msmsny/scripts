#!/bin/sh
#
# messagesウォッチスクリプト(簡易版)
#

. $HOME/git/scripts/watch/vars.sh

# ひとまずLinuxのみ対応
/bin/uname -a | /bin/grep Linux > /dev/null 2>&1 || exit

# 全体をチェックするかどうか
if [ -n "$1" ]; then
  # 全体をチェック
  all_check=1
else
  # 1時間単位でチェック
  all_check=
fi

# チェック
if [ -f "$CONTENTS_FILE_NAME" ]; then
  subject="messages watch result [`hostname`]"
  messages=

  if [ -n "$all_check" ]; then
    messages=`/bin/cat ${LOG_FILE_NAME} | /bin/awk -v user="$EXCLUDE_USER" '$5 == "sudo:" && $6 != user {print}'`
  else
    messages=`/bin/date -d '1 hour ago' '+%b %e %H' | /usr/bin/xargs -I % /bin/grep % ${LOG_FILE_NAME} | /bin/awk -v user="$EXCLUDE_USER" '$5 == "sudo:" && $6 != user {print}'`
  fi

  if [ -n "$messages" ]; then
    contents=`/bin/cat $CONTENTS_FILE_NAME`
    contents="${contents//__subject__/$subject}"
    contents="${contents//__contents__/$messages}"
    /bin/echo -e "$contents" | /usr/sbin/sendmail account@domain.jp
  fi
fi
