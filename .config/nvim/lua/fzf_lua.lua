-- Grep whatever is in current hlsearch
vim.keymap.set("n", "<leader>/", function()
  local pat = vim.fn.getreg("/")
  pat = pat
      :gsub("^\\[vVcCmM]", "")
      :gsub("\\<", "")
      :gsub("\\>", "")
  require("fzf-lua").grep({
    search = pat,
    literal = true,
  })
end, { desc = "grep for last search pattern" })

-- Grep whatever is in current hlsearch as a whole word
vim.keymap.set("n", "<space><leader>/", function()
  local pattern = vim.fn.getreg("/")
  -- remove Vim-specific regex modifiers (\V, \v, \c, etc.)
  pattern = pattern:gsub("^\\[vVcCmM]", "")
  -- wrap in word boundaries (ripgrep-style, not Vim-style)
  pattern = string.format("\\b%s\\b", pattern)
  require("fzf-lua").grep({
    search = pattern,
    no_esc = true, -- keep regex intact
    -- literal = false ensures ripgrep treats it as regex
  })
end, { desc = "grep for last search as a whole word" })

-- Handy to press <c-p> multiple times to go to previous buffers
vim.keymap.set("n", "<c-p>", ":FzfLua buffers<cr>")

vim.keymap.set("n", "<space>f", ":FzfLua files<cr>")

return false
