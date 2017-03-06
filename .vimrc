" ##  Vundle plugin initialization  #################################################################################################################
set nocompatible | filetype off | set rtp+=~/.vim/bundle/Vundle.vim | call vundle#begin() | Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'       " Check syntax errors
Plugin 'scrooloose/nerdcommenter'   " Easily toggle comments
Plugin 'shawncplus/phpcomplete.vim' " Better completion for PHP
Plugin 'majutsushi/tagbar'          " Provide an outline based on ctags
Plugin 'vim-scripts/autopreview'    " Autopreview functions' signature
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
call vundle#end() | filetype plugin indent on

" ##  Colorscheme configuration and hacks until colors override is not allowed @see https://github.com/NLKNguyen/papercolor-theme/issues/78  ########
colors  PaperColor | set background=dark | let g:PaperColor_Theme_Options = { 'transparent_background': 1 }
autocmd ColorScheme * hi! Folded       ctermbg=NONE ctermfg=22                   " Folded elements
autocmd ColorScheme * hi! Visual       ctermbg=NONE ctermfg=NONE cterm=reverse   " Visual selection
autocmd ColorScheme * hi! Todo         ctermbg=52   ctermfg=220  cterm=bold      " TODO markers
autocmd ColorScheme * hi! Search       ctermbg=11   ctermfg=52   cterm=bold      " Currently researched terms
autocmd ColorScheme * hi! StatusLine   ctermbg=46   ctermfg=16   cterm=bold      " Status line
autocmd ColorScheme * hi! StatusLineNC ctermbg=8    ctermfg=16   cterm=NONE      " Status line (non current)
autocmd ColorScheme * hi! TabLine      ctermbg=8    ctermfg=16   cterm=NONE      " Tabs bar
autocmd ColorScheme * hi! TabLineFill  ctermbg=NONE ctermfg=NONE cterm=underline " The space around tabs
autocmd ColorScheme * hi! TabLineSel   ctermbg=46   ctermfg=16   cterm=bold      " Current buffer tab bar
autocmd FileType php :hi phpVarSelector ctermfg=66 | autocmd FileType php :hi phpIdentifier ctermfg=76 " PHP related

" ##  CTAGS BINARY SWITH DEPENDING ON OS: MacOS has one, but it's not 'Exuberant', so if this is the current OS use the custom bin instead ##########
if system('uname -s') == "Darwin\n" | let g:tagbar_ctags_bin = '~/.vim/bin/ctags' | endif

