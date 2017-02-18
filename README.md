# vim
Simply my own config for the great editor [VIm](http://www.vim.org)

## About
This [VIm](http://www.vim.org) configuration use [Vundle](http://github.com/gmarik/vundle): A plugin manager with [GIT](http://git-scm.com) support. That's why I separate a few custom features in Github repositories. It includes a few plugins and keyboard shortcuts to speed up development, especialy for PHP projects.

## Requirements
* [VIm](http://www.vim.org) obviously (works well with MacOS/Linux pre-installed version, you don't have to install `vim` package)
* [Exuberant ctags](http://ctags.sourceforge.net) to build outline, jump to functions / classes definitions, ... (read the following note)
* [Git](https://git-scm.com) used by **Vundle** to manage plugins

### Exuberant ctags
[Exuberant ctags](http://ctags.sourceforge.net) is a common dependency for developer's stuffs, you maybe already have it, if not:

* **MacOS** (nothing to do)

The `ctags` command already exists, but this is not "Exuberant ctags". You can use [brew](https://brew.sh/index_fr.html), [port](https://www.macports.org) or alternative ways to install, but this is not required: I've compiled it in the `.vim/bin` directory, and add a line in **.vimrc** which detect you're on Mac and tell to [Tagbar](http://majutsushi.github.com/tagbar/) and [vim-ctags](https://github.com/webastien/vim-ctags) to use this provided binary.

* **Linux** (easy, depending on your distrib)

I'm pretty sure all distributions provides a package for it. For example, on [Debian](https://www.debian.org) and derivates ([Ubuntu](https://www.ubuntu.com), [Linux Mint](https://www.linuxmint.com), ...) `sudo apt install ctags` is enought. Otherwise, download it from http://ctags.sourceforge.net.

## Install
1. (optional) Backup your `.vimrc` file and `.vim` folder if you already have a customised configuration
2. Copy both `.vimrc` file and `.vim` folder to your home directory
3. (optional) Edit `.vimrc` to feet your needs
4. Install [Vundle](http://github.com/gmarik/vundle) (`git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`)
5. Launch VIm as usual (errors could be displayed, ignore them for now: Plugins are not yet installed)
6. Execute `:PluginInstall` (cf **Vundle**'s plugin doc)
7. Restart VIm

## Update
Follow the [Vundle](http://github.com/gmarik/vundle) way: Use `:PluginInstall`/`:PluginUpdate` and/or `:PluginClean` commands. **Keep in mind the `.vimrc` file is not automaticaly updated**, but this is expected because it contains YOUR settings, plugins list, etc. If you want to stricly use mine, you have to manually update it when I publish a modified version.

## Uninstall
1. Remove both `.vimrc` file and `.vim` folder from your home directory
2. (optional) Restore your `.vimrc` file and `.vim` folder to your home directory
3. (optional) Uninstall `ctags` if you have installed for it and no more need it

## Plugins used
* [Vundle](http://github.com/gmarik/vundle) to manage plugins (one plugin to rule them all)
* [Syntastic](https://github.com/scrooloose/syntastic) to check syntax errors
* [NERD commenter](https://github.com/scrooloose/nerdcommenter) to easily toggle comments
* [PHP Integration for VIM](https://github.com/spf13/PIV) PHP support for Vim
* [Tagbar](http://majutsushi.github.com/tagbar/) to have an outline
* [Autopreview](https://github.com/vim-scripts/autopreview) to quickly see functions' signature
* [vim-less](https://github.com/groenewege/vim-less) to have LESS files highlighting
* [vim-twig](https://github.com/lumiliet/vim-twig) to have Twig files highlighting
* [Tabular](https://github.com/godlygeek/tabular) for easy alignments (on '=' for example)
* [vim-autoclose](https://github.com/Townk/vim-autoclose) to automaticaly close brackets, ...
* [vim-tabs](https://github.com/webastien/vim-tabs) to simplify tab names
* [vim-ctags](https://github.com/webastien/vim-ctags) to manage and navigate tags
* [vim-folding](https://github.com/webastien/vim-folding) to manage folds (much lighter than PIV's functionnality)
* [vim-tweaks](https://github.com/webastien/vim-tweaks) which contains my own tweaks

## Colorscheme used
I choose [Jellybeans](https://github.com/nanotech/jellybeans.vim) (with a few modifications in **vim-tweaks** plugin). You can easily use another one by replacing the line `Plugin 'nanotech/jellybeans.vim'` in your **.vimrc**.

