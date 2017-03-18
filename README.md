# vim
Simply my own config for the great editor [VIm](http://www.vim.org)

## About
This [VIm](http://www.vim.org) configuration use [Vundle](http://github.com/gmarik/vundle): A plugin manager with [GIT](http://git-scm.com) support. I've put my own plugins in several Github repositories to take advantage of it. The main, [VIm-tweaks](https://github.com/webastien/vim-tweaks), provides a few custom features and keyboard shortcuts to speed up development, especialy for PHP projects.

## Requirements
* [VIm](http://www.vim.org), From Linux packages, Mac pre-installed version, `brew` or `port`, ...
* [Git](https://git-scm.com) used by **Vundle** to install / update plugins

## Install
Before to install, backup your VIm configuration if any (in your home folder: `.vimrc` file and `.vim` folder).

### Manual installation steps
1. Clone **recursively** this repository (recurse if to automaticaly get Vundle repository cloned too)
2. Copy both `.vimrc` file and `.vim` folder to your home directory
3. (optional) Edit `.vimrc` to feet your needs
4. Launch VIm as usual (errors could be displayed, ignore them for now: Plugins are not yet installed)
5. Execute `:PluginInstall` (cf **Vundle**'s plugin doc)
6. Restart VIm and enjoy

#### Alternative for user not familiar with git clone
Replace the first two steps with:
1. [Download this repository](https://github.com/webastien/vim/archive/master.zip) from Github
2. [Download Vundle repository](https://github.com/VundleVim/Vundle.vim/archive/master.zip) from Github
3. Extract them somewhere (`download` folder for example)
4. Copy `download`/webastien-vim/.vimrc in your home (`/home/your-name/.vimrc`)
5. Copy `download`/webastien-vim/.vim in your home (`/home/your-name/.vim`)
6. Copy `download`/Vundle.vim into your vim configuration (`/home/your-name/.vim/bundle/Vundle.vim`)

### Install with command line
```
# Clone the repository (into "/tmp/webastien-vim" directory)
git clone --recursive https://github.com/webastien/vim.git /tmp/webastien-vim
# Copy .vimrc file and .vim folder in your home folder
cp /tmp/webastien-vim/.vimrc ~/.vimrc && rm -fr ~/.vim && cp -r /tmp/webastien-vim/.vim ~/.vim
# Install plugins using Vundle
vim -E -s -c "source ~/.vimrc" -c "PluginInstall" -c "qa!"
```

#### If you forgot the recursive option when cloning
The plugin install step will fail and VIm will certainly gives you errors on startup... Install manualy Vundle to fix it:
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
Then, re-execute the plugin install.

## Update
Follow the [Vundle](http://github.com/gmarik/vundle) way: Use `:PluginInstall`/`:PluginUpdate` and/or `:PluginClean` commands. **Keep in mind the `.vimrc` file is not automaticaly updated**, but this is expected because it contains YOUR settings, plugins list, etc. If you want to stricly use mine, you have to manually update it when I publish a modified version.

**Note:** [vim-tweaks](https://github.com/webastien/vim-tweaks) plugin provides the command `:UpdateVimrc` to update the `.vimrc` file, based on a configurable URL.

### Update with command line
The following command will read your `.vimrc`, remove all un-necessary plugins, install the new ones and finaly update all plugins:
```
vim -E -s -c "source ~/.vimrc" -c "PluginClean" -c "PluginInstall" -c "PluginUpdate" -c "qa!"
```

## Uninstall
1. Remove both `.vimrc` file and `.vim` folder from your home directory
2. (optional) Restore your `.vimrc` file and `.vim` folder to your home directory
3. (optional) Uninstall `ctags` if you have installed for it and no more need it

### Uninstall with command line
```
rm ~/.vimrc && rm -fr ~/.vim
```

## Plugins used
* [Vundle](http://github.com/gmarik/vundle) to manage plugins (one plugin to rule them all)
* [Syntastic](https://github.com/scrooloose/syntastic) to check syntax errors
* [NERD commenter](https://github.com/scrooloose/nerdcommenter) to easily toggle comments
* [PHP Complete](https://github.com/shawncplus/phpcomplete.vim) for a better PHP support
* [Tagbar](http://majutsushi.github.com/tagbar/) to have an outline
* [Autopreview](https://github.com/vim-scripts/autopreview) to quickly see functions' signature
* [Vim Omni Completion](https://github.com/c9s/vimomni.vim) VimL files omnicompletion support
* [vim-less](https://github.com/groenewege/vim-less) to have LESS files highlighting
* [vim-twig](https://github.com/lumiliet/vim-twig) to have Twig files highlighting
* [vim-yaml](https://github.com/stephpy/vim-yaml) for a better syntax highlighting of YAML files
* [Tabular](https://github.com/godlygeek/tabular) for easy alignments (on '=' for example)
* [vim-autoclose](https://github.com/Townk/vim-autoclose) to automaticaly close brackets, ...
* [Emmet-vim](https://github.com/mattn/emmet-vim) Emmet style HTML abbreviations
* [PaperColor theme](https://github.com/NLKNguyen/papercolor-theme) a nice colorscheme which is (a bit) configurable and supposed to become more

### My own plugins
* [vim-tabs](https://github.com/webastien/vim-tabs) to simplify tab names
* [vim-ctags](https://github.com/webastien/vim-ctags) to manage tags index and navigate into code
* [vim-folding](https://github.com/webastien/vim-folding) a light folding plugin
* [vim-tweaks](https://github.com/webastien/vim-tweaks) which contains my keyboard mappings and a few custom features

## Shortcuts
My custom keyboard mappings are described on the vim-tweaks [README.md](https://github.com/webastien/vim-tweaks/blob/master/README.md) file.
