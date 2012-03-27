" Forget old versions
set nocompatible
" Display incomplete command (bottom right)
set showcmd
" Diff options
set diffopt=filler,vertical
" Customize command completion
set wildmenu
set wildmode=longest,list
" Display help and preview window at the bottom
set splitbelow
" Activate filetype detection
filetype on
" Fix the line breaks
set fileformat=unix
" Fix characters encoding
set encoding=utf-8
set fileencoding=utf-8
" Always display status bar
set laststatus=2
" Automatically reload files modified outside of vim
set autoread
" Keep enought lines around cursor when scrolling to avoid empty screens
set scrolloff=50
" Display begin of long line (otherwise, they're hidden...)
set display=lastline
" Display informations about position
set ruler
" Customize statusline to display full filepath
set statusline=%<%w%F\ %h%m%r%=%-10.(%l,%c%V\ \[%P\]%)
" Display line number
set number
" Highlight current line
set cursorline
" Enable syntax highlighting
syntax enable
" Enable matching bracket highlight
set showmatch
" No tabs, only spaces (2) for incrementation
set shiftwidth=2
set tabstop=2
set softtabstop=2
set backspace=2
set expandtab
set autoindent
set smartindent
" Indent depends on filetype
filetype indent on
" Cut long lines to several virtual lines
set wrap
" Don't break words
set linebreak
" Settings for searchs
set hlsearch
set ignorecase
set smartcase
set incsearch
" Filetypes managing
autocmd filetype html       set filetype=xhtml
autocmd filetype xhtml      set omnifunc=htmlcomplete#CompleteTags
autocmd filetype css        set omnifunc=csscomplete#CompleteCSS
autocmd filetype javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd filetype php        set omnifunc=phpcomplete#CompletePHP
autocmd filetype xml        set omnifunc=xmlcomplete#CompleteTags
" Customize syntax for Drupal files not recognized by default as PHP files
autocmd BufRead,BufNewFile *.install set filetype=php
autocmd BufRead,BufNewFile *.module  set filetype=php
autocmd BufRead,BufNewFile *.test    set filetype=php
autocmd BufRead,BufNewFile *.engine  set filetype=php
" Manage folding
function SimpleFoldText()
  let lines = v:foldend - v:foldstart + 1
  return '  ... [ '. lines .' lines ] ...'
endfunction
function BetterFoldText()
  let line  = getline(v:foldstart)
  let start = strpart(line, 0, 8)
  if start == '/**'
    if v:foldend - v:foldstart == 2
      return substitute(getline(v:foldstart + 1), "^\\s\\**", "//", "")
    endif

    return '/'. strpart(getline(v:foldstart + 1), 1) .' (...) */'
  else
    return line .' ... }'
  endif
endfunction
function PHPFoldLevel(lineNumber)
  let start = strpart(getline(a:lineNumber), 0, 9)
  if start == 'function ' || start == '/**'
    return '>1'
  elseif start == ' */' || start == '}'
    return '<1'
  else
    return '='
  endif
endfunction
function CssFoldLevel(lineNumber)
  let line  = getline(a:lineNumber)
  if strpart(line, strlen(line) - 1) == '{'
    return '>1'
  elseif line == '}'
    return '<1'
  else
    return '='
  endif
endfunction
set foldenable
set foldcolumn=1
set foldlevel=0
set foldnestmax=1
set fillchars+=fold:\  " BEWARE: This comment is important to keep the last space
set foldmethod=indent
set foldtext=SimpleFoldText()
set foldexpr=PHPFoldLevel(v:lnum)
autocmd filetype php :setlocal foldmethod=expr
autocmd filetype php :setlocal foldtext=BetterFoldText()
autocmd filetype css :setlocal foldmethod=expr
autocmd filetype css :setlocal foldexpr=CssFoldLevel(v:lnum)
autocmd filetype css :setlocal foldtext=BetterFoldText()
" Hidden suffixes
set suffixes=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo
" Disable backup files
set nobackup
" Apply last editing position, unfold if necessary and center the screen aroung the cursor
set viminfo='10,\"100,:20,%,n~/.viminfo
function LastPosition()
  if line("'\"") > 0
    if line("'\"") <= line("$")
      exe "norm '\"zvzz"
    else
      exe "norm $zvzz"
    endif
  endif
