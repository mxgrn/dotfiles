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

-- Because Telescope doesn't by default "sees" symbolic links
-- nmap("<leader>v", ":e $MYVIMRC<cr><cmd>cd %:p:h<cr>")
nmap("<leader>v", ":e ~/dotfiles/.config/nvim/init.lua<cr><cmd>cd %:p:h<cr>")

-- require('telescope').load_extension('fzf')
nmap("<leader>f", "<CMD>lua require'telescope.builtin'.find_files({show_untracked = true})<CR>")
nmap("<space>f", "<CMD>lua require'telescope.builtin'.find_files({show_untracked = true})<CR>")
nmap("<space>/", "<CMD>lua require'telescope.builtin'.current_buffer_fuzzy_find({})<CR>")
nmap("<c-p>", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>")

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
nmap("<space>t", ":wa<cr>:TestLast<CR>")
nmap("<space>T", ":wa<cr>:TestSuite<CR>")
nmap("<space>s", ":wa<cr>:TestFile<CR>")
nmap("<space>v", ":wa<cr>:TestVisit<CR>")

-- Buffers
nmap("<space>k", ":close<CR>")
-- delete all saved buffers
nmap("<space>X", ":%bd<cr>")
-- vim-bbye kill buffer w/o closing the window (it won't kill last buffer)
nmap("<space>x", ":silent! w<cr>:Bdelete<cr>")
-- close window along with the buffer
nmap("<space>k", ":close<CR>")

-- vim-fugitive
nmap("<leader>g", ":Git blame<cr>")
nmap("<space>g", ":G<cr>")

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
nmap("<c-w>a", "<c-w>v:A<cr>")
nmap("<c-w>A", "<c-w>s:A<cr>")
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
tmap("gt", "<c-\\><c-n>gt")
tmap("gT", "<c-\\><c-n>gT")

-- Terminal window navigation
tmap("<c-h>", "<c-\\><c-n><c-w>h")
tmap("<c-j>", "<c-\\><c-n><c-w>j")
tmap("<c-k>", "<c-\\><c-n><c-w>k")
tmap("<c-l>", "<c-\\><c-n><c-w>l")
tmap("<c-f>", "<c-\\><c-n><c-f>")
tmap("<c-b>", "<c-\\><c-n><c-b>")

-- Ack for the last search.
nmap("<leader>/", ":AckFromSearch<CR>")

-- Toggle QF window
nmap("<leader>u", "<cmd>lua require'quickfix'.toggle_qf()<cr>")

-- Git status
nmap("<space>g", "<cmd>G<cr>")

-- Manual cd into current file's dir
nmap("<space>c", "<cmd>cd %:p:h<cr>")

-- Center by hitting enter
-- nmap("<cr>", "zz")

-- Zen mode by hitting enter
nmap("<cr>", ":ZenMode<cr>")

nmap("1z", ":setlocal foldlevel=1<cr>")
nmap("2z", ":setlocal foldlevel=2<cr>")

nmap("<c-w><c-]>", ":vsplit<cr><c-]>")

vim.cmd [[
au TabLeave * let g:lasttab = tabpagenr()

function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction
]]

-- Close all tabs exept current
nmap("<leader>T", ":tabonly<cr>:call DeleteHiddenBuffers()<cr>")

-- Switch between 2 recent tabs
nmap("<leader><leader>", ":exe 'tabn '.g:lasttab<cr>")

nmap("<leader>t", ":tabnew<cr>")

-- GitHub copilot: don't use tab to accept suggestions, as it interferes with snippets.
-- Instead, press ctrl + enter.
vim.api.nvim_set_keymap('i', '<c-cr>', 'copilot#Accept("")',
  { script = true, expr = true, silent = true })
-- this version would also exit insert mode, but it doesn't seem practical
-- vim.api.nvim_set_keymap('i', '<c-cr>', 'copilot#Accept("") . "<Esc>"', { script = true, expr = true, silent = true })
vim.g.copilot_no_tab_map = true

vim.cmd [[
function! NetrwEnter()
  nmap <buffer> <TAB> mfj
  nmap <buffer> ff %:w<CR>:buffer #<CR>
  " Make <c-l> to go to the window on the right as everywhere
  nnoremap <buffer> <c-l> :wincmd l<cr>
  nmap <buffer> mM mtmm
  nmap <buffer> x :!open %<cr>

  nmap <buffer> FF :call NetrwRemoveRecursive()<CR>
endfunction

augroup netrw_enter
  autocmd!
  autocmd filetype netrw call NetrwEnter()
augroup END

autocmd FileType foo let b:surround_45 = "%{\r}"

let g:surround_37 = "%{\r}"

" don't clobber the jumplist with } and {, source: https://superuser.com/questions/836784/in-vim-dont-store-motions-in-jumplist
nnoremap <silent> } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap <silent> { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
]]

---------
-- Elixir

-- Wrap selection in %{} (requires vim-surround)
vim.api.nvim_set_keymap('v', "<c-^>", "S}i%<esc>%", { noremap = false, silent = true })

-- oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set("i", "<c-\\>", " |> dbg<esc>")

-- vim.keymap.set("n", "<C-e>",
--   function()
--     local result = vim.treesitter.get_captures_at_cursor(0)
--     print(vim.inspect(result))
--   end,
--   { noremap = true, silent = false }
-- )

return false
