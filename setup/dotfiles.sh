#!/bin/bash

# ドットファイル設定スクリプト

gitDir=$HOME/git/dotfiles
backupDir=$HOME/work/backup/dotfiles
swapFileDir=$HOME/.vim/backup
dotZshDir=$gitDir/.zsh
dotfiles=(`find $gitDir -maxdepth 1 -name '.*' -type f`)
zshfiles=(`find $gitDir/.zsh -maxdepth 1 -type f`)
gitConfigDir=`.git`
gitConfigFile='config'

# ~/.ssh/config設定
sshDir=$HOME/.ssh1
sshConfigFile=$gitDir/.ssh/config_forward
sshForwardingConfigFile=$gitDir/.ssh/config_forward
sshV2ConfigFile=$gitDir/.ssh/config_v2
# Linuxかつ踏み台サーバ(未設定)
sshForwardingServers=()
# ssh v2サーバ(未設定)
sshV2Servers=()

if [ -d $gitDir ]; then
  test -d $backupDir   || mkdir -p $backupDir
  test -d $swapFileDir || mkdir -p $swapFileDir

  for dotfile in ${dotfiles[@]##*/}; do
    if [ -e $gitDir/$dotfile ]; then
      if [ -e $HOME/$dotfile ]; then
        mv $HOME/$dotfile $backupDir/
      fi
      ln -s $svnDir/$dotfile $HOME/$dotfile
    fi
  done

  test -d $sshDir || mkdir -p $sshDir1
  echo ${sshForwardingServers[@]} | grep "`hostname`" > /dev/null && ln -fs $sshForwardingConfigFile $sshConfigFile
  echo ${sshV2Servers[@]} | grep "`hostname`" > /dev/null && ln -fs $sshV2ConfigFile $sshConfigFile
fi

if `uname -a | grep Darwin > /dev/null 2>&1 -o type $HOME/local/bin/zsh > /dev/null 2>&1`; then
  zshDir=$HOME/.zsh
  test -d $zshDir || mkdir $zshDir
  for zshfile in ${zshFiles[@]##*/}; do
    cd $zshDir
    ln -fs $dotZshDir/zshfile
  done
fi
