" Variable assignment across scopes, registers and options.
let g:plugin_loaded = 1
let b:current_syntax = 'vim'
let w:window_id = 42
let s:counter = 0
let s:counter += 1
let @a = 'register contents'
let &tabstop = 4
let &l:shiftwidth = 2
const g:frozen = 'immutable'
unlet! g:plugin_loaded
