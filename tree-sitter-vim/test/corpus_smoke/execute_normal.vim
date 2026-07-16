" Execute and normal commands.
execute 'set tabstop=' . 4
execute 'nnoremap <leader>x :call ' . s:handler . '()<CR>'
normal! gg
normal! ggVG
silent execute 'edit ' . fnameescape(s:path)
execute 'source' fnameescape(expand('~/.vimrc.local'))
normal! dd
