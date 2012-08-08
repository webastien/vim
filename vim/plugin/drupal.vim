""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                                                  "
"     Drupal.vim - A simple plugin to help develop with Drupal     "
"                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Description:
"   (Actually) A very simple VIm plugin to help develop with Drupal.
"
" Maintainer:   Sébastien <webastien[At]gmail.com>
" Last Change:  2012 August 8
" Version:      v1.1
"
" Installation:
"   Required:
" - Drop this file to your plugin directory of vim.
"
"   Recommanded:
" - Install Drush! http://drupal.org/project/drush/
"   /!\ "EditDrupal" command will not work without!
"
" - Add an abbreviation for "EditDrupal" command.
"   To do it, add this to your .vimrc:
"         cabbrev YOURABBR <c-r>= ((getcmdtype() == ':' && getcmdpos() == 1)? 'EditDrupal': 'YOURABBR')<CR>
"   (where YOURABBR is the abbreviation you've choosed)
"
"   Example: cabbrev ed <c-r>= ((getcmdtype() == ':' && getcmdpos() == 1)? 'EditDrupal': 'ed')<CR>
"            Now, when you are in command mode, type ed<space> and 'ed' has been replaced by 'EditDrupal'.
"
"   Optional:
" - Map a key to call the "ResetVimDrupalCache" command.
"   To do it, add this to your .vimrc:
"         nmap YOURKEY :ResetVimDrupalCache<CR>
"   (where YOURKEY is the key you've choosed)
"
"   Example: nmap <F10> :ResetVimDrupalCache<CR>
"
" Usage:
" - "ResetVimDrupalCache" command:                  ** args: none **
"     Reset the internal cache.
"
"   Use it if a new module/theme/file is not autocompleted.
"
"
" - "Hook" command:                          **  args: {hook_name} **
"     Implement the named hook, where the cursor is.
"
"   For convinience, the module name is guessed by the file path,
"   when this is ambiguous or indeterminate, a prompt is displayed.
"   A cache (renewed each time vim is opened) is used to not ask
"   several times for the same file in which module it is associated.
"
"   Note that:
"   - If the hook implementation already exists (and found by ctags),
"     a new function is NOT created: The cursor is placed on this instead.
"   - If the hook contains a specific part (like hook_form_FORM_ID_alter),
"     a dialog will ask what use for it (in this example value of FORM_ID)
"
"
" - "EditDrupal" command:    **  args: {module / theme} {filepath} **
"     Edit a Drupal file.                      /!\ Require Drush! /!\
"
"   {module / theme} is the (machine) name of a module or a theme,
"   {filepath} is the path of a file, relative to this module / theme
"
"   You can use "/" as module argument: It will point to the Drupal root.
"
"   Some file are excluded from the autocomplete list.
"   By default: *.png, *.gif, *.jpg and *.jpeg
"   You can change which ones by adding (and adapting) this to your .vimrc:
"         let g:Drupal_excluded_extensions = 'png,gif,jpg,jpeg'
"   (coma separated file extensions to exclude, or empty to allow all files)
"
"

if exists('drupal_vim_loaded') || !has('autocmd') || !exists(':filetype')
  finish
endif

" Flag to indicate the plugin is already loaded
let drupal_vim_loaded = 1
" Flag to know if Drush is available
let s:has_drush = (system('which drush') != '')

if !exists('g:Drupal_excluded_extensions')
  let g:Drupal_excluded_extensions = 'png,gif,jpg,jpeg'
endif

""""""""""""""""""""
"   VIm commands   "
"__________________"

" Create a custom command to manage the script cache
command! -nargs=0 ResetVimDrupalCache :call s:resetCache(1)
" Create a custom command to directly implement a Drupal hook under the cursor
command! -nargs=1 -complete=custom,s:HookNameAutoComplete Hook :call s:ImplementDrupalHook(<q-args>)
" Without Drush installed, the command 'EditDrupal' will not work
if s:has_drush
  " Create a custom command to edit Drupal files without to type the complete path
  command! -nargs=+ -complete=custom,s:EditDrupalAutoComplete EditDrupal :call s:EditDrupal(<q-args>)
endif

