" ##  Vundle plugin initialization  #################################################################################################################
set nocompatible | filetype off | set rtp+=~/.vim/bundle/Vundle.vim | call vundle#begin() | Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'       " Check syntax errors
Plugin 'scrooloose/nerdcommenter'   " Easily toggle comments
Plugin 'shawncplus/phpcomplete.vim' " Better completion for PHP
Plugin 'majutsushi/tagbar'          " Provide an outline based on ctags
Plugin 'vim-scripts/autopreview'    " Autopreview functions' signature
Plugin 'c9s/vimomni.vim'            " VimL files omnicompletion support
Plugin 'groenewege/vim-less'        " LESS css support
Plugin 'lumiliet/vim-twig'          " Twig syntax highlighting support
Plugin 'stephpy/vim-yaml'           " Better syntax highlighting for YAML
Plugin 'godlygeek/tabular'          " Allow easy alignments (on '=' for example)
Plugin 'Townk/vim-autoclose'        " Auto close brackets, ...
Plugin 'NLKNguyen/papercolor-theme' " Nice colorscheme
Plugin 'webastien/vim-tabs'         " Display only filename + works with several file per tab
Plugin 'webastien/vim-ctags'        " Ctags management
Plugin 'webastien/vim-folding'      " Light module to manage folds
Plugin 'webastien/vim-tweaks'       " My custom tweaks
Plugin 'mattn/emmet-vim'            " Emmet style HTML abbreviations (MUST BE PLACED AFTER VIM-TWEAKS TO ALLOW REMAPPING)
call vundle#end() | filetype plugin indent on

" ##  Colorscheme configuration and hacks until colors override is not allowed @see https://github.com/NLKNguyen/papercolor-theme/issues/78  ########
if isdirectory(expand("~/.vim/bundle/papercolor-theme")) " To avoid error when Vundle's PluginInstall has not been performed
  colors PaperColor | set background=dark | let g:PaperColor_Theme_Options = { 'theme': { 'default': { 'transparent_background': 1 } } }
  au ColorScheme * hi! Folded         ctermfg=22   ctermbg=NONE                 " Folded elements
  au ColorScheme * hi! Visual         ctermfg=NONE ctermbg=NONE cterm=reverse   " Visual selection
  au ColorScheme * hi! Todo           ctermfg=220  ctermbg=52   cterm=bold      " TODO markers
  au ColorScheme * hi! Search         ctermfg=52   ctermbg=11   cterm=bold      " Currently researched terms
  au ColorScheme * hi! StatusLine     ctermfg=16   ctermbg=46   cterm=bold      " Status line
  au ColorScheme * hi! StatusLineNC   ctermfg=16   ctermbg=8    cterm=NONE      " Status line (non current)
  au ColorScheme * hi! TabLine        ctermfg=16   ctermbg=8    cterm=NONE      " Tabs bar
  au ColorScheme * hi! TabLineFill    ctermfg=NONE ctermbg=NONE cterm=underline " The space around tabs
  au ColorScheme * hi! TabLineSel     ctermfg=16   ctermbg=46   cterm=bold      " Current buffer tab bar
  au ColorScheme * hi! phpIdentifier  ctermfg=76                                " PHP variables name
  au ColorScheme * hi! phpVarSelector ctermfg=66                                " PHP variables dollar symbol
endif

