" Conditional statements.
if has('nvim')
  let g:host = 'neovim'
elseif v:version >= 800
  let g:host = 'vim8'
else
  let g:host = 'legacy'
endif

if exists('g:loaded_plugin') && !get(g:, 'plugin_disabled', 0)
  echo 'plugin is active'
endif

if empty($HOME)
  echoerr 'no home directory'
endif
