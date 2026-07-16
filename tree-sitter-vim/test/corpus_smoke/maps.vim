" Key mappings of various modes and arguments.
nnoremap <silent> <leader>w :write<CR>
nnoremap <silent> <buffer> gd :call GoToDefinition()<CR>
inoremap jk <Esc>
vmap <leader>y "+y
xnoremap < <gv
nmap <expr> j v:count ? 'j' : 'gj'
noremap <silent> <F5> :make<CR>
tnoremap <Esc> <C-\><C-n>
