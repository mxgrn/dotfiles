-- Don't forget to run `stow --adopt .` from /Users/mxgrn/dotfiles when adding a new file here

-- Must be required _before_ plugins (otherwise vindent stops working, for example)
require('options')

require('plugins')
require('autocmds')
require('keymaps')
require('colors')
require('lsp')
require('quickfix')
require('tabs')
require('vim_test')
require('projectionist')
require('phoenix_jump_from_clipboard')
require('unwrap_and_dedent')

-- Elixir
require('elixir_map_key_toggle')
require('elixir_copy_func_fqn')
require('elixir_snippets')
require('elixir_misc')

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
