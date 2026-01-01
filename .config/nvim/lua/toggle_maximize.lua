-- Toggles window maximization while preserving exact layout
-- How it works:
-- 1. Uses :mksession/:source to save/restore layout
-- 2. Tracks window sizes and focused window by layout tree index
-- 3. Ignores floating windows when counting, otherwise they mess up the layout

local M = {}

-- State storage
M.session_file = vim.fn.stdpath("state") .. "/toggle_maximize_session.vim"
M.is_maximized = false
M.saved_sizes = nil   -- list of {width, height} in layout order
M.focused_index = nil -- index of focused window in layout order

-- Check if window is a regular (non-floating) window
local function is_regular_win(win)
  local config = vim.api.nvim_win_get_config(win)
  return config.relative == ""
end

-- Get all regular (non-floating) window IDs in layout order (depth-first traversal)
local function get_wins_in_layout_order()
  local wins = {}
  local function traverse(node)
    if node[1] == "leaf" then
      local win = node[2]
      if is_regular_win(win) then
        table.insert(wins, win)
      end
    else
      for _, child in ipairs(node[2]) do
        traverse(child)
      end
    end
  end
  traverse(vim.fn.winlayout())
  return wins
end

-- Count regular (non-floating) windows
local function count_regular_wins()
  local count = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if is_regular_win(win) then
      count = count + 1
    end
  end
  return count
end

-- Save window sizes in layout order, return sizes and focused index
local function save_window_sizes()
  local wins = get_wins_in_layout_order()
  local current_win = vim.api.nvim_get_current_win()
  local sizes = {}
  local focused_idx = nil

  for i, win in ipairs(wins) do
    sizes[i] = {
      width = vim.api.nvim_win_get_width(win),
      height = vim.api.nvim_win_get_height(win),
    }
    if win == current_win then
      focused_idx = i
    end
  end

  return sizes, focused_idx
end

-- Maximize: save session and close other windows
local function maximize()
  local win_count = count_regular_wins()
  if win_count <= 1 then
    return -- Nothing to maximize
  end

  -- Save window sizes and focused index
  M.saved_sizes, M.focused_index = save_window_sizes()

  -- Save session (must happen BEFORE :only)
  vim.cmd("mksession! " .. vim.fn.fnameescape(M.session_file))

  M.is_maximized = true

  -- Close all other windows
  vim.cmd("only")
end

-- Restore: load session and apply saved sizes
local function restore()
  if vim.fn.filereadable(M.session_file) == 0 then
    M.is_maximized = false
    return
  end

  -- Restore session
  local ok, err = pcall(function()
    vim.cmd("source " .. vim.fn.fnameescape(M.session_file))
  end)

  if not ok then
    return
  end

  -- Get windows in layout order after restore
  local wins = get_wins_in_layout_order()

  -- Check if restore actually worked
  if #wins <= 1 then
    return
  end

  -- Apply saved sizes (do it twice to handle interdependencies)
  if M.saved_sizes then
    for _ = 1, 2 do
      for i, size in ipairs(M.saved_sizes) do
        local win = wins[i]
        if win and vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_set_width(win, size.width)
          vim.api.nvim_win_set_height(win, size.height)
        end
      end
    end
  end

  -- Restore focus using saved index
  if M.focused_index and wins[M.focused_index] then
    vim.api.nvim_set_current_win(wins[M.focused_index])
  end

  -- Clear state only on success
  M.is_maximized = false
  M.saved_sizes = nil
  M.focused_index = nil
  vim.fn.delete(M.session_file)
end

-- Toggle function
function M.toggle()
  if M.is_maximized then
    -- Check if window count changed (user created new windows)
    local current_count = count_regular_wins()
    if current_count > 1 then
      -- New window created while maximized, reset state and maximize new layout
      M.is_maximized = false
      M.saved_sizes = nil
      M.focused_index = nil
      vim.fn.delete(M.session_file)
      maximize()
    else
      restore()
    end
  else
    maximize()
  end
end

-- Setup function
function M.setup()
  vim.api.nvim_create_user_command("ToggleMaximize", M.toggle, {})
end

return M
