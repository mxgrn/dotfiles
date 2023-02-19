-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme


-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  vim.o.runtimepath = vim.fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Autocommand that reloads neovim whenever you save the packer_init.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer_init.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use { "catppuccin/nvim", as = "catppuccin" }

  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  use "rakr/vim-one"

  use 'tpope/vim-vinegar'

  use 'tpope/vim-unimpaired'

  -- Treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- enable auto indentation while editing
        indent = {
          enable = true
        }
      }
    end,
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  }

  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').setup {
        defaults = {
          preview = false,
          mappings = {
            i = {
              -- Close Telescope window on Esc
              ["<esc>"] = require("telescope.actions").close,
            },
          },
        },

        pickers = {
          find_files = {
            -- Show hidden files
            hidden = true
          }
        }
      }
    end
  }

  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    config = function()
    end
  }

  use 'nvim-tree/nvim-web-devicons' -- for file icons

  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()
    end
  }

  use 'moll/vim-bbye'

  use 'vim-test/vim-test'

  use 'tpope/vim-surround'

  -- E.g. auto-add end after do
  use 'tpope/vim-endwise'

  use 'tpope/vim-fugitive'

  use 'tpope/vim-repeat'

  use 'tpope/vim-abolish'

  -- Support for Linux commands such as :Chmod
  use 'tpope/vim-eunuch'

  use 'tpope/vim-projectionist'

  use 'mbbill/undotree'

  use 'mileszs/ack.vim'

  use 'kana/vim-textobj-user'

  -- use 'mxgrn/vim-indent-object'

  -- Grepping in open buffers, e.g.:
  -- :Bsgrep[!] {pattern}
  use 'jeetsukumaran/vim-buffersaurus'

  use 'tommcdo/vim-exchange'

  -- HTML support
  use 'mattn/emmet-vim'

  use 'mxgrn/vim-zoomwin'

  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  }

  use {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  }

  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup()
      -- You can various LSs right here, check out `:h mason-lspconfig.setup_handlers()`
      -- Currently those are in "core/lsp.lua"
    end
  }

  use 'neovim/nvim-lspconfig'

  use 'andyl/vim-textobj-elixir'

  -- Snippets
  use 'honza/vim-snippets'

  use({
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    -- tag = "v<CurrentMajor>.*",
    -- install jsregexp (optional!:).
    run = "make install_jsregexp",
    config = function()
      -- require("luasnip.loaders.from_snipmate").lazy_load { paths = "./snippets" }
      require("luasnip.loaders.from_snipmate").lazy_load {}
    end
  })

  -- Hoped it would work with nvim-bqf, but it wouldn't.
  -- use 'junegunn/fzf.vim'

  -- Use QF window like a pro
  use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

  use 'github/copilot.vim'

  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- support for e.g. `da,`
  use 'wellle/targets.vim'

  -- Indentation support
  use({
    'jessekelighine/vindent.vim',
    config = function()
      -- vim.g.vindent_motion_OO_prev = '[i' -- jump to prev block of same indent.
      -- vim.g.vindent_motion_OO_next = ']i' -- jump to next block of same indent.
    end
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