endfunction
au BufReadPost * :call LastPosition()
" edit Automatically removing all trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
" Automaticaly choose current file as working directory
if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif
" Omnicompletion settings
set completeopt=menu,preview,longest
" PHP settings
let php_asp_tags=1
let php_baselib=1
let php_folding=0
let php_htmlInStrings=1
let php_parent_error_close=1
let php_parent_error_open=1
let php_sql_query=1
" Taglist setting
let tlist_php_settings='php;c:class;f:function'
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Auto_Highlight_Tag=1
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1
let Tlist_Close_On_Select=0
let Tlist_Compact_Format=1
let Tlist_Display_Prototype=0
let Tlist_Display_Tag_Scope=1
let Tlist_Enable_Fold_Column=0
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=0
let Tlist_GainFocus_On_ToggleOpen=0
let Tlist_Highlight_Tag_On_BufEnter=1
let Tlist_Inc_Winwidth=0
let Tlist_Max_Submenu_Items=1
let Tlist_Max_Tag_Length=40
let Tlist_Process_File_Always=0
let Tlist_Show_Menu=0
let Tlist_Show_One_File=1
let Tlist_Sort_Type='name'
let Tlist_Use_Horiz_Window=0
let Tlist_Use_Right_Window=1
let Tlist_Use_SingleClick=1
let Tlist_WinHeight=100
let Tlist_WinWidth=35
" Simplecommenter settings
autocmd filetype php    :setlocal commentstring=//%s
autocmd filetype conf   :setlocal commentstring=#%s
autocmd filetype apache :setlocal commentstring=#%s
autocmd filetype vim    :setlocal commentstring=\"%s
autocmd filetype dosini :setlocal commentstring=\;%s
" Autopreview settings
let g:AutoPreview_enabled=0
let g:AutoPreview_allowed_filetypes=['php', 'c', 'cpp', 'java']
set previewheight=1
set updatetime=500
" Syntastic settings
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
" Exuberant-ctags settings (Search the nearest 'tags' file in the directory tree)
set tags=.tags;/
" VTree Explorer settings
let treeExplVertical=1
let treeExplWinSize=35
let treeExplDirSort=1
let treeExplIndent=2
" Map fold state toggle on space bar
noremap  <Space> za
" Map indentation on Tab key, reverse to Shift-Tab (for single line or block)
noremap  <Tab>   >>
noremap  <S-Tab> <<
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv
" Map omnicompletion to Shift-Tab (insert mode)
inoremap <S-Tab>  <C-X><C-O>
" Map simplecommenter toggle on Shift-C
map <silent> <S-C> :OneLineComment<CR>
" Map swappers for current line with previous/next line on CTRL-K/J (up/down)
noremap  <C-K> ddkP
noremap  <C-J> ddp
" Map window switcher on CTRL-H/L (previous/next)
nnoremap <C-H> <C-W><S-W>
nnoremap <C-L> <C-W>w
" Map a custom handler on Home key to toggle start of line / first nonblank character
function SmartHome()
  let s:col = col(".")
  normal! ^
  if s:col == col(".")
    normal! 0
  endif
endfunction
nnoremap <silent> <Home>      :call SmartHome()<CR>
inoremap <silent> <Home> <C-O>:call SmartHome()<CR>
map 0 <Home>
" Custom handler for tabs list (To display multiple buffers name and never the full path)
let isTagListOpen  = 0
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabname = (i + 1 == tabpagenr()? '%#TabLineSel#': '%#TabLine#') .'%{MyTabLabel('. (i + 1) .')}'
    if strlen(tabname)
      let s .= tabname
    endif
  endfor
  return s .'%#TabLineFill#'
endfunction
function MyTabLabel(n)
  if tabpagenr() == a:n
    let g:isTagListOpen  = 0
  endif
  let buflist = tabpagebuflist(a:n)
  let index   = 0
  let tabname = []
  while index < len(buflist)
    let bindx = buflist[index]
    let index = index + 1
    let bname = bufname(bindx)
    if bname == g:TagList_title
      if tabpagenr() == a:n
        let g:isTagListOpen = 1
      endif
    elseif bname != 'TreeExplorer'
      let bname = bname != ''? fnamemodify(bname, ':t'): 'new'
      let bname = getbufvar(bindx, "&mod")? '+'. bname .'+': bname
      if !count(tabname, bname)
        let win = bufwinnr(bindx)
        if win == -1 || !getwinvar(win, '&previewwindow')
          call add(tabname, bname)
        endif
      endif
    endif
  endwhile
  if len(tabname) == 0
    return ''
  endif
  return "[ ". join(tabname, ' | ') ." ]"
endfunction
function HideSpecialWindows(closePreview)
  if a:closePreview
    exec "pclose"
  endif
  if g:isTagListOpen
    call CustomTlistCommand()
  endif
endfunction
function RestoreSpecialWindows()
  if g:isTagListOpen
    call CustomTlistCommand()
  endif
endfunction
function CustomTlistCommand()
  exec "TlistToggle"
  call ExplorerToggle()
endfunction
function MyTlistToggle()
  call CustomTlistCommand()
  let g:isTagListOpen = (bufwinnr(g:TagList_title) != -1)
