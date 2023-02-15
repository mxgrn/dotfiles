local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_attach = function(_, bufnr)
  local function map(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- bufnr=bufnr needed?
  local map_opts = { noremap = true, silent = true, buffer = bufnr }
  --
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]])
  -- map("n", "df", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
  -- map("n", "gd", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", map_opts)
  map("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
  map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", map_opts)
  map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", map_opts)

  -- map <silent> <space>d :lua vim.diagnostic.open_float()<cr>

  -- Show diagnostics in a floating window
  map('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<cr>', map_opts)

  -- Move to the previous diagnostic
  map('n', '<space>]', '<cmd>lua vim.diagnostic.goto_prev()<cr>', map_opts)

  -- Move to the next diagnostic
  map('n', '<space>[', '<cmd>lua vim.diagnostic.goto_next()<cr>', map_opts)

  vim.keymap.set('n', 'gr', vim.lsp.buf.references, map_opts)
  -- map("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
  -- map("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
  -- map("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
  --
  -- -- These have a different style than above because I was fiddling
  -- -- around and never converted them. Instead of converting them
  -- -- now, I'm leaving them as they are for this article because this is
  -- -- what I actually use, and hey, it works ¯\_(ツ)_/¯.
  -- vim.cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
  -- vim.cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
  --
  -- vim.cmd [[imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  -- vim.cmd [[smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']]
  -- vim.cmd [[imap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]
  -- vim.cmd [[smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']]
  --
  -- vim.cmd [[inoremap <silent><expr> <C-k> compe#complete()]]
  --
  -- vim.cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
  -- vim.cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
  -- vim.cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
  -- vim.cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]

  -- tell nvim-cmp about our desired capabilities
  -- require("cmp_nvim_lsp").update_capabilities(capabilities)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches.
-- Add your language server below:
local servers = { 'lua' }

local root_dir = function()
  return vim.fn.getcwd()
end

-- Call setup
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
      on_attach = on_attach,
      root_dir = root_dir,
      capabilities = capabilities,
      flags = {
          -- default in neovim 0.7+
          debounce_text_changes = 150,
      }
  }
end
