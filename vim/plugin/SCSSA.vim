""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                  "
"     Simple CSS align (SCSSA) - Align selected CSS properties     "
"                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Description:
"   A very simple VIm plugin to align CSS properties, that's all :-)
"
" Maintainer:   Sébastien <webastien[At]gmail.com>
" Last Change:  2012 August 8
" Version:      v1.0
"
" Installation:
"   Required:
" - Drop this file to your plugin directory of vim.
"
"   Optional:
" - Map a key to call the "SCSSA" command.
"   To do it, add this to your .vimrc:
"         vmap YOURKEY :SCSSA<CR>
"   (where YOURKEY is the key you've choosed)
"
"   Example: vmap + :SCSSA<CR>
"
" Usage:
"   :SCSSA -> Align CSS properties currently selected
"

if exists ('loaded_SCSSA') || !exists(':filetype')
  finish
endif

" Flag to indicate the plugin is already loaded
let loaded_SCSSA = 1

" Create a custom command to align selected CSS properties
command! -range SCSSA :call s:SCSSA(<line1>, <line2>)

" Function where all the process is done
function s:SCSSA(line1, line2)
  if &ft != 'css'
    echohl WarningMsg | echo "This is not a CSS file!" | echohl None
    return
  endif

  let l:lines   = {}
  let l:lengths = []

  for i in range(a:line1, a:line2)
    let l:line = s:matchLine(getline(i))

    if l:line != ''
      let l:lengths += [len(s:trim(split(l:line, ':')[0]))]
    endif
  endfor

  let l:max = max(l:lengths)

  for i in range(a:line1, a:line2)
    let l:line = s:matchLine(getline(i))

    if l:line != ''
      let l:parts = split(l:line, ':')

      if len(l:parts) > 1
        if len(l:parts) > 2
          let l:index = 2

          while index < len(l:parts)
            let l:parts[1]    .= ':'. l:parts[index]
            let l:parts[index] = ''
            let index         = index + 1
          endwhile
        endif

        let l:parts[0] = s:trim(l:parts[0])
        let l:parts[0] = l:parts[0] .': '. repeat(' ', l:max - len(l:parts[0]))
        let l:parts[1] = s:trim(l:parts[1])

        call setline(i, join(l:parts, ''))
      endif
    endif
  endfor

  normal gv==
endfunction

" Detect lines we will take in consideration or not
function s:matchLine(line)
    let l:line = s:trim(a:line)

    if l:line == ''
      return ''
    endif

    let l:lastChar = strpart(l:line, len(l:line) - 1, 1)

    if l:lastChar == '{' || l:lastChar == ','
      return ''
    endif

    return l:line
endfunction

" Remove the trailing spaces from the given string
function s:trim(string)
  return substitute(a:string, '^\s\+\|\s\+$', '', 'g')
endfunction

