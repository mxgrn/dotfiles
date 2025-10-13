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
    vim.cmd('startinsert')
  end
}

vim.g['test#strategy'] = 'custom_basic'

return false
