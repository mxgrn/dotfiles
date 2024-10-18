-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- General settings:
--------------------

-- Flash on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '200' })
  end
})

-- Remove whitespace on save
-- autocmd('BufWritePre', {
--   pattern = '',
--   command = ":%s/\\s\\+$//e"
-- })

-- Don't auto comment new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})

-- LSP-format before saving
autocmd('BufWritePre', {
  pattern = '',
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

-- Forcefully getting <c-\> back from vim-tmux-navigator
autocmd('VimEnter', {
  pattern = '',
  command = 'nnoremap <C-\\> :Ack<space>'
})

-- Forcefully getting <c-\> back from vim-tmux-navigator
autocmd('WinLeave', {
  pattern = '',
  command = 'set nocursorline'
})

-- Forcefully getting <c-\> back from vim-tmux-navigator
autocmd('WinEnter', {
  pattern = '',
  command = 'set cursorline'
})

-- Autosave files on losing focus
autocmd('FocusLost', { pattern = '', command = "silent! wa" })

-- For sql buffers, run sleek on save for formatting
autocmd('FileType', {
  pattern = 'sql',
  callback = function()
    autocmd('BufWritePre', {
      buffer = vim.api.nvim_get_current_buf(),
      callback = function()
        -- vim.cmd('silent %!pg_format')
        vim.cmd('silent %!sleek')
      end
    })
  end
})

return false
