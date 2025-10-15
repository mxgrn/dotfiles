-- Custom vim-test strategy that always runs tests in the last tab
vim.g['test#custom_strategies'] = {
  custom_basic = function(cmd)
    -- Delete all buffers that are term:// and contain "mix test"
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) or vim.fn.bufexists(buf) == 1 then
        local name = vim.api.nvim_buf_get_name(buf)
        if name:match('term://') and name:match('mix%s+test') then
          -- force delete (also removes hidden ones)
          pcall(vim.cmd, 'silent! bdelete! ' .. buf)
        end
      end
    end

    -- If only one tab exists, create a new one at the end
    if vim.fn.tabpagenr('$') == 1 then
      vim.cmd('$tabnew')
    else
      vim.cmd('tablast')
    end

    -- Create new buffer and run tests
    vim.cmd('enew')
    vim.fn.termopen(cmd)
    if vim.g.start_insert_on_open then
      vim.cmd('startinsert')
    end
  end
}

vim.g['test#strategy'] = 'custom_basic'

vim.api.nvim_create_user_command("ToggleStartVimTestInInsert", function()
  vim.g.start_insert_on_open = not vim.g.start_insert_on_open
  if vim.g.start_insert_on_open then
    print("TestsStartInsert ON")
  else
    print("TestsStartInsert OFF")
  end
end, {})

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<space>n', ':wa<CR>:TestNearest<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>t', ':wa<CR>:TestLast<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>T', ':wa<CR>:TestSuite<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>s', ':wa<CR>:TestFile<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>v', ':wa<CR>:TestVisit<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>T', ':ToggleStartVimTestInInsert<CR>', opts)

return false
