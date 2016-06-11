" ##  Vundle plugin initialization  #################################################################################################################
set nocompatible | filetype off | set rtp+=~/.vim/bundle/Vundle.vim | call vundle#begin() | Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'     " Check syntax errors
Plugin 'scrooloose/nerdcommenter' " Easily toggle comments
Plugin 'spf13/PIV'                " PHP integration for VIm
Plugin 'majutsushi/tagbar'        " Provide an outline base on ctags
Plugin 'vim-scripts/autopreview'  " Autopreview functions' signature
Plugin 'groenewege/vim-less'      " LESS css support
Plugin 'godlygeek/tabular'        " Allow easy alignments (on '=' for example)
Plugin 'nanotech/jellybeans.vim'  " Nice colorscheme
Plugin 'webastien/vim-tabs'       " Display only filename + works with several file per tab
Plugin 'webastien/vim-ctags'      " Ctags management
Plugin 'webastien/vim-folding'    " Light module to manage folds
Plugin 'webastien/vim-tweaks'     " My custom tweaks
call vundle#end() | filetype plugin indent on

