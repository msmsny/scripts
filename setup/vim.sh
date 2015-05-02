#!/bin/sh
#
# override vim script
#

gitDir=$HOME/git/dotfiles
dotVimBundleDir=$HOME/.vim/bundle
gitDotVimBundleDir=$gitDir/.vim/bundle

# ~/.vim/bundle以下の上書き
overrides=(
  # unite-tag
  "unite-tag/autoload/unite/sources/tag.vim"

  # phpcomplete-extended
  "phpcomplete-extended/autoload/phpcomplete_extended.vim"
  "phpcomplete-extended/plugin/phpcomplete_extended.vim"
  "phpcomplete-extended/bin/IndexGenerator.php"

  # phpcomplete-extended-symfony
  "phpcomplete-extended-symfony/autoload/phpcomplete_extended/symfony.vim"
  "phpcomplete-extended-symfony/bin/symfony.php"

  # php-getter-setter.vim
  "php-getter-setter.vim/ftplugin/php_getset.vim"

  # easymotion
  "vim-easymotion/autoload/EasyMotion.vim"

  # quickfixstatus
  "quickfixstatus/plugin/quickfixstatus.vim"
)

# ディレクトリがあれば置く
placements=(
  # quickrun
  "vim-quickrun/autoload/quickrun/outputter/success_messages.vim"

  # shabadou
  "shabadou.vim/autoload/quickrun/hook/reload.vim"
)

# override all
for override in ${overrides[@]}; do
  if [ -f "${dotVimBundleDir}/${override}" ]; then
    if [ ! -L "${dotVimBundleDir}/${override}" ]; then
      mv "${dotVimBundleDir}/${override}" "${dotVimBundleDir}/${override}.org"
    fi
    ln -fs "${gitDotVimBundleDir}/${override}" "${dotVimBundleDir}/${override}"
  fi
done

# placement
for placement in ${placements[@]}; do
  if [ -d "${dotVimBundleDir}/${placement%/*}" ]; then
    ln -fs "${gitDotVimBundleDir}/${placement}" "${dotVimBundleDir}/${placement}"
  fi
done
