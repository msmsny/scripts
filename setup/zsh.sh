#!/bin/sh
#
# install zsh script at local
#

zsh_version="5.0.2"
file_name=zsh-${zsh_version}.tar.gz
UNAME=`uname -a`
echo $UNAME | grep Linux  && WGET=/usr/bin/wget
echo $UNAME | grep Darwin && WGET=/usr/local/bin/wget
$WGET http://sourceforge.net/projects/zsh/files/zsh/${zsh_version}/${file_name}/download -O ${file_name}
tar xvzf ${file_name}
cd zsh-${zsh_version}
mkdir -p $HOME/local
./configure --enable-multibyte --enable-locale --prefix=$HOME/local
make && make install
cd ..
rm -rf zsh-${zsh_version}
