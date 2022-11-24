local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

-- local function imap(shortcut, command)
--   map('i', shortcut, command)
-- end

nmap("<leader>s", ":w<cr>")
nmap("<leader>v", ":e $MYVIMRC<cr>")

-- require('telescope').load_extension('fzf')
nmap("<c-p>", "<CMD>lua require'telescope.builtin'.find_files({show_untracked = true})<CR>")
nmap("<leader>f", "<cmd>Telescope buffers<cr>")

-- Window jumping
-- nmap("<C-h>", ":wincmd h<CR>")
-- nmap("<C-j>", ":wincmd j<CR>")
-- nmap("<C-k>", ":wincmd k<CR>")
-- nmap("<C-l>", ":wincmd l<CR>")

-- Save and quit on space-q
nmap("<space>q", ":wa<cr>:qa<cr>")

-- Line jumping
nmap("H", "g^")
nmap("L", "g$")
vmap("H", "g^")
vmap("L", "g$")

-- Reload current buffer
nmap("<leader>r", ":e<cr>")

-- Window/tmux-pane navigation

nmap("<C-h>", ":lua require('Navigator').left()<CR>")
nmap("<C-j>", ":lua require('Navigator').down()<CR>")
nmap("<C-k>", ":lua require('Navigator').up()<CR>")
nmap("<C-l>", ":lua require('Navigator').right()<CR>")

-- Ack
nmap("<leader>/", ":AckFromSearch")
nmap("<C-\\>", ":Ack<space>")

-- bbye
nmap("<space>k", ":close<CR>")

-- Tests
nmap("<space>n", ":wa<cr>:TestNearest<CR>")
nmap("<Leader>ta", ":wa<cr>:TestSuite<CR>")
nmap("<space>t", ":wa<cr>:TestLast<CR>")
nmap("<space>s", ":wa<cr>:TestFile<CR>")
nmap("<Leader>tv", ":wa<cr>:TestVisit<CR>")

return false
