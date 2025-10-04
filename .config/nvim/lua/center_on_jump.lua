-- What this does:
--
-- Records what is visible on the screen before the tag jump (every window: topline..botline and leftcol..rightcol).
--
-- Performs the tag jump (or tag-pop) in the normal way, without remapping recursion.
--
-- After the jump, checks whether the final cursor position was already visible (somewhere on the screen) before the jump.
--
-- If it was not visible, runs zz in the window you landed in.
--
-- Caveats / notes (short):
--
-- This treats "on the screen" as visible anywhere in any window (not only the current window) and checks both vertical and horizontal visibility.
--
-- It does not attempt to reconstruct fold state for an arbitrary line before the jump (rare edge case: if the target line was inside a closed fold and the folded line still falls into the visible range, the check may say "visible"). If you need fold-precise behaviour we can add heuristics.
--
-- If you have a custom remapping of <C-]> / <C-t> and expect that custom RHS to run, this code uses the default tag behavior (it purposely avoids remapping to prevent recursion). If you want to preserve a custom mapping instead, tell me and I’ll show a version that temporarily calls your mapping (more fiddly).

local function collect_visible_ranges()
  local ranges_by_buf = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    -- evaluate in that window's context
    local info = vim.api.nvim_win_call(win, function()
      local v = vim.fn.winsaveview() -- includes topline and leftcol
      local top = v.topline or vim.fn.line('w0')
      local bot = vim.fn.line('w$')
      local left = v.leftcol or 0
      local width = vim.api.nvim_win_get_width(0)
      local bufnr = vim.api.nvim_win_get_buf(0)
      return { bufnr = bufnr, top = top, bot = bot, left = left, width = width }
    end)

    ranges_by_buf[info.bufnr] = ranges_by_buf[info.bufnr] or {}
    table.insert(ranges_by_buf[info.bufnr], { top = info.top, bot = info.bot, left = info.left, width = info.width })
  end
  return ranges_by_buf
end

local function is_position_visible(ranges_for_buf, line, virtcol)
  if not ranges_for_buf then return false end
  for _, r in ipairs(ranges_for_buf) do
    if line >= r.top and line <= r.bot then
      local left = r.left
      local right = left + r.width - 1
      -- winsaveview().leftcol is 0-based; virtcol() is 1-based
      if virtcol >= (left + 1) and virtcol <= right then
        return true
      end
    end
  end
  return false
end

-- key is a termcode string like '<C-]>' or '<C-t>'
local function jump_and_maybe_center(key)
  local visible_before = collect_visible_ranges()

  -- send the raw key without remapping (prevent recursion). this uses default tag/pop behaviour.
  local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
  -- 'n' mode -> do not remap; third arg true is escape (standard pattern)
  vim.api.nvim_feedkeys(keys, 'n', true)

  -- check after the movement completed
  vim.schedule(function()
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_win_get_buf(cur_win)
    local cur_pos = vim.api.nvim_win_get_cursor(cur_win)
    local line = cur_pos[1]
    -- virtcol must be evaluated in the landed window
    local virtcol = vim.api.nvim_win_call(cur_win, function() return vim.fn.virtcol('.') end)

    local already_visible = is_position_visible(visible_before[cur_buf], line, virtcol)

    if not already_visible then
      -- center in the window we landed in
      vim.api.nvim_win_call(cur_win, function() vim.cmd('normal! zz') end)
    end
  end)
end

-- mappings
vim.keymap.set('n', '<C-]>', function() jump_and_maybe_center('<C-]>') end, { noremap = true, silent = true })
vim.keymap.set('n', '<C-t>', function() jump_and_maybe_center('<C-t>') end, { noremap = true, silent = true })

return false
