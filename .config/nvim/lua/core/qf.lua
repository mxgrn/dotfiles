local M = {}

-- based on https://www.reddit.com/r/neovim/comments/ol2vx4/comment/h5d8kyg/
M.toggle_qf = function()
  local qf_exists = false

  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end

  if qf_exists == true then
    vim.cmd "cclose"
    return
  end

  vim.cmd "copen"
end

return M
