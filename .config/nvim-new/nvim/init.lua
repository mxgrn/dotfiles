require("user/plugins")
require("user/indent")
require("user/strip_trailing")
require("user/settings")
require("user/keybinds")

-- Auto-reload init.lua when saved
-- If you need the above modules to also be re-evaluated, the last line in each of them should be `return false`
vim.cmd([[
  augroup init_lua_config
    autocmd!
    autocmd BufWritePost init.lua luafile %
  augroup end
]])

vim.cmd([[
  nnoremap <silent> <Esc> :nohls<CR>
  nnoremap <silent> <c-c> :nohls<CR>

  nnoremap <silent> <leader>/ :AckFromSearch<CR>
  let g:ackprg = 'ag --vimgrep --smart-case'
]])

vim.cmd 'colorscheme catppuccin'
