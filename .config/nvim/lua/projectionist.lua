-- Pre-fill new files with a projectionist template
-- https://github.com/stevearc/oil.nvim/issues/280#issuecomment-2762958644
vim.api.nvim_create_augroup('base', {})
vim.api.nvim_create_autocmd('BufRead', {
  group = 'base',
  pattern = { '*' },
  callback = function()
    local lines = vim.fn.getline(1, '$')
    if #lines == 1 and lines[1] == '' then
      vim.cmd('doautocmd BufNewFile')
    end
  end
})

