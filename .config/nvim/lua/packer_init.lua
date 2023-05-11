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

  -- Color scheme
  use "rakr/vim-one"

  -- Netrw tweaks and fixes
  use 'tpope/vim-vinegar'

  -- All sorts of ]* and [* goodies
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

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      -- telescope-zf-native.nvim
      require("telescope").load_extension("zf-native")

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
    run =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    config = function()
    end
  }

  -- File type icons in Telescope
  use 'nvim-tree/nvim-web-devicons'

  -- Comment stuff like a pro
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Seamless navigation between neovim windows and tmux panes
  use {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()
    end
  }

  -- Extra buffer manupilations, such as :Bwipeout
  use 'moll/vim-bbye'

  -- Run tests directly from test files
  use 'vim-test/vim-test'

  -- Replace or delete surrounding characters
  use 'tpope/vim-surround'

  -- E.g. auto-add end after do
  use 'tpope/vim-endwise'

  -- Git support, e.g. :G
  use 'tpope/vim-fugitive'

  -- Make the dot command work in more situations
  use 'tpope/vim-repeat'

  -- Powerful search and replace, e.g. :S/foo/bar/g
  use 'tpope/vim-abolish'

  -- Support for Linux commands such as :Chmod
  use 'tpope/vim-eunuch'

  -- Alternate files (e.g. :A) and newly created file templates
  use 'tpope/vim-projectionist'

  -- Never lose your undo history: :UndotreeToggle
  use 'mbbill/undotree'

  -- Project-wide search: :Ack foo
  use 'mileszs/ack.vim'

  -- Grepping in open buffers, e.g.:
  -- :Bsgrep[!] {pattern}
  use 'jeetsukumaran/vim-buffersaurus'

  -- Swap any two fragments of text with shift-x (in visual mode)
  use 'tommcdo/vim-exchange'

  -- HTML support
  use 'mattn/emmet-vim'

  use {
    'nyngwang/NeoZoom.lua',
    config = function()
      require('neo-zoom').setup {
        popup = { enabled = true }, -- this is the default.
        -- NOTE: Add popup-effect (replace the window on-zoom with a `[No Name]`).
        -- EXPLAIN: This improves the performance, and you won't see two
        --          identical buffers got updated at the same time.
        -- popup = {
        --   enabled = true,
        --   exclude_filetypes = {},
        --   exclude_buftypes = {},
        -- },
        exclude_buftypes = { 'terminal' },
        -- exclude_filetypes = { 'lspinfo', 'mason', 'lazy', 'fzf', 'qf' },
        winopts = {
          offset = {
            -- NOTE: omit `top`/`left` to center the floating window vertically/horizontally.
            -- top = 0,
            -- left = 0.17,
            width = 150,
            height = 0.85,
          },
          -- NOTE: check :help nvim_open_win() for possible border values.
          border = 'thicc', -- this is a preset, try it :)
        },
        presets = {
          {
            -- NOTE: regex pattern can be used here!
            filetypes = { 'dapui_.*', 'dap-repl' },
            winopts = {
              offset = { top = 0.02, left = 0.26, width = 0.74, height = 0.25 },
            },
          },
          {
            filetypes = { 'markdown' },
            callbacks = {
              function() vim.wo.wrap = true end,
            },
          },
        },
      }
      vim.keymap.set('n', '<CR>', function() vim.cmd('NeoZoomToggle') end, { silent = true, nowait = true })
    end
  }

  -- use 'elixir-editors/vim-elixir'

  use {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require 'treesitter-context'.setup {
        max_lines = 1,
        min_window_height = 1
      }
    end
  }

  -- Jumping around the window with s or S
  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
      require('leap').opts.safe_labels = {}
    end
  }

  -- Language server manager
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
      -- Currently those configs are in "core/lsp.lua"
    end
  }

  -- use 'm4xshen/autoclose.nvim'


  -- use {
  --   "windwp/nvim-autopairs",
  --   config = function() require("nvim-autopairs").setup {} end
  -- }

  use 'neovim/nvim-lspconfig'

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
  use { 'kevinhwang91/nvim-bqf', ft = 'qf', config = function()
    require('bqf').setup({
      auto_enable = true,
      preview = {
        -- Disable auto-preview, didn't find it helpful
        auto_preview = false,
      },
    })
  end }

  use 'github/copilot.vim'

  -- Favor file names over paths when searching
  use "natecraddock/telescope-zf-native.nvim"

  -- Support for e.g. `da,`
  use 'wellle/targets.vim'

  -- Indentation support, e.g. '[-'
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
