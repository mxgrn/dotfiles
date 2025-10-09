-- =======================================
-- Unwrap and dedent inner block to current line's indent
-- =======================================

-- Unwrap the current line + its matching peer at the same indent,
-- and dedent the inner block so its minimum indent equals the current line's indent.
local function unwrap_and_dedent_same_indent()
  local buf = 0
  local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-based
  local last = vim.api.nvim_buf_line_count(buf)
  if row > last then return end

  local base_indent = vim.fn.indent(row)

  -- Find the next line with the SAME visual indent
  local match = nil
  for i = row + 1, last do
    if vim.fn.indent(i) == base_indent then
      match = i
      break
    end
  end
  if not match or match <= row + 1 then
    -- nothing (or no inner block) to unwrap
    -- still delete the opener if you want; but per request, bail out
    return
  end

  -- Compute the minimal indent among nonblank inner lines
  local inner_start, inner_end = row + 1, match - 1
  local min_indent = nil
  for i = inner_start, inner_end do
    local line = vim.fn.getline(i)
    if line:match("%S") then
      local ind = vim.fn.indent(i)
      min_indent = min_indent and math.min(min_indent, ind) or ind
    end
  end

  -- If all inner lines are blank, just delete wrapper lines
  -- Else dedent by delta = max(0, min_indent - base_indent)
  local delta = 0
  if min_indent then
    delta = math.max(0, min_indent - base_indent)
  end

  -- Helper to build leading whitespace of a desired visual width
  local function ws(desired_cols)
    if desired_cols <= 0 then return "" end
    if vim.bo.expandtab then
      return string.rep(" ", desired_cols)
    else
      local ts = vim.bo.tabstop
      local tabs = math.floor(desired_cols / ts)
      local spaces = desired_cols % ts
      return string.rep("\t", tabs) .. string.rep(" ", spaces)
    end
  end

  -- Start a single undo block
  vim.api.nvim_buf_call(buf, function()
    -- Dedent inner lines uniformly (preserve relative indentation)
    if delta > 0 then
      for i = inner_start, inner_end do
        local line = vim.fn.getline(i)
        if line:match("%S") then
          local curr_cols = vim.fn.indent(i)
          local desired = math.max(base_indent, curr_cols - delta)
          -- strip leading whitespace and rebuild to desired
          local stripped = line:gsub("^%s+", "")
          vim.fn.setline(i, ws(desired) .. stripped)
        end
      end
    end

    -- Delete closing peer first, then opener, with undojoin
    vim.api.nvim_buf_set_lines(buf, match - 1, match, false, {})
    pcall(vim.cmd, "undojoin")
    vim.api.nvim_buf_set_lines(buf, row - 1, row, false, {})
  end)
end

-- Map to dSi and make it dot-repeatable (uses tpope/repeat.vim if present)
vim.keymap.set('n', 'dSi', function()
  unwrap_and_dedent_same_indent()
  pcall(vim.fn['repeat#set'], 'dSi', -1)
end, { noremap = true, silent = true, desc = 'Unwrap lines and dedent inner block to current indent' })

return false
