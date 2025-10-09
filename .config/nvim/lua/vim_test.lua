-- Custom vim-test strategy that always runs tests in the last tab
vim.g['test#custom_strategies'] = {
  custom_basic = function(cmd)
    -- If only one tab exists, create a new one at the end
    if vim.fn.tabpagenr('$') == 1 then
      vim.cmd('$tabnew')
    else
      -- Otherwise, go to the last tab
      vim.cmd('tablast')
    end

    vim.cmd('enew')
    vim.fn.termopen(cmd)
    if vim.g['test#basic#start_normal'] ~= 1 then
      vim.cmd('startinsert')
    end
  end
}

vim.g['test#strategy'] = 'custom_basic'

return false