endfunction
function ExplorerPlaceCursor()
  let currentDir = getcwd()
  let workingDir = fnamemodify(g:workspacedir, ':p')
  if stridx(currentDir, workingDir) == 0
    exec "CD ". workingDir
    let dirs = split(strpart(currentDir, strlen(workingDir)), '/')
    if len(dirs) > 0
      for dir in dirs
        call search(dir .'/')
        exec "norm t"
      endfor
    endif
    exec "wincmd w"
    let name = bufname('%')
    exec "wincmd W"
    call search(name)
  endif
endfunction
function ExplorerToggle()
  if bufwinnr(g:TagList_title) != -1
    exec "VSTreeExplore"
    exec "nnoremap <silent> <buffer> t ". maparg("t")
    exec "nnoremap <buffer> <Space> ".    maparg("t")
    exec "nnoremap <buffer> <CR>    ".    maparg("t")
    call ExplorerPlaceCursor()
    exec "wincmd w"
  else
    let winnum = bufwinnr('TreeExplorer')
    if winnum != -1
      exe winnum .'wincmd w'
      close
    endif
  endif
endfunction
function ReloadSpecialWindows()
  if g:isTagListOpen
    exec "wincmd t"
    close
  endif
  call HideSpecialWindows(0)
  call RestoreSpecialWindows()
endfunction
function CheckOrphans()
  if MyTabLabel(tabpagenr()) == ''
    if tabpagenr('$') == 1
      exec "qa"
    else
      tabclose
      call MyTlistToggle()
    endif
  endif
endfunction
autocmd BufEnter    * :call CheckOrphans()
autocmd BufReadPost * :call ReloadSpecialWindows()
autocmd TabLeave *    :call HideSpecialWindows(1)
autocmd TabEnter *    :call RestoreSpecialWindows()
set tabline=%!MyTabLine()
" Map autopreview on F2
nnoremap <silent> <F2>      :AutoPreviewToggle<CR>
inoremap <silent> <F2> <C-O>:AutoPreviewToggle<CR>
" Map a custom handler to open function definition on F3 (if found)
function OpenDeclaration()
  let s:tag = expand("<cword>")
  if s:tag != ""
    try
      silent exe "ts ". s:tag
    catch
      return
    endtry
    exe "tabnew"
    exe "tag ". s:tag
    exe "norm zvzz"
  endif
endfunction
map <silent> <F3> :call OpenDeclaration()<CR>
" Map quick return last editing position
map <S-q> '.
" Map ctags update on F5
let workspacedir = '~/Workspace'
function UpdateCtags()
  if &ft != 'php'
    echohl WarningMsg | echo "This is not a PHP file!" | echohl None
    return
  endif
  if stridx(getcwd(), fnamemodify(g:workspacedir, ':p')) == -1
    echohl WarningMsg | echo "This file is not in your workspace!" | echohl None
    return
  endif
  let tagfiles = tagfiles()
  if len(tagfiles) == 1
    let tagfile = get(tagfiles, 0)
    if !filewritable(tagfile)
      echohl ErrorMsg | echo "The tagfile '". tagfile  ."' is not writable!" | echohl None
      return
    endif
    let tagdir = fnamemodify(tagfile, ':p:h')
  else
    let wparts = split(fnamemodify(g:workspacedir, ':p'), '/')
    let tagdir = g:workspacedir .'/'. get(split(getcwd(), '/'), len(wparts))
    call inputsave()
    let tagdir = input('Root directory: ', fnamemodify(tagdir, ':p'), 'dir')
    call inputrestore()
    if tagdir == ''
      echo 'Canceled'
      return
    endif
  endif
  if !isdirectory(tagdir) || filewritable(tagdir) != 2
    echohl ErrorMsg | echo "The dirname '". tagdir ."' is not readable!" | echohl None
    return
  endif
  echo "Processing tags list update..."
  let command  = 'ctags --langmap=php:.engine.inc.module.theme.php.install --php-kinds=fcdi'
  let command .=      ' --languages=php --recurse --tag-relative=yes --totals=yes'
  let command .=      ' -f '. tagdir .'/.tags '. tagdir
  echo system(command)
  return
endfunction
nnoremap <silent> <F5> :call UpdateCtags()<CR>
" Map custom PHP search and its navigation on CTRL-F (start search) and F6/F7 (show next/previous result)
function PHPSearch()
  call inputsave()
  let searchterm = input('Search term: ', expand("<cword>"))
  call inputrestore()
  if searchterm == ''
    echo 'Canceled'
    return
  endif
  call inputsave()
  let searchdir = input('Search directory: ', getcwd(), 'dir')
  call inputrestore()
  if searchdir == '' || !isdirectory(searchdir)
    echohl ErrorMsg | echo "You have to specify a valid directory!" | echohl None
    return
  endif
  let command   = "vimgrep /". searchterm ."/j ". fnamemodify(searchdir, ':p') ."**/*.*"
  if g:isTagListOpen
    call MyTlistToggle()
  endif
  exec "tabnew"
  silent exec command
  exec "copen"
  exec "cfirst"
  exec "norm zv"
