local g = vim.g
local o = vim.o
local A = vim.api

g.mapleader = ','

-- apply the color set to dark screens, not just the background of the screen
o.background = "dark"

-- clipboard between Neovim and other system programs
o.clipboard = "unnamedplus"

-- o.completeopt = "noinsert,menuone,noselect"
-- highlights the current line
o.cursorline = true
o.expandtab = true

-- improve the code folding behavior in TreeSitter
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldmethod = "manual"

-- hide unused buffers
o.hidden = true

-- (?) show replacements in a split window, before applying to the file
o.inccommand = "split"

-- allows the use of the mouse
o.mouse = "a"

-- o.number = true
-- o.relativenumber = true

o.shiftwidth = 2
o.smarttab = true

o.splitbelow = true
o.splitright = true

o.swapfile = false
o.tabstop = 2
o.termguicolors = true
o.title = false
o.ttimeoutlen = 0
o.updatetime = 250
o.wildmenu = true
o.wrap = true

-- Yanks go on clipboard
o.clipboard = 'unnamed'

o.backup = true
o.undofile = true
o.backupdir = os.getenv("XDG_CACHE_HOME") .. "/backup"
o.undodir = os.getenv("XDG_CACHE_HOME") .. "/undo"

-- Ack
g.ackprg = 'ag --vimgrep --smart-case'

-- A.nvim_create_autocmd("BufWrite", { pattern = "*", command = "" })
A.nvim_command('colorscheme one')
