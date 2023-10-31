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
autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})

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

-- Autosave files on losing focus
autocmd('FocusLost', { pattern = '', command = "silent! wa" })

-- Expand DBUI dbout window on open
autocmd('FileType', { pattern = 'dbout', command = 'horizontal resize 40' })


return false
