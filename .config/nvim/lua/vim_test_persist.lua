-- vim-test-persist.lua
-- Persists vim-test's last_position across Neovim restarts
--
-- Installation:
-- 1. Save this file to ~/.config/nvim/lua/vim-test-persist.lua
-- 2. Add to your init.lua: require('vim-test-persist').setup()
--
-- The script will automatically save and restore:
-- - g:test#last_position (file, line, col)
-- - g:test#last_command (the test command)

local M = {}

-- Path to the persistence file
local data_path = vim.fn.stdpath('data') .. '/vim-test-last-position.json'

-- Save the last position to disk
local function save_last_position()
  -- Check if vim-test has stored a last position
  local last_position = vim.g['test#last_position']
  local last_command = vim.g['test#last_command']
  
  if not last_position then
    return
  end
  
  local data = {
    last_position = last_position,
    last_command = last_command,
    timestamp = os.time()
  }
  
  -- Convert to JSON and write to file
  local json = vim.json.encode(data)
  local file = io.open(data_path, 'w')
  if file then
    file:write(json)
    file:close()
  end
end

-- Restore the last position from disk
local function restore_last_position()
  local file = io.open(data_path, 'r')
  if not file then
    return
  end
  
  local content = file:read('*all')
  file:close()
  
  if not content or content == '' then
    return
  end
  
  -- Decode JSON
  local ok, data = pcall(vim.json.decode, content)
  if not ok or not data then
    return
  end
  
  -- Restore the vim-test variables
  if data.last_position then
    vim.g['test#last_position'] = data.last_position
  end
  
  if data.last_command then
    vim.g['test#last_command'] = data.last_command
  end
  
  -- Optional: print a message showing what was restored
  if vim.g['test#last_position'] then
    local pos = vim.g['test#last_position']
    vim.notify(
      string.format('Restored vim-test position: %s:%d', 
        vim.fn.fnamemodify(pos.file, ':~:.'), pos.line),
      vim.log.levels.INFO
    )
  end
end

-- Setup function to initialize the plugin
function M.setup(opts)
  opts = opts or {}
  
  -- Allow custom data path
  if opts.data_path then
    data_path = opts.data_path
  end
  
  -- Restore on startup
  restore_last_position()
  
  -- Create autocommands to save on certain events
  local group = vim.api.nvim_create_augroup('VimTestPersist', { clear = true })
  
  -- Save when vim-test variables change
  vim.api.nvim_create_autocmd('User', {
    pattern = 'TestFinished',
    group = group,
    callback = save_last_position,
    desc = 'Save vim-test position after test runs'
  })
  
  -- Also save on VimLeave as a fallback
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    callback = save_last_position,
    desc = 'Save vim-test position before exit'
  })
  
  -- Create a command to manually save/restore
  vim.api.nvim_create_user_command('TestPersistSave', save_last_position, {
    desc = 'Manually save vim-test last position'
  })
  
  vim.api.nvim_create_user_command('TestPersistRestore', restore_last_position, {
    desc = 'Manually restore vim-test last position'
  })
  
  vim.api.nvim_create_user_command('TestPersistClear', function()
    os.remove(data_path)
    vim.g['test#last_position'] = nil
    vim.g['test#last_command'] = nil
    vim.notify('Cleared vim-test persistent data', vim.log.levels.INFO)
  end, {
    desc = 'Clear vim-test persistent data'
  })
  
  -- Alternative: Poll for changes periodically (if TestFinished event doesn't work)
  if opts.auto_save_interval then
    local timer = vim.loop.new_timer()
    timer:start(opts.auto_save_interval * 1000, opts.auto_save_interval * 1000, vim.schedule_wrap(function()
      save_last_position()
    end))
  end
end

-- Manual save/restore functions for direct use
M.save = save_last_position
M.restore = restore_last_position

return M
