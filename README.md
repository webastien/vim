# vim
Simply my own config for the great editor VIm

## About
This [VIm](http://www.vim.org) configuration use [Vundle](http://github.com/gmarik/vundle) : A plugin manager with [GIT](http://git-scm.com) support. That's why I separate a few custom features in Github repositories.

As I mainly use Mac computers, I had to compile [Exuberant Ctags](http://ctags.sourceforge.net) (the "ctags" command included in MacOS is not the same) and put the binary in **~/.vim/bin**. [Tagbar](http://majutsushi.github.com/tagbar/) and [vim-ctags](https://github.com/webastien/vim-ctags) need it and this custom path is defined with:

    let g:tagbar_ctags_bin = '~/.vim/bin/ctags'

I'm using a french azerty keyboard (just in case) and [TotalTerminal](http://totalterminal.binaryage.com) with a black theme (almost the same as included *Homebrew* theme), colors could be different in another console.

## Install
1. Copy **.vimrc** file and **.vim** to your home directory
2. Edit **.vimrc** to feet your needs
3. Create the directory **.vim/swapfiles** (except if you remove this option)
4. Launch **vim** (as usual)
5. Execute **PluginInstall** command (cf **Vundle**'s plugin doc)
6. Close **vim**
7. Re-open it when you want to play...

## Plugins used
* [Syntastic](https://github.com/scrooloose/syntastic) to check syntax errors
* [NERD commenter](https://github.com/scrooloose/nerdcommenter) to easily toggle comments
* [PHP Integration for VIM](https://github.com/spf13/PIV) to... U know :-)
* [Tagbar](http://majutsushi.github.com/tagbar/) to have an outline
* [Autopreview](https://github.com/vim-scripts/autopreview) to quickly see functions' signature
* [vim-less](https://github.com/groenewege/vim-less) to have LESS files highlighting
* [vim-tabs](https://github.com/webastien/vim-tabs) to simplify tab names
* [vim-ctags](https://github.com/webastien/vim-ctags) to manage and navigate tags
* [vim-folding](https://github.com/webastien/vim-folding) to manage folds (much lighter than PIV's functionnality)

## Colorscheme used
I choose [Jellybeans](https://github.com/nanotech/jellybeans.vim) with a few modifications (see the end of **.vimrc** file).

## Other features
* Swap files are no more in each edited files' directory, but all in **.vim/swapfiles** (so, they will not be embedded in FTP transferts, archives, ...)
* Paste a text on another do not replace the clipboard
* When opening a file, the cursor goes where it was the last time
* Search for word(s) in a directory and to navigate into results
* The **à** key (fr keyboards) works as **0** (begin of current line)

## Custom shortcuts
* **CTRL-F** to search something, somewhere
* **F6** Go to previous result of this search
* **F7** Go to next result of this search
* **F2** Toggle autopreview
* **SHIFT-Q** Return to last edited line
* **SPACE** Fold / Unfold
* **SHIFT-C** Comment / Uncomment line or selected block
* **SHIFT-TAB** (insert mode) Autocompletion
* **CTRL-T** New tab
* **CTRL-W** Close tab
* **LEFT** Previous tab
* **RIGHT** Next tab
* **UP** Previous pane
* **DOWN** Next pane
* **CTRL-K** Page up
* **CTRL-J** Page down
* **CTRL-H** Begin of line
* **CTRL-L** End of line
* **TAB** / **SHIFT-TAB** (normal mode) Indent more / less line or selected block
* **SHIFT-K** Move the current line up
* **SHIFT-J** Move the current line down
* **F3** Jump to declaration of the function / class / ... under the cursor
* **F5** Create / Refresh tags list of the project
* **F8** Toggle file outline

## TODO
* Better language abstraction on some things (especially vim-ctags plugin)
* Re-do an acceptable helper module for [Drupal](https://www.drupal.org) when I will use D8 (I've started [one for D7](https://github.com/webastien/vim/blob/4b4f5c332e7576dd986da2e08a2e8b2ea7a2039f/vim/plugin/drupal.vim), but never had time to finish).
* Same for [Symfony2](http://symfony.com) and probably other frameworks / CMS / languages if I use vim to work on them
* ...

