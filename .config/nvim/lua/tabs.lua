local function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
  map('n', shortcut, command)
end

vim.cmd([[
" Set up a custom tabline that shows the tab number and title
set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let cwd = getcwd(-1, tabnr)
    let fallback = fnamemodify(cwd, ':t')  " last part of path
    let title = gettabvar(tabnr, 'tab_title', fallback)
    let s .= '%' . tabnr . 'T'
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tabnr . ':' . title . ' '
  endfor
  return s . '%#TabLineFill#%T'
endfunction

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
]])


-- Close all tabs exept current
-- nmap("<leader>T", ":tabonly<cr>:call DeleteHiddenBuffers()<cr>")

-- Switch between 2 recent tabs
nmap("<c-g><c-g>", ":exe 'tabn '.g:lasttab<cr>")

for i = 1, 9 do
  vim.keymap.set("n", "<A-" .. i .. ">", ":tabnext " .. i .. "<CR>")
end

-- Map key to switch to last tab
vim.api.nvim_set_keymap('n', '<leader>t', ':exe "tabn " . g:lasttab<CR>', { noremap = true, silent = true })

-- Going to next/prev tab
vim.keymap.set("n", "<A-]>", ":tabnext<CR>")
vim.keymap.set("n", "<A-[>", ":tabprevious<CR>")

return false
