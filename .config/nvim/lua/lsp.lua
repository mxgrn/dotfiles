-- Shared LSP settings
local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
  end

  map("n", "K", vim.lsp.buf.hover)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "<space>d", vim.diagnostic.open_float)
  map("n", "<space>[", vim.diagnostic.goto_next)
  map("n", "<space>]", vim.diagnostic.goto_prev)

  vim.cmd([[command! Format execute 'lua vim.lsp.buf.format { async = true }']])
end

-- Apply this to *every* LSP
vim.lsp.config["*"] = {
  on_attach = on_attach,
}
