require('packer_init')

require('core/options')
require('core/autocmds')
require('core/keymaps')
require('core/colors')
require('core/lsp')
require('core/quickfix')

require('plugins/treesitter')

-- Auto-reload init.lua when saved.
-- If you need the above modules to also be re-evaluated, the last line in each of them should be `return false`.
vim.cmd([[
  augroup init_lua_config
    autocmd!
    autocmd BufWritePost init.lua luafile %
  augroup end
]])
