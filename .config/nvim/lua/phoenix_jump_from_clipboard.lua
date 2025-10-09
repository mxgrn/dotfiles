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

return false
