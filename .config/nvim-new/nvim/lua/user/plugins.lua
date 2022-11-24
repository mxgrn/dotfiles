local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('PACKER', { clear = true }),
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerSync',
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({})

-- Install your plugins here
packer.startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use { 'williamboman/mason.nvim', config = function() require('mason').setup() end }
  use 'williamboman/mason-lspconfig.nvim'

  -- Snippets
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'

  use { 'neovim/nvim-lspconfig', config = function() require('user/plugins/lspconfig') end }
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins
  use "rakr/vim-one"
  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('user/plugins/treesitter')
    end,
  }
  use { 'nvim-telescope/telescope.nvim', config = function() require('user/plugins/telescope') end }
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    config = function()
    end
  }
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-vinegar'
  use { 'mxgrn/vim-zoomwin',
    config = function()
      vim.keymap.set('n', '<leader>,', '<CMD>ZoomWin<CR>')
    end
  }
  use {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()
    end
  }

  use({
    'tpope/vim-surround',
    event = 'BufRead',
    requires = {
      {
        'tpope/vim-repeat',
        event = 'BufRead',
      },
    },
  })

  use { 'mileszs/ack.vim' }

  use { 'tpope/vim-unimpaired' }

  use { 'moll/vim-bbye' }

  use { 'vim-test/vim-test' }

  use { "catppuccin/nvim", as = "catppuccin" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

return false
