" ##  Vundle plugin initialization  #################################################################################################################
set nocompatible | filetype off | set rtp+=~/.vim/bundle/Vundle.vim | call vundle#begin() | Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/syntastic'     " Check syntax errors
Plugin 'scrooloose/nerdcommenter' " Easily toggle comments
Plugin 'nanotech/jellybeans.vim'  " Nice colorscheme
Plugin 'spf13/PIV'                " PHP integration for VIm
Plugin 'majutsushi/tagbar'        " Provide an outline base on ctags
Plugin 'vim-scripts/autopreview'  " Autopreview functions' signature
Plugin 'groenewege/vim-less'      " LESS css support
Plugin 'webastien/vim-tabs'       " Display only filename + works with several file per tab
Plugin 'webastien/vim-ctags'      " Ctags management
Plugin 'webastien/vim-folding'    " Light module to manage folds
call vundle#end() | filetype plugin indent on

" ##  VIm options  ##################################################################################################################################
syntax  enable                     " Enable syntax highlighting
autocmd BufWritePre * :%s/\s\+$//e " Always remove trailing whitespace on save

let g:DisableAutoPHPFolding = 1 | let php_folding = 0         " Disable PIV's folding
let NERDSpaceDelims=1                                         " Add space around NERDcommenter's commented lines
let g:syntastic_auto_loc_list=1                               " Syntastic plugin will show the error
set autochdir                                                 " Use relative path from the current file
set completeopt=menu,preview,longest                          " Omnicompletion settings
set cursorline                                                " Highlight current line
set diffopt=filler,vertical                                   " Diff options
set dir=~/.vim/swapfiles                                      " To prevent swapfiles to be sent by FTP / archived ... Put them in an uniq directory
set encoding=utf-8 | set fileencoding=utf-8                   " Fix characters encoding
set fileformat=unix                                           " Fix the line breaks
set hlsearch | set ignorecase | set smartcase | set incsearch " Customize how the search works
set laststatus=2                                              " Always display status bar
set number                                                    " Display line number
set ruler                                                     " Display informations about position
set scrolloff=50                                              " Keep enought lines around cursor when scrolling to avoid empty screens
set showcmd                                                   " Display incomplete command (bottom right)
set splitbelow                                                " Display help and preview window at the bottom
set statusline=%<%w%F\ %h%m%r%=%-10.(%l,%c%V\ \[%P\]%)        " Customize statusline to display full filepath
set wildmenu | set wildmode=longest,list                      " Customize command completion
set tw=170 | set wrap | set linebreak | set display=lastline  " Wrap long lines, never cut words and display its begin when everything cannot be displayed

let g:tagbar_compact = 1 | let g:tagbar_autofocus = 1 | let g:tagbar_close = 1 | let g:tagbar_ctags_bin = '~/.vim/bin/ctags' " MacOS's ctags is not 'Exuberant'
let g:AutoPreview_enabled=0 | set previewheight=1 | set updatetime=500 " Autopreview settings
set shiftwidth=2 | set tabstop=2 | set softtabstop=2 | set backspace=2 | set expandtab | set autoindent | set smartindent " Never tabs, only 2 spaces
set suffixes=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo " Hidden suffixes

" ##  Custom tweaks  ################################################################################################################################
vnoremap p "_dP " Keep the current text in memory when being pasted
" Apply last editing position, unfold if necessary and center the screen aroung the cursor
set viminfo='10,\"100,:20,%,n~/.viminfo
function LastPosition()
  if line("'\"") > 0 && line("'\"") <= line("$") | exe "norm '\"zvzz" | endif
endfunction
au BufReadPost * :call LastPosition()
" Map a custom handler on Home key to toggle start of line / first nonblank character
function SmartHome()
  let s:col  = col(".") | normal! ^
  if  s:col == col(".") | normal! 0
  endif
