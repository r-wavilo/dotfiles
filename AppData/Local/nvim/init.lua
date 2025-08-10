
vim.opt.termguicolors = true

require("config.lazy")

vim.cmd[[

set smartcase
set ignorecase
noremap <C-LeftMouse> <Nop>

autocmd BufEnter * silent! lcd %:p:h

function! ToggleReadOnlyBit()
  let fname = fnameescape(substitute(expand("%:p"), "\\", "/", "g"))
  checktime
  execute "au FileChangedShell " . fname . " :echo"
  if &readonly
    silent !attrib -r %
  else
    silent !attrib +r %
  endif
  checktime
  set invreadonly
  execute "au! FileChangedShell " . fname
endfunction
command! XRO call ToggleReadOnlyBit()

function! FuncSetCurrentFileWriteable()
  let fname = fnameescape(substitute(expand("%:p"), "\\", "/", "g"))
  silent !attrib -r %
  set noreadonly
  execute "au! FileChangedShell " . fname
endfunction
command! SetCurrentFileWriteable call FuncSetCurrentFileWriteable()

]]