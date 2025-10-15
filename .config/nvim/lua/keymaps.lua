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

-- Because Telescope doesn't by default "see" symbolic links
-- nmap("<leader>v", ":e $MYVIMRC<cr><cmd>cd %:p:h<cr>")
nmap("<leader>v", ":e ~/dotfiles/.config/nvim/init.lua<cr><cmd>cd %:p:h<cr>")

nmap("<space>f", "<CMD>lua require'telescope.builtin'.find_files({show_untracked = true})<CR>")

-- Live grep from all currently open buffers
-- nmap("<leader>o",
--   "<cmd>lua require('telescope.builtin').live_grep({ grep_open_files = true, prompt_title = 'Live Grep (Open Buffers)' })<cr>")

-- Elixir
vim.keymap.set("n", "<space>ef", ":ElixirCopyFuncFqn<cr>")

-- Live grep from all currently open buffers
vim.keymap.set("n", "<space>/", function()
  local paths = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    local name = vim.api.nvim_buf_get_name(b)
    if vim.bo[b].buflisted and name ~= "" and not name:match("^%w+://") and vim.loop.fs_stat(name) then
      table.insert(paths, name)
    end
  end
  require("fzf-lua").live_grep({ search_paths = paths })
end, { desc = "fzf-lua: live_grep open buffers" })

-- nmap("<space>/", "<CMD>lua require'telescope.builtin'.current_buffer_fuzzy_find({})<CR>")
-- nmap("<leader>\\", "<CMD>lua require'telescope.builtin'.live_grep({})<CR>")
-- nmap("<c-p>", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>")
nmap("<c-p>", "<cmd>lua FzfLua.buffers({})<cr>")
nmap("<space>f", "<cmd>lua FzfLua.files({})<cr>")

-- nmap("<space>\\", ":lua vim.api.nvim_feedkeys(':AckBuffers ', 'n', true)<CR>")

-- Ack for the last search.
nmap("<leader>/", ":AckFromSearch<CR>")

-- Save all (unless unnamed) and quit on space-q
nmap("<space>q", "<cmd>silent! wa | qa!<CR>")

-- Line jumping
nmap("H", "g^")
nmap("L", "g$")
vmap("H", "g^")

-- Do not include EOL when selecting till the end of the string
vmap("L", "$h")

-- Delete w/o clogging the paste register
vmap("<leader>d", "\"_d")

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
nmap("<space>pn", ":sp .notes.md<cr>")

nmap("vig", "ggVG")

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

" noremap <A-LeftMouse> <LeftMouse>gF
]]

-- alt-click to jump to the file/line under the cursor
vim.keymap.set("n", "<A-LeftMouse>", function()
  -- Simulate cursor move on click
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<LeftMouse>", true, false, true),
    "n",
    false
  )

  vim.defer_fn(function()
    local word = vim.fn.expand("<cWORD>")

    -- Remove leading [ or other punctuation
    word = word:gsub("^[%[%(%{<]+", "")
    word = word:gsub("[%]%)}>,;]+$", "")

    -- Try to match "path/to/file.ex:123"
    local fname, lineno = word:match("([^:%s]+):(%d+)")
    if fname then
      vim.cmd("tabnext 1")
      vim.cmd("edit " .. fname)
      vim.cmd(lineno)
    else
      print("No file:line found under cursor")
    end
  end, 10) -- slight delay for <LeftMouse> to move the cursor
end, { noremap = true })

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
-- tmap("gt", "<c-\\><c-n>gt")
-- tmap("gT", "<c-\\><c-n>gT")
-- tmap("gg", "<c-\\><c-n>gg")

-- Terminal window navigation
-- tmap("<c-h>", "<c-\\><c-n><c-w>h")
-- tmap("<c-j>", "<c-\\><c-n><c-w>j")
-- tmap("<c-k>", "<c-\\><c-n><c-w>k")
-- tmap("<c-l>", "<c-\\><c-n><c-w>l")
-- tmap("<c-f>", "<c-\\><c-n><c-f>")
-- tmap("<c-b>", "<c-\\><c-n><c-b>")
-- tmap("<c-g><c-g>", "<c-\\><c-n><c-g><c-g>")

-- Why is this not working? You don't see anything unless you start typing:
-- nmap("<space>\\", ":AckBuffers ")
-- work-around:

-- Toggle QF window
nmap("<leader>u", "<cmd>lua require'quickfix'.toggle_qf()<cr>")

-- Git status
nmap("<space>g", "<cmd>G<cr>")

-- Manual cd into current file's dir
nmap("<space>c", "<cmd>cd %:p:h<cr>")

-- Center by hitting enter
-- nmap("<cr>", "zz")

-- Zen mode by hitting enter
-- nmap("<cr>", ":ZenMode<cr>")

nmap("1z", ":setlocal foldlevel=1<cr>")
nmap("2z", ":setlocal foldlevel=2<cr>")

nmap("<c-w><c-]>", ":vsplit<cr><c-]>")

vim.api.nvim_create_user_command('PhxServer', function()
  vim.cmd("let t:tab_title = 'phx.server'")
  vim.cmd('terminal iex -S mix phx.server')
end, {})

nmap('<space>is', ':tabnew | PhxServer<cr>')

-- Center on enter
nmap("<cr>", "zz")

vim.api.nvim_set_keymap("n", "<space>c", ":!", { noremap = true })

-- GitHub copilot: don't use tab to accept suggestions, as it interferes with snippets.
-- Instead, press ctrl + enter.
vim.api.nvim_set_keymap('i', '<c-cr>', 'copilot#Accept("")',
  { script = true, expr = true, silent = true })

vim.keymap.set('i', '<C-T>', '<Plug>(copilot-accept-line)')

-- vim.api.nvim_set_keymap('i', '<c-t>', '<Plug>(copilot-accept-line)', { script = true, expr = true, silent = true })
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

" typing % in visual mode will wrap the selection in %{} (requires vim-surround)
let g:surround_37 = "%{\r}"

" typing # in visual mode will wrap the selection in #{} (requires vim-surround)
let g:surround_35 = "#{\r}"

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

-- move back a character w/o leaving insert mode
vim.keymap.set("i", "<c-b>", "<left>")

-- vim.keymap.set("n", "<C-e>",
--   function()
--     local result = vim.treesitter.get_captures_at_cursor(0)
--     print(vim.inspect(result))
--   end,
--   { noremap = true, silent = false }
-- )

-- next buffer
-- vim.keymap.set("n", "<c-n>", ":bn<cr>", { silent = true })
-- vim.keymap.set("n", "<c-p>", ":bp<cr>", { silent = true })

-- vim-qf
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    -- Define your quickfix-specific mappings here
    vim.keymap.set('n', '{', '<Plug>(qf_previous_file)', { buffer = true })
    vim.keymap.set('n', '}', '<Plug>(qf_next_file)', { buffer = true })
  end
})

-- Close all buffers and windows in current tab
vim.api.nvim_create_user_command('CloseTab', function()
  -- Close all buffers in the current tab
  vim.cmd('tabdo bdelete')
  -- Close the current tab
  vim.cmd('tabclose')
end, { desc = 'Close all buffers and windows in current tab' })

vim.keymap.set('n', '_', ':ToggleElixirMapKeys<CR>', { desc = 'Converts a map from string keys to atom keys and back' })



-- clashing:
-- vmap("<space>r", ":'<,'>!bash<cr>")

return false
