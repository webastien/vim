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
Plugin 'szw/vim-maximizer'          " Maximizer toggle
Plugin 'joonty/vdebug'              " Xdebug plugin

call vundle#end() | filetype plugin indent on

let mapleader = ','

if isdirectory(expand("~/.vim/bundle/vdebug")) " Vdebug plugin configuration
  " Allows Vdebug to bind to all interfaces.
  let g:vdebug_options = {}
  " Stops execution at the first line.
  let g:vdebug_options['break_on_open'] = 0

  " let g:vdebug_features['max_depth'] = 2048
  let g:vdebug_options['max_children'] = 128

  " Must be tested, not sure it works...
  " let g:vdebug_features['max_data'] = -1
  " let g:vdebug_options['max_data'] = -1

  let g:vdebug_options['port'] = 9000
  " Use the compact window layout.
  let g:vdebug_options['watch_window_style'] = 'compact'
  " Because it's the company default.
  let g:vdebug_options['ide_key'] = 'PHPSTORM'
  " Need to set as empty for this to work with Vagrant boxes.
  let g:vdebug_options['server'] = ''

  let g:vdebug_options['path_maps'] = {
        \ '<remote path 1>': '<local path 1>',
        \ '<remote path 2>': '<local path 2>',
        \ '<remote path 3>': '<local path 3>',
      \}

  let g:vdebug_keymap = {
        \ 'close':             '<Leader>q',
        \ 'detach':            '<Leader>u',
        \ 'eval_under_cursor': '<Leader>e',
        \ 'eval_visual':       '<Leader>v',
        \ 'get_context':       '<Leader>r',
        \ 'run':               '<Leader>x',
        \ 'run_to_cursor':     '<Leader>c',
        \ 'set_breakpoint':    '<Leader>b',
        \ 'step_into':         '<Leader>l',
        \ 'step_out':          '<Leader>h',
        \ 'step_over':         '<Leader>j',
      \}
  nnoremap <silent> <Leader>k :BreakpointWindow<CR>
endif

" ##  Colorscheme configuration and hacks until colors override is not allowed @see https://github.com/NLKNguyen/papercolor-theme/issues/78  ########
if isdirectory(expand("~/.vim/bundle/papercolor-theme")) " To avoid error when Vundle's PluginInstall has not been performed
  colors PaperColor | set background=dark | let g:PaperColor_Theme_Options = { 'theme': { 'default': { 'transparent_background': 1 } } }
  au Colorscheme * hi! CursorLine     ctermfg=NONE ctermbg=17                   " Current line
  au Colorscheme * hi! CursorLineNr   ctermfg=226  ctermbg=17   cterm=bold      " Current line, number side
  au Colorscheme * hi! NonText        ctermfg=0    ctermbg=NONE                 " Invisible characters
  au ColorScheme * hi! Folded         ctermfg=NONE ctermbg=235                  " Folded elements
  au Colorscheme * hi! FoldColumn     ctermfg=14   ctermbg=NONE                 " Fold column (on the left of line numbers)
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
  au ColorScheme * hi!                link         Error        Todo            " Use TODO colors for errors
  au ColorScheme * hi!                link         SignColumn   FoldColumn      " Use FoldColumn colors for SignColumn
  au ColorScheme * hi!                link         qfLineNr     Comment         " Use comments colors for qf cols and lines

  if isdirectory(expand("~/.vim/bundle/vdebug")) " Vdebug plugin configuration
    au ColorScheme * hi! DbgBreakptLine ctermfg=NONE ctermbg=NONE
    au ColorScheme * hi! DbgBreakptSign ctermfg=NONE ctermbg=22
  endif
endif

