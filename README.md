# vim
Simply my own config for the great editor VIm

## About
This [VIm](http://www.vim.org) configuration use [Vundle](http://github.com/gmarik/vundle) : A plugin manager with [GIT](http://git-scm.com) support. That's why I separate a few custom features in Github repositories.

As I mainly use Mac computers, I had to compile [Exuberant Ctags](http://ctags.sourceforge.net) (the "ctags" command included in MacOS is not the same) and put the binary in **~/.vim/bin**. [Tagbar](http://majutsushi.github.com/tagbar/) and [vim-ctags](https://github.com/webastien/vim-ctags) need it and this custom path is defined in [vim-tweaks](https://github.com/webastien/vim-tweaks) with:

    let g:tagbar_ctags_bin = '~/.vim/bin/ctags'

## Install
1. Copy **.vimrc** file and **.VIm** to your home directory
2. Edit **.vimrc** to feet your needs
3. Create the directory **.vim/swapfiles** (except if you remove this option)
4. Launch **VIm** (as usual)
5. Execute **PluginInstall** command (cf **Vundle**'s plugin doc)
6. Restart **VIm**

## Plugins used
* [Syntastic](https://github.com/scrooloose/syntastic) to check syntax errors
* [NERD commenter](https://github.com/scrooloose/nerdcommenter) to easily toggle comments
* [PHP Integration for VIM](https://github.com/spf13/PIV) to... U know :-)
* [Tagbar](http://majutsushi.github.com/tagbar/) to have an outline
* [Autopreview](https://github.com/vim-scripts/autopreview) to quickly see functions' signature
* [vim-less](https://github.com/groenewege/vim-less) to have LESS files highlighting
* [Tabular](https://github.com/godlygeek/tabular) for easy alignments (on '=' for example)
* [vim-tabs](https://github.com/webastien/vim-tabs) to simplify tab names
* [vim-ctags](https://github.com/webastien/vim-ctags) to manage and navigate tags
* [vim-folding](https://github.com/webastien/vim-folding) to manage folds (much lighter than PIV's functionnality)
* [vim-tweaks](https://github.com/webastien/vim-tweaks) which contains my own tweaks

## Colorscheme used
I choose [Jellybeans](https://github.com/nanotech/jellybeans.vim) with a few modifications (see the end of **.vimrc** file).

