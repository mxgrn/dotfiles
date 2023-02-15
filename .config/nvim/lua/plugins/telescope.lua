vim.api.nvim_set_keymap("n", "<c-p>", "<CMD>lua require'telescope.builtin'.find_files({show_untracked = true})<CR>", {})
vim.api.nvim_set_keymap("n", "<space><c-p>", "<CMD>lua require'telescope.builtin'.find_files({show_untracked = true, cwd = vim.fn.expand('%:p:h')})<CR>", {})
vim.api.nvim_set_keymap("n", "<leader>f", "<CMD>lua require('telescope.builtin').buffers({ sort_mru = true })<CR>", {})

return false
