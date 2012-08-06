" Description:
"   (Actually) A very simple VIm plugin to help develop with Drupal.
"
" Maintainer:   Sébastien <webastien[At]gmail.com>
" Last Change:  2012 August 6
" Version:      v1.0
"
" Installation:
"   Drop this file to your plugin directory of vim.
"
" Usage:
"   :Hook {name} -> Implement the named hook, where the cursor is.
"
"   For convinience, the module name is guessed by the file path,
"   when this is ambiguous or indeterminate, a prompt is displayed.
"   A cache (renewed each time vim is opened) is used to not ask
"   several times for the same file in which module it is associated.
"

if exists ("loaded_drupal") || !has("autocmd") || !exists(":filetype")
  finish
endif

" Flag to indicate the plugin is already loaded
let loaded_drupal = 1
" Cache to not ask twice for the same file which module is associated
let s:drupal_know_files = {}

" Create a custom command to directly implement a Drupal hook under the cursor
command! -nargs=1 -complete=custom,s:HookNameAutoComplete Hook :call s:ImplementDrupalHook(<q-args>)

" Will place an implementation of the given hook under the cursor
function s:ImplementDrupalHook(hook)
  if &ft != 'php'
    echohl ErrorMsg | echo "This is not a PHP file!" | echohl None
    return
  endif

  let l:signature = s:getHookSignature(a:hook)

  if l:signature == ''
    return
  endif

  let l:pasteValue = &paste
  let l:currentPos = line('.')

  if l:pasteValue == 0
    exec 'set paste'
  endif

  exec "normal i\n/**\n * Implements hook_". a:hook ."().\n */\n". l:signature ."  \n}\n"
  exec 'normal '. (l:currentPos + 5) .'G$'

  if l:pasteValue == 0
    exec 'set nopaste'
  endif
endfunction

" Provide autocompletion of hooks' name to the "Hook" command
function s:HookNameAutoComplete(ArgLead, CmdLine, CursorPos)
  if a:ArgLead == '' || &ft != 'php' || len(tagfiles()) != 1
    return ''
  endif

  return s:GetCandidateHooks(a:ArgLead)
endfunction

" Return a list of hooks which the name start by the given expression
function s:GetCandidateHooks(expr)
  let l:result = system('compgen -W "`awk "/^hook_'. a:expr .'/ { print \\$1 }" '. get(tagfiles(), 0) .'`"')

  if l:result == ''
    return ''
  endif

  let l:resultArray = s:SortUnique(split(l:result, "\n"))
  let l:index = 0

	while index < len(l:resultArray)
	   let l:resultArray[index] = strpart(l:resultArray[index], 5)
	   let index = index + 1
	endwhile

  return join(l:resultArray, "\n")
endfunction

" Return the signature of the given Drupal hook
function s:getHookSignature(hook)
  let l:signature = ''

  if len(tagfiles()) == 1
    let l:signature = system('grep -m1 -oe "function[[:space:]+]hook_'. a:hook .'(.*{" '. get(tagfiles(), 0))
  else
    echohl WarningMsg | echo "Tagsfile not found!" | echohl None
  endif

  if l:signature == ''
    echohl WarningMsg | echo "Can't find the signature of hook_". a:hook .'()' | echohl None

    if inputlist(['What do you want to do?', '1. Ignore this warning and force the creation of this hook.', '2. Cancel this request.']) == 1
      let l:signature = 'function hook_'. a:hook ."() {\n"
    else
      return
    endif
  endif

  let l:moduleName = s:getModuleName()

  if l:moduleName == ''
    echohl WarningMsg | echo "No module name given... Cancelled!" | echohl None
    return
  endif

  let s:drupal_know_files[expand('%:p')] = l:moduleName

  return substitute(l:signature, 'function\s\+hook_', 'function '. l:moduleName .'_', '')
endfunction

" (Try to) Return the name of the Drupal module currently edited
function s:getModuleName()
  if has_key(s:drupal_know_files, expand('%:p'))
    return s:drupal_know_files[expand('%:p')]
  endif

  let l:fileParts = split(expand('%:t'), '\.')
  let l:default   = ''

  if len(l:fileParts) == 2 && l:fileParts[1] == 'module'
    return l:fileParts[0]
  endif

  let l:directory = '.'

  while !filereadable(l:directory .'/index.php') && l:default == '' && isdirectory(l:directory)
    if filereadable(l:directory .'/'. l:fileParts[0] .'.module')
      return l:fileParts[0]
    endif

    let l:candidates = split(system('ls -1 '. l:directory .' | grep ".module"'), "\n")

    if len(l:candidates) == 1
      return split(l:candidates[0], '\.')[0]
    elseif len(l:candidates) > 0
      let l:default = split(l:candidates[0], '\.')[0]
    endif

    let l:directory .= '/..'
  endwhile

  let l:question = "Sorry, can't determine the module name, please enter it: "

  if l:default != ''
    let l:question = 'More than one module found, please confirm: '
  endif

  return inputdialog(l:question, l:default)
endfunction

" Custom sort function for List: Remove duplicate entries in the same time
" Code from http://vim.wikia.com/wiki/Unique_sorting
function s:SortUnique(list, ...)
  let dictionary = {}

  for i in a:list
    execute "let dictionary[ '" . i . "' ] = ''"
  endfor

  let result = []

  if (exists( 'a:1' ))
    let result = sort(keys(dictionary), a:1)
  else
    let result = sort(keys(dictionary))
  endif

  return result
endfunction

