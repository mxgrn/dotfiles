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

autocmd('BufWritePre', {
  pattern = '',
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})

-- Settings for filetypes:
--------------------------

-- Disable line length marker
-- augroup('setLineLength', { clear = true })
-- autocmd('Filetype', {
--   group = 'setLineLength',
--   pattern = { 'text', 'markdown', 'html', 'xhtml', 'javascript', 'typescript' },
--   command = 'setlocal cc=0'
-- })

-- Terminal settings:
---------------------

-- Open a Terminal on the right tab
-- autocmd('CmdlineEnter', {
--   command = 'command! Term :botright vsplit term://$SHELL'
-- })

-- Enter insert mode when switching to terminal
-- autocmd('TermOpen', {
--   command = 'setlocal listchars= nonumber norelativenumber nocursorline',
-- })

-- autocmd('TermOpen', {
--   pattern = '',
--   command = 'startinsert'
-- })

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

return false
