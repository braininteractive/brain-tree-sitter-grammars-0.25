" Script-local and autoload function definitions.
function! s:greet(name) abort
  let l:msg = 'hello, ' . a:name
  echo l:msg
endfunction

function! myplugin#util#trim(text) abort
  return substitute(a:text, '^\s*\|\s*$', '', 'g')
endfunction

function! s:sum(...) abort
  let l:total = 0
  for l:n in a:000
    let l:total += l:n
  endfor
  return l:total
endfunction

call s:greet('world')
call myplugin#util#trim('  padded  ')
