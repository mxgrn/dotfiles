-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

local g                    = vim.g -- Global variables
local opt                  = vim.opt -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse                  = 'a' -- Enable mouse support
opt.clipboard              = 'unnamedplus' -- Copy/paste to system clipboard
opt.swapfile               = false -- Don't use swapfile
opt.complete               = '.,w,b' -- For autocomplete, use current buffer, other windows, and other open buffers
opt.undofile               = true -- Persistent undo history

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
-- opt.number = true           -- Show line number
opt.showmatch              = true -- Highlight matching parenthesis
opt.foldmethod             = 'marker' -- Enable folding (default 'foldmarker')
-- opt.splitright = true       -- Vertical split to the right
-- opt.splitbelow = true       -- Horizontal split to the bottom
opt.ignorecase             = true -- Ignore case letters when search
opt.smartcase              = true -- Ignore lowercase for the whole pattern
opt.linebreak              = true -- Wrap on word boundary
opt.termguicolors          = true -- Enable 24-bit RGB colors
-- opt.laststatus=3            -- Set global statusline

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab              = true -- Use spaces instead of tabs
opt.shiftwidth             = 2 -- Shift 4 spaces when tab
opt.tabstop                = 2 -- 1 tab == 4 spaces
opt.smartindent            = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden                 = true -- Enable background buffers
-- opt.history = 100           -- Remember N lines in history
opt.lazyredraw             = true -- Faster scrolling
opt.synmaxcol              = 240 -- Max column for syntax highlight
opt.updatetime             = 250 -- ms to wait for trigger an event

-----------------------------------------------------------
-- Working directory
-----------------------------------------------------------
g.netrw_altv               = 1
g.netrw_alto               = 1
-- g.netrw_banner          = 1
g.netrw_localcopydircmd    = 'cp -r'

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
-- opt.shortmess:append "sI"

-- Ack
g.ackprg                   = 'ag --vimgrep --smart-case'

-- vindent.vim
g.vindent_motion_OO_prev   = '[i' -- jump to prev block of same indent.
g.vindent_motion_OO_next   = ']i' -- jump to next block of same indent.
g.vindent_motion_more_prev = '[+' -- jump to prev line with more indent.
g.vindent_motion_more_next = ']+' -- jump to next line with more indent.
g.vindent_motion_less_prev = '[-' -- jump to prev line with less indent.
g.vindent_motion_less_next = ']-' -- jump to next line with less indent.
g.vindent_motion_diff_prev = '[;' -- jump to prev line with different indent.
g.vindent_motion_diff_next = '];' -- jump to next line with different indent.
g.vindent_motion_XX_ss     = '[p' -- jump to start of the current block scope.
g.vindent_motion_XX_se     = ']p' -- jump to end   of the current block scope.
g.vindent_object_XX_ii     = 'ii' -- select current block.
g.vindent_object_XX_ai     = 'aI' -- select current block + one extra line  at beginning.
g.vindent_object_XX_aI     = 'ai' -- select current block + two extra lines at beginning and end.
g.vindent_jumps            = 1 -- make vindent motion count as a |jump-motion| (works with |jumplist|).

-- -- Disable builtin plugins
local disabled_built_ins   = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