endfunction
nnoremap <silent> <Home> :call SmartHome()<CR>
" Adjust filetype for known extensions
autocmd BufRead,BufNewFile *.install set filetype=php
autocmd BufRead,BufNewFile *.module  set filetype=php
autocmd BufRead,BufNewFile *.test    set filetype=php
autocmd BufRead,BufNewFile *.engine  set filetype=php
autocmd BufRead,BufNewFile *.profile set filetype=php
autocmd BufRead,BufNewFile *.view    set filetype=php
autocmd BufRead,BufNewFile *.info    set filetype=dosini
autocmd BufRead,BufNewFile *.ini     set filetype=dosini
" Map word search and its navigation on CTRL-F (start search) and F6/F7 (show next/previous result)
function WordSearch()
  call inputsave() | let w = input('Word: ', expand("<cword>")) | call inputrestore() | if w == '' | return | endif
  call inputsave() | let d = input('Dir: ',  getcwd(), 'dir')   | call inputrestore() | if d == '' || !isdirectory(d) | return | endif
  exec "tabnew" | echo "searching..." | silent exec "vimgrep /". w ."/j ". fnamemodify(d, ':p') ."**/*.*" | exec "copen" | exec "cfirst" | exec "norm zv"
endfunction
nnoremap <silent> <C-F> :call WordSearch()<CR>
nnoremap <silent> <F6>  :cprevious<CR>zv
nnoremap <silent> <F7>  :cnext<CR>zv
" Toggle auto preview
nnoremap <silent> <F2> :AutoPreviewToggle<CR>
" As PIV plugin use ":setlocal nowrap", re-add this option on PHP files
autocmd FileType php :setlocal wrap

" ##  Keyboard (re)mapping  #### /!\ Remember: Never add comments on the same line as a map command! ################################################
" Remap the "à" key to work as "0" on qwerty keyboards
map à <Home>
" Map quick return last editing position
map <S-q> '.
" Map fold state toggle on space bar
noremap  <Space> za
" Nerd commenter toggle on Shift-C
map <S-C> <leader>c<space>
" Omnicompletion with Shift-Tab (insert mode)
inoremap <S-Tab> <C-X><C-O>
" Tab gesture
map <silent> <C-T>   :tabnew<CR>
map <silent> <C-W>   :tabclose<CR>
map <silent> <Left>  :tabprevious<CR>
map <silent> <Right> :tabnext<CR>
" Panes navigation
nnoremap <Up>   <C-W><S-W>
nnoremap <Down> <C-W>w
" Page Up / Down + Begin / End of line
map <C-K> <PageUp>
map <C-J> <PageDown>
map <C-H> <Home>
map <C-L> $
" Map indentation on Tab key, reverse to Shift-Tab (for single line or block)
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv
" Map swappers for current line with previous/next line on SHIFT-K/J (up/down)
noremap <silent> <S-K> :m .-2<CR>
noremap <silent> <S-J> :m .+1<CR>
" Ctags management
map      <silent> <F3> :call DisplayTag()<CR>
nnoremap <silent> <F5> :call RebuildTags()<CR>
" Toggle the ouline with F8
nmap <silent> <F8> :TagbarToggle<CR>

" ##  Colors customization  #########################################################################################################################
colors jellybeans
hi CursorLine   cterm=bold      ctermfg=NONE ctermbg=4    " Current line
hi FoldColumn   cterm=NONE      ctermfg=220  ctermbg=NONE " Fold marks column
hi Folded       cterm=NONE      ctermfg=100  ctermbg=NONE " Folded elements
hi LineNr       cterm=NONE      ctermfg=236  ctermbg=NONE " Line number column
hi Normal       cterm=NONE      ctermfg=188  ctermbg=NONE " Default lines (remove the background color from jellybeans scheme)
hi Search       cterm=bold      ctermfg=52   ctermbg=11   " Currently researched terms
hi StatusLine   cterm=bold      ctermfg=16   ctermbg=46   " Status line
hi StatusLineNC cterm=NONE      ctermfg=16   ctermbg=8    " Status line (non current)
hi TabLine      cterm=NONE      ctermfg=16   ctermbg=8    " Tabs bar
hi TabLineFill  cterm=underline ctermfg=NONE ctermbg=NONE " The space around tabs
hi TabLineSel   cterm=bold      ctermfg=16   ctermbg=46   " Current buffer tab bar
hi Todo         cterm=bold      ctermfg=220  ctermbg=52   " TODO markers
hi Visual       cterm=reverse   ctermfg=NONE ctermbg=NONE " Visual selection

