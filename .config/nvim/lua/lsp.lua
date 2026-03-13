local lsp_group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true })

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(args)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = 'LSP: ' .. (desc or '') })
    end

    map("n", "gr", vim.lsp.buf.references)
    map("n", "<space>d", vim.diagnostic.open_float)
    map("n", "<space>[", vim.diagnostic.goto_prev)
    map("n", "<space>]", vim.diagnostic.goto_next)
  end
})
