vim.cmd 'colorscheme catppuccin'

vim.cmd [[
  hi Folded guibg=NONE guifg=gray

  " slightly darker background on active windows
  hi Normal guifg=#cdd6f4 guibg=#1c1c1c

  " slightly lighter background on inactive windows
  hi NormalNC guifg=#cdd6f4 guibg=#202020
]]

return false
