-- Recompile on each Elixir file save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ex", "*.heex" },
  callback = function()
    -- run in background; no blocking, no noisy UI
    vim.fn.jobstart({ "mix", "compile" }, { detach = true })
  end
})

return false
