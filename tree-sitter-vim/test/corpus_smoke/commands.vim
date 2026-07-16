" User-defined commands.
command! Hello echo 'hello'
command! -nargs=1 Greet echo 'hello, ' . <q-args>
command! -nargs=* -complete=file Open edit <args>
command! -range=% Format <line1>,<line2>call s:format()
command! -bang -bar Cleanup call s:cleanup(<bang>0)
delcommand Hello