endfunction
nnoremap <silent> <C-F> :call PHPSearch()<CR>
nnoremap <silent> <F6>  :cprevious<CR>zv
nnoremap <silent> <F7>  :cnext<CR>zv
" Map tags list toggle on F8
nnoremap <silent> <F8>      :call MyTlistToggle()<CR>
inoremap <silent> <F8> <C-O>:call MyTlistToggle()<CR>
" Map tabnew on CTRL-T (FF style) and CTRL-N (classic one)
nnoremap <silent> <C-T>      :tabnew<CR>
inoremap <silent> <C-T> <C-O>:tabnew<CR>
map  <C-N> <C-T>
imap <C-N> <C-T>
" Map advanced navigation action on SHIFT + vim navigation keys
map <S-K> <PageUp>
map <S-J> <PageDown>
map <S-H> 0
map <S-L> $
" Unmap keyboard keys in standard mode
map <Up>    <Esc>
map <Right> <Esc>
map <Down>  <Esc>
map <Left>  <Esc>
" Enable 256 colors scheme
set t_Co=256
" Change colors scheme
colors peachpuff
" Colorize line number column
hi LineNr            cterm=NONE      ctermfg=236  ctermbg=NONE
" Colorize visual selection
hi Visual            cterm=reverse   ctermfg=NONE ctermbg=NONE
" Colorize invisible characters
hi Ignore            cterm=NONE      ctermfg=16   ctermbg=NONE
hi NonText           cterm=NONE      ctermfg=235  ctermbg=NONE
hi SpecialKey        cterm=NONE      ctermfg=235  ctermbg=NONE
" Colorize folded elements
hi Folded            cterm=bold      ctermfg=15   ctermbg=NONE
hi FoldColumn        cterm=NONE      ctermfg=220  ctermbg=NONE
" Colorize current line (and current column even if not activated by default)
hi CursorLine        cterm=NONE      ctermfg=NONE ctermbg=233
hi CursorColumn      cterm=NONE      ctermfg=NONE ctermbg=232
" Colorize search term
hi IncSearch         cterm=reverse   ctermfg=NONE ctermbg=NONE
hi Search            cterm=underline ctermfg=NONE ctermbg=NONE
" Colorize matching brackets
hi MatchParen        cterm=reverse   ctermfg=NONE ctermbg=NONE
" Colorize popup menus (like omnicompletion)
hi Pmenu             cterm=NONE      ctermfg=15   ctermbg=233
hi PmenuSel          cterm=bold      ctermfg=220  ctermbg=NONE
hi PmenuSbar         cterm=bold      ctermfg=236  ctermbg=236
hi PmenuThumb        cterm=bold      ctermfg=236  ctermbg=220
" Colorize tags list
hi MyTagListTagName  cterm=bold      ctermfg=15   ctermbg=233
hi MyTagListFileName cterm=NONE      ctermfg=4    ctermbg=NONE
" Colorize sign column (Used to mark errors by syntastic plugin)
hi SignColumn        cterm=NONE      ctermfg=NONE ctermbg=NONE
" Colorize error messages
hi ErrorMsg          cterm=bold      ctermfg=220  ctermbg=52
hi WarningMsg        cterm=bold      ctermfg=52   ctermbg=220
" Colorize mode message
hi ModeMsg           cterm=bold      ctermfg=220  ctermbg=52
" Colorize vertical separators
hi VertSplit         cterm=NONE      ctermfg=235  ctermbg=NONE
" Colorize status line
hi StatusLine        cterm=bold      ctermfg=16   ctermbg=46
hi StatusLineNC      cterm=NONE      ctermfg=16   ctermbg=28
" Colorize tabs bar
hi TabLine           cterm=NONE      ctermfg=16   ctermbg=28
hi TabLineSel        cterm=bold      ctermfg=16   ctermbg=46
hi TabLineFill       cterm=underline ctermfg=NONE ctermbg=NONE
" Colorize 'To do' markers
hi Todo              cterm=bold      ctermfg=220  ctermbg=52
" Colorize differences when comparing files
hi DiffAdd           cterm=NONE      ctermfg=15   ctermbg=21
hi DiffChange        cterm=NONE      ctermfg=16   ctermbg=136
hi DiffDelete        cterm=NONE      ctermfg=88   ctermbg=52
hi DiffText          cterm=bold      ctermfg=220  ctermbg=52
" Colorize PHP language
hi phpComment        cterm=NONE      ctermfg=8    ctermbg=NONE

