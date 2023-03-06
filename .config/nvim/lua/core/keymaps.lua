vim.g.mapleader = ','

local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

local function vmap(shortcut, command)
  map('v', shortcut, command)
end

local function imap(shortcut, command)
  map('i', shortcut, command)
end

local function tmap(shortcut, command)
  map('t', shortcut, command)
end

nmap("<leader>s", ":w<cr>")
nmap("<leader>v", ":e $MYVIMRC<cr>")

-- require('telescope').load_extension('fzf')
nmap("<c-p>", "<CMD>lua require'telescope.builtin'.find_files({show_untracked = true})<CR>")
nmap("<leader>f", "<cmd>Telescope buffers<cr>")

-- Save and quit on space-q
nmap("<space>q", ":wa<cr>:qa<cr>")

-- Line jumping
nmap("H", "g^")
nmap("L", "g$")
vmap("H", "g^")
-- Do not include EOL when selecting till the end of the string
vmap("L", "$h")

-- Move naturally over wrapped lines
nmap("j", "gj")
nmap("k", "gk")
nmap("gj", "j")
nmap("gk", "k")
vmap("j", "gj")
vmap("k", "gk")
vmap("gj", "j")
vmap("gk", "k")

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

-- Tests
nmap("<space>n", ":wa<cr>:TestNearest<CR>")
nmap("<Leader>ta", ":wa<cr>:TestSuite<CR>")
nmap("<space>t", ":wa<cr>:TestLast<CR>")
nmap("<space>s", ":wa<cr>:TestFile<CR>")
nmap("<Leader>tv", ":wa<cr>:TestVisit<CR>")

-- Buffers
nmap("<space>k", ":close<CR>")
-- delete all saved buffers
nmap("<space>X", ":%bd<cr>")
-- vim-bbye kill buffer w/o closing the window (it won't kill last buffer)
nmap("<space>x", ":Bwipeout<cr>")
-- close window along with the buffer
nmap("<space>k", ":close<CR>")

-- vim-fugitive
nmap("<leader>g", ":Git blame<cr>")
nmap("<space>g", ":G<cr>")

-- ZoomWin
nmap("<leader>,", ":silent! ZoomWin<CR>")

-- Switch off search highlight
nmap("<Esc>", ":nohls<CR>")
nmap("<c-c>", ":nohls<CR>")

-- Don't clobber the unnamed register when pasting over text in visual mode.
vmap("p", "pgvy")

-- Project notes
nmap("<Leader>pn", ":sp .notes.md<cr>")

-- Luasnip
vim.cmd [[
" press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
" -1 for jumping backwards.
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

" For changing choices in choiceNodes (not strictly necessary for a basic setup).
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
]]

-- Open custom snippets for current filetype
nmap("<space><leader>s", ":execute 'edit' expand(stdpath('config')..'/snippets/'..(&filetype)..'.snippets')<cr>")

-- vim-projectionist
nmap("<space>a", ":A<cr>")
nmap("<space>eh", ":Ehtml<cr>")
nmap("<space>el", ":ELive<cr>")
nmap("<space>es", ":Esource<cr>")
nmap("<space>et", ":Etest<cr>")

-- Make line completion easier
imap("<C-l>", "<C-x><C-l>")

-- Make omnifunc completion easier
imap("<C-o>", "<C-x><C-o>")

-- Terminal behaviour
tmap("<esc>", "<c-\\><c-n>")
-- tmap("<c-c>", "<c-\\><c-n>")
tmap("gt", "<c-\\><c-n>gt")

-- Terminal window navigation
tmap("<c-h>", "<c-\\><c-n><c-w>h")
tmap("<c-j>", "<c-\\><c-n><c-w>j")
tmap("<c-k>", "<c-\\><c-n><c-w>k")
tmap("<c-l>", "<c-\\><c-n><c-w>l")

-- Ack for the last search.
nmap("<leader>/", ":AckFromSearch<CR>")

-- Toggle QF window
nmap("<leader>u", "<cmd>lua require'core/qf'.toggle_qf()<cr>")

-- Git status
nmap("<space>g", "<cmd>G<cr>")

-- Manual cd into current file's dir
nmap("<space>c", "<cmd>cd %:p:h<cr>")

-- Center various jumps
nmap("*", "*zz")
nmap("n", "nzz")
nmap("N", "Nzz")
nmap("<c-]>", "<c-]>zz")
nmap("<c-t>", "<c-t>zz")
nmap("<c-i>", "<c-i>zz")
nmap("<c-o>", "<c-o>zz")

-- GitHub copilot: don't use tab to accept suggestions, as it interferes with snippets.
-- Instead, press ctrl + enter.
vim.api.nvim_set_keymap('i', '<c-cr>', 'copilot#Accept("")',
  { script = true, expr = true, silent = true })
vim.g.copilot_no_tab_map = true

return false
