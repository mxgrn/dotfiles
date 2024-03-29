local lspconfig = require('lspconfig')
local util = require 'lspconfig.util'

local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local map_opts = { noremap = true, silent = true }
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  map('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<cr>', map_opts)
  -- Move to the next and previous diagnostic
  map('n', '<space>[', '<cmd>lua vim.diagnostic.goto_next()<cr>', map_opts)
  map('n', '<space>]', '<cmd>lua vim.diagnostic.goto_prev()<cr>', map_opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, map_opts)
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]])
end

lspconfig.tsserver.setup { on_attach = on_attach }

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- https://www.reddit.com/r/neovim/comments/khk335/lua_configuration_global_vim_is_undefined/
        globals = { 'vim' }
      }
    }
  }
}

lspconfig.sqlls.setup {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach,
  root_dir = util.find_git_ancestor,
}

lspconfig.dockerls.setup {
  on_attach = on_attach,
}

lspconfig.jsonls.setup {}

lspconfig.html.setup {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = on_attach,
}

lspconfig.elmls.setup({
  on_attach = on_attach,
  settings = {
    elmLS = {
      onlyUpdateDiagnosticsOnSave = true
    }
  }
})
