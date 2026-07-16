" Autocommands grouped in an augroup.
augroup my_filetype_hooks
  autocmd!
  autocmd BufReadPost *.log setlocal readonly
  autocmd BufNewFile,BufRead *.snippet setfiletype snippets
  autocmd FileType python setlocal shiftwidth=4
  autocmd InsertLeave * silent! update
augroup END

autocmd VimEnter * echo 'started'
