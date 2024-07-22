vim.cmd 'colorscheme catppuccin'

vim.cmd [[
  hi Folded guibg=NONE guifg=gray

  " slightly darker background on active windows
  hi Normal guifg=#cdd6f4 guibg=#0f0f0f

  " Same color for nyngwang/NeoZoom.lua
  hi NormalFloat guifg=#cdd6f4 guibg=#1c1c1c

  " slightly lighter background on inactive windows
  hi NormalNC guifg=#cdd6f4 guibg=#282828

  hi VertSplit guifg=#282828 guibg=#1c1c1c

  hi StatusLineNC guifg=#666666 guibg=#282828
  hi StatusLine guifg=#eeeeee guibg=#282828

  " The leap plugin
  hi LeapLabelPrimary guifg=#1e1e2e guibg=#cdd6f4 cterm=bold gui=bold

  " Highlighted selection under cursor (active)
  hi CurSearch guifg=#1e1e2e guibg=#cdd6f4

  " Leap jump labels (bold doesn't seem to work)
  hi LeapLabel guifg=white guibg=black cterm=bold gui=bold
]]

return false
