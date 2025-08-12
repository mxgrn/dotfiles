-- must be required _before_ plugins (otherwise vindent stops working, for egample)
-- don't forget to run stow --adopt . when adding a new file here
require('options')
require('plugins')
require('autocmds')
require('keymaps')
require('colors')
require('lsp')
require('quickfix')
require('tabs')

-- Auto-reload init.lua when saved.
-- If you need the above modules to also be re-evaluated, the last line in each of them should be `return false`.
vim.cmd([[
  augroup init_lua_config
    autocmd!
    autocmd BufWritePost init.lua luafile %
  augroup end

  hi TreesitterContextBottom guibg=Black

  command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()

  " set showtabline=2
]])

-- Fix LuaSnip behaviour: https://github.com/L3MON4D3/LuaSnip/issues/258#issuecomment-1429989436
-- This is a workaround for the snippet "session" not finishing when exiting insert mode.
vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
        and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end
})

local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

ls.add_snippets("elixir", {
  s({
    trig = "([%l|%d|_]+:[%l|%d|_]+)", -- Matches a line that contains at least one colon
    regTrig = true,
    wordTrig = false,
  }, {
    f(function(_, snip)
      local input = snip.captures[1]
      local words = {}
      -- Split on colons
      for w in input:gmatch("[^:]+") do
        table.insert(words, w)
      end

      local pairs = {}
      for _, w in ipairs(words) do
        table.insert(pairs, w .. ": " .. w)
      end

      return "%{" .. table.concat(pairs, ", ") .. "}"
    end, {}),
  }),
})

-- Disable terminal buffers from showing up in the buffer list
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- local function sort_alias_block(args)
--   local bufnr = args.buf
--
--   local saved_view
--   vim.api.nvim_buf_call(bufnr, function()
--     saved_view = vim.fn.winsaveview()
--   end)
--
--   local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--   local alias_start = nil
--   local alias_end = nil
--
--   for i, line in ipairs(lines) do
--     if line:match("[%s\t]*alias%s+[A-Z]") then
--       if not alias_start then
--         alias_start = i - 1
--       end
--       alias_end = i - 1
--     elseif alias_start and not line:match("[%s\t]*alias%s+[A-Z]") then
--       break
--     end
--   end
--
--   if alias_start and alias_end and alias_end > alias_start then
--     local alias_lines = vim.api.nvim_buf_get_lines(bufnr, alias_start, alias_end + 1, false)
--     table.sort(alias_lines)
--     pcall(function()
--       vim.cmd.undojoin()
--       vim.api.nvim_buf_set_lines(bufnr, alias_start, alias_end + 1, false, alias_lines)
--     end)
--   end
--
--   vim.api.nvim_buf_call(bufnr, function()
--     vim.fn.winrestview(saved_view)
--   end)
-- end
--
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.ex", "*.exs" },
--   callback = sort_alias_block,
--   group = vim.api.nvim_create_augroup("ElixirAliasBlock", { clear = true }),
-- })

-- Recent Buffer Navigator for Neovim
-- This plugin tracks recently edited buffers and allows navigation with <C-p> and <C-n>

-- Module initialization
local M = {}

-- Store buffer history in a table where order doesn't change during browsing
-- Only when a buffer is saved, it will jump to the top
M.buffer_history = {}
M.current_index = 0

-- Add buffer to history or move it to the top if saved
local function update_buffer_history(buf_id)
  -- Don't track special buffers
  local buftype = vim.api.nvim_buf_get_option(buf_id, "buftype")
  if buftype ~= "" then
    return
  end

  -- Remove the buffer from history if it already exists
  for i, id in ipairs(M.buffer_history) do
    if id == buf_id then
      table.remove(M.buffer_history, i)
      break
    end
  end

  -- Add buffer to the top of history
  table.insert(M.buffer_history, 1, buf_id)

  -- Reset current index to top
  M.current_index = 1
end

-- Navigate to previous buffer in history
local function goto_prev_buffer()
  if #M.buffer_history <= 1 then
    return
  end

  M.current_index = M.current_index + 1

  -- Wrap around if reached the end
  if M.current_index > #M.buffer_history then
    M.current_index = 1
  end

  local buf_id = M.buffer_history[M.current_index]

  -- Check if buffer still exists
  if vim.api.nvim_buf_is_valid(buf_id) then
    vim.api.nvim_set_current_buf(buf_id)
  else
    -- Remove invalid buffer and try again
    table.remove(M.buffer_history, M.current_index)
    M.current_index = M.current_index - 1
    goto_prev_buffer()
  end
end

-- Navigate to next buffer in history
local function goto_next_buffer()
  if #M.buffer_history <= 1 then
    return
  end

  M.current_index = M.current_index - 1

  -- Wrap around if reached the beginning
  if M.current_index < 1 then
    M.current_index = #M.buffer_history
  end

  local buf_id = M.buffer_history[M.current_index]

  -- Check if buffer still exists
  if vim.api.nvim_buf_is_valid(buf_id) then
    vim.api.nvim_set_current_buf(buf_id)
  else
    -- Remove invalid buffer and try again
    table.remove(M.buffer_history, M.current_index)
    goto_next_buffer()
  end
end

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

-- vim.diagnostic.config({
--   virtual_line = { current_line = true },
-- })


vim.api.nvim_create_user_command("AckBuffers", function(opts)
  local args = table.concat(opts.fargs, " ")
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.fn.buflisted(buf) == 1 then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= "" and vim.fn.filereadable(name) == 1 then
        table.insert(buffers, vim.fn.shellescape(name))
      end
    end
  end
  if #buffers == 0 then
    print("No readable listed buffers.")
    return
  end
  local cmd = "ag " .. args .. " " .. table.concat(buffers, " ")
  local output = vim.fn.system(cmd)
  vim.cmd("botright copen")
  vim.fn.setqflist({}, ' ', { title = 'AckBuffers', lines = vim.fn.split(output, "\n") })
end, {
  nargs = "+",
})

-- Jump to Phoenix location annotations from html like:
-- <!-- <DemoWeb.CoreComponents.button> lib/demo_web/components/core_components.ex:543 (demo) -->
-- Assumes you have copied the annotation to your clipboard.
-- Just hit ctrl-c with the html comment selected in the inspector.
function PhoenixJumpFromClipboard()
  -- Get clipboard content
  local clipboard = vim.fn.getreg "+"

  -- Pattern to match file path and line number
  -- Looks for lib/path/file.ext:123 pattern
  local pattern = "([%w%._/-]+%.%w+):(%d+)"

  -- Extract file path and line number
  local file_path, line_number = string.match(clipboard, pattern)

  if file_path and line_number then
    -- Convert line number to integer
    line_number = tonumber(line_number)

    -- Try to open the file
    local ok, err = pcall(function()
      vim.cmd("edit " .. file_path)
      vim.api.nvim_win_set_cursor(0, { line_number, 0 })
    end)

    if not ok then
      print("Failed to jump to location: " .. err)
    else
      print("Jumped to " .. file_path .. " line " .. line_number)
    end
  else
    print "No file:line pattern found in clipboard"
  end
end

vim.api.nvim_create_user_command("PhoenixJump", PhoenixJumpFromClipboard, {})

-- map phoenix jump to <leader>pj
vim.keymap.set("n", "<space>pj", PhoenixJumpFromClipboard, { desc = "Phoenix jump" })
