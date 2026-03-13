-- Copy filename:line_number with :ElixirCopyLineWithFile
local M = {}

function M.elixir_copy_line_with_file()
  local filepath = vim.fn.expand("%:p")
  local line = vim.api.nvim_win_get_cursor(0)[1]

  local result = filepath .. ":" .. line

  -- write to unnamed and system clipboard (pcall for safety)
  vim.fn.setreg('"', result)
  pcall(vim.fn.setreg, '+', result)

  print(result)
end

vim.api.nvim_create_user_command("ElixirCopyLineWithFile", function()
  M.elixir_copy_line_with_file()
end, {})

return M
