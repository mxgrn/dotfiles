-- must be required _before_ plugins (otherwise vindent stops working, for example)
require('options')
require('plugins')
require('autocmds')
require('keymaps')
require('colors')
require('lsp')
require('quickfix')

-- Auto-reload init.lua when saved.
-- If you need the above modules to also be re-evaluated, the last line in each of them should be `return false`.
vim.cmd([[
  augroup init_lua_config
    autocmd!
    autocmd BufWritePost init.lua luafile %
  augroup end

  hi TreesitterContextBottom guibg=Black

  command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()
]])

-- Fix LuaSnip behaviour: https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
-- This is a workaround for the snippet "session" not finishing when exiting insert mode.
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end
})
