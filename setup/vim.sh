#!/bin/sh
#
# override vim script
#

gitDir=$HOME/git/dotfiles
dotVimBundleDir=$HOME/.vim/bundle
gitDotVimBundleDir=$gitDir/.vim/bundle

# unite-tag
unite_tag="unite-tag/autoload/unite/sources/tag.vim"

# phpcomplete-extended
phpcomplete_extended="phpcomplete-extended/autoload/phpcomplete_extended.vim"

# phpcomplete-extended-symfony
phpcomplete_extended_symfony="phpcomplete-extended-symfony/autoload/phpcomplete_extended/symfony.vim"

# php-getter-setter.vim
php_getter_setter="php-getter-setter.vim/ftplugin/php_getset.vim"

# override all
for override in "$unite_tag" "$phpcomplete_extended" "$phpcomplete_extended_symfony" "$php_getter_setter"; do
  if [ -f "${dotVimBundleDir}/${override}" ]; then
    mv "${dotVimBundleDir}/${override}" "${dotVimBundleDir}/${override}.org"
    ln -fs "${gitDotVimBundleDir}/${$override}" "${$dotVimBundleDir}/${override}"
  fi
done
