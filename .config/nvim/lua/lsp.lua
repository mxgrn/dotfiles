-- Shared LSP settings
local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true })
  end
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#666666" })
  -- vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#aa0000" })
  -- vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#aa8800" })
  -- vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#8888aa" })
  -- vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#666666" })

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
