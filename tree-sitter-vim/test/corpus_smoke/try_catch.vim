" Exception handling.
try
  call s:might_fail()
catch /^Vim\%((\a\+)\)\=:E117/
  echomsg 'function does not exist'
catch /.*/
  echomsg 'unexpected error: ' . v:exception
finally
  echomsg 'cleanup done'
endtry

try
  throw 'MyError'
catch /MyError/
  echo 'caught my own error'
endtry