"""""""""""""""""""""""
"   Cache functions   "
"_____________________"

" Init of reset the internal cache
function s:resetCache(message)
  let s:drupal_cache = {}

  if a:message
    echohl WarningMsg | echo "The cache of Drupal VIm plugin has been reseted." | echohl None
  endif
endfunction

" Get the cached value corresponding to the given infos
function s:cacheGet(funcname, funcargs, duration)
  let l:key = a:funcname .'°:-:°'. join(a:funcargs, '°:-:°')

  if has_key(s:drupal_cache, l:key)
    let [l:expire, l:value] = s:drupal_cache[l:key]

    if l:expire == -1 || l:expire > localtime()
      return l:value
    endif
  endif

  if exists('*'. a:funcname)
    let  l:value = call(a:funcname, a:funcargs)
    call s:cacheSet(l:key, l:value, a:duration)

    return l:value
  endif

  return -1
endfunction

" Store a cache value associated to a key and with a lifetime (in secondes)
function s:cacheSet(key, val, duration)
  let s:drupal_cache[a:key] = [(a:duration == -1)? -1: localtime() + a:duration, a:val]
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""
"   Functions relative to 'EditDrupal' command   "
"________________________________________________"

" Open the requested file: 1st arg is a module/theme name, the 2nd is one of its files (path relative to it)
function s:EditDrupal(args)
  let l:args = split(substitute(a:args, '\s\+', ' ', 'g'), ' ')
  let l:path = substitute(system('drush drupal-directory '. ((l:args[0] == '/')? '': l:args[0])), "\n", '', '')

  if match(l:path, '\[error\]') == -1
    let l:args[0] = ''
    " Two 'substitute' calls because one is required to accept filenames with spaces in it (in case of)
    exec 'edit '. l:path .'/'. substitute(substitute(join(l:args, ' '), '^\s\+\|\s\+$', '', 'g'), ' ', '\\ ', 'g')
  else
    echohl WarningMsg | echo "Can't find this module, sorry." | echohl None
  endif
endfunction

" Autocomplete function with 'double completion': 1st arg is a module/theme name, the 2nd is one of its files
function s:EditDrupalAutoComplete(ArgLead, CmdLine, CursorPos)
  let l:project = s:cacheGet('s:dirProject', [expand('%:p:h')], 3600)

  if l:project == ''
    return ''
  endif

  let l:args = split(substitute(a:CmdLine, '\s\+', ' ', 'g'), ' ')

  if strpart(a:CmdLine, len(a:CmdLine) - 1) == ' '
    call add(l:args, ' ')
  endif

  if len(l:args) == 2
    return s:cacheGet('s:projectModules', [l:project], 120)
  elseif len(l:args) == 3
    return s:cacheGet('s:moduleFiles', [l:args[1]], 60)
  else
    return ''
  endif
endfunction

function s:dirProject(directory)
  return substitute(system('drush status "Drupal root" --pipe'), '\n', '', '')
endfunction

function s:projectModules(project)
  let  l:modules = split(system('drush pml --pipe'), "\n")
  call insert(l:modules, '/')

  return join(l:modules, " \n")
endfunction

function s:moduleFiles(module)
  let l:path = substitute(system('drush drupal-directory '. ((a:module == '/')? '': a:module)), "\n", '', '')

  if match(l:path, '\[error\]') == -1
    let l:files = split(system('find '. l:path .' -type f '. g:Drupal_excluded_extensions), "\n")
    let l:start = len(l:path)
    let l:index = 0

    while l:index < len(l:files)
      let l:files[l:index] = strpart(l:files[l:index], l:start + 1)
      let l:index = l:index + 1
    endwhile

    return join(l:files, "\n")
  endif

  return ''
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""
"   Functions relative to the 'Hook' command   "
"______________________________________________"

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
  if &ft != 'php' || len(tagfiles()) != 1
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
      return ''
    endif
  endif

  let l:moduleName = s:cacheGet('s:getModuleName', [expand('%:p')], -1)

  if l:moduleName == ''
    echohl WarningMsg | echo "Cancelled..." | echohl None
    return ''
  endif

  let l:hook = a:hook
  let l:mask = matchstr(a:hook, '\C[A-Z]\{1}[A-Z_]\+[A-Z]\{1}')

  if l:mask != ''
    let l:rplc = inputdialog('This hook contains a part that need to be specified: '. l:mask .'=')

    if l:rplc == ''
      echohl WarningMsg | echo "Cancelled..." | echohl None
      return ''
    endif

    let l:hook = substitute(l:hook, l:mask, l:rplc, '')
  endif

  try
    let l:currentFile = expand('%:p')

    silent exec 'ts '. l:moduleName .'_'. l:hook
    exec 'tabnew'
    exec 'tag '. l:moduleName .'_'. l:hook

    if l:currentFile == expand('%:p')
      let l:currentLine = line('.')
      exec 'quit'
      exec 'norm '. l:currentLine .'G'
    endif

    exec 'norm zvzz'
  catch
    return substitute(l:signature, 'function\s\+hook_'. a:hook, 'function '. l:moduleName .'_'. l:hook, '')
  endtry

  return ''
endfunction

" (Try to) Return the name of the Drupal module currently edited
function s:getModuleName(path)
  let l:fileParts = split(split(a:path, '/')[-1], '\.')

  if len(l:fileParts) == 2 && l:fileParts[1] == 'module'
    return l:fileParts[0]
  endif

  let l:directory = substitute(a:path, '/[^/]\+$', '', '')
  let l:default   = ''

  while l:default == '' && isdirectory(l:directory) && !filereadable(l:directory .'/index.php')
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

""""""""""""""""""""""""
"   Helper functions   "
"______________________"

" Custom sort function for List: Remove duplicate entries in the same time
" Code from http://vim.wikia.com/wiki/Unique_sorting
function s:SortUnique(list, ...)
  let dictionary = {}

  for i in a:list
    execute "let dictionary[ '". i ."' ] = ''"
  endfor

  let result = []

  if (exists('a:1'))
    let result = sort(keys(dictionary), a:1)
  else
    let result = sort(keys(dictionary))
  endif

  return result
endfunction

" Build the command part to exclude files from autocomplete in DrupalEdit command
function s:buildExcludeCommand()
  let l:exts  = split(g:Drupal_excluded_extensions, ',')
  let l:index = 0

  while l:index < len(l:exts)
    let l:exts[l:index] = '-iname "*.'. substitute(l:exts[l:index], '^\s\+\|\s\+$', '', 'g') .'"'
    let l:index = l:index + 1
  endwhile

  return '! \( '. join(l:exts, ' -or ') .' \)'
endfunction

"""""""""""""""""""""""
"   Init the module   "
"______________________

" Build the usable exclude extensions command part
if g:Drupal_excluded_extensions != ''
  let g:Drupal_excluded_extensions = s:buildExcludeCommand()
endif
" Prepare the internal cache
call s:resetCache(0)

