local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "catppuccin/nvim", as = "catppuccin" },

  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins

  -- Color scheme
  "rakr/vim-one",

  -- Netrw tweaks and fixes
  'tpope/vim-vinegar',

  -- All sorts of ]* and [* goodies
  'tpope/vim-unimpaired',

  -- WIP
  'nvim-treesitter/nvim-treesitter-textobjects',

  'tpope/vim-dotenv',

  -- Treesitter interface
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- WIP
        textobjects = {
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = { query = "@class.outer", desc = "Next class start" },
              --
              -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queires.
              ["]o"] = "@loop.*",
              -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
              --
              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
          }
        },
        auto_install = true,
        -- enable auto indentation while editing
        indent = {
          enable = true
        },
        -- A list of parser names, or "all"
        -- ensure_installed = 'all',
        -- ensure_installed = {},
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,
        highlight = {
          -- `false` will disable the whole extension
          enable = true,
        },
      }
    end,
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
  },

  -- Favor file names over paths when fuzzy-searching
  'natecraddock/telescope-zf-native.nvim',

  -- Telescope
  {
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
  },

  -- {
  --   'nvim-telescope/telescope-fzf-native.nvim',
  --   run =
  --   'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  --   config = function()
  --   end
  -- },

  -- File type icons in Telescope
  'nvim-tree/nvim-web-devicons',

  -- Comment stuff like a pro
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- Seamless navigation between neovim windows and tmux panes
  {
    'numToStr/Navigator.nvim',
    config = function()
      require('Navigator').setup()
    end
  },

  -- Extra buffer manupilations, such as :Bwipeout
  'moll/vim-bbye',

  -- Run tests directly from test files
  'vim-test/vim-test',

  -- Replace or delete surrounding characters
  'tpope/vim-surround',

  -- E.g. auto-add 'end' after 'do'
  {
    'RRethy/nvim-treesitter-endwise',
    config = function()
      require('nvim-treesitter.configs').setup {
        endwise = {
          enable = true,
        },
      }
    end
  },

  -- Git support, e.g. :G
  'tpope/vim-fugitive',

  -- Make the dot command work in more situations
  'tpope/vim-repeat',

  -- Powerful search and replace, e.g. :S/foo/bar/g
  'tpope/vim-abolish',

  -- Support for Linux commands such as :Chmod
  'tpope/vim-eunuch',

  -- Alternate files (e.g. :A) and newly created file templates
  'tpope/vim-projectionist',

  -- Never lose your undo history: :UndotreeToggle
  'mbbill/undotree',

  -- Project-wide search: :Ack foo
  'mileszs/ack.vim',

  -- Grepping in open buffers, e.g.:
  -- :Bsgrep[!] {pattern}
  'jeetsukumaran/vim-buffersaurus',

  -- Swap any two fragments of text with shift-x (in visual mode)
  'tommcdo/vim-exchange',

  -- HTML support
  'mattn/emmet-vim',

  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require 'treesitter-context'.setup {
        max_lines = 1,
        min_window_height = 1
      }
    end
  },

  -- Jumping around the window with s or S
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
      require('leap').opts.safe_labels = {}
    end
  },

  -- Language server manager
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  },

  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup()
      -- You can various LSs right here, check out `:h mason-lspconfig.setup_handlers()`
      -- Currently those configs are in "core/lsp.lua"
    end
  },

  'neovim/nvim-lspconfig',

  {
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  },

  -- Snippets
  'honza/vim-snippets',

  {
    'L3MON4D3/LuaSnip',
    -- follow latest release.
    -- tag = "v<CurrentMajor>.*",
    -- install jsregexp (optional!:).
    run = 'make install_jsregexp',
    config = function()
      -- require("luasnip.loaders.from_snipmate").lazy_load { paths = "./snippets" }
      require('luasnip.loaders.from_snipmate').lazy_load {}
    end
  },

  -- Hoped it would work with nvim-bqf, but it wouldn't.
  -- use 'junegunn/fzf.vim'

  -- Use QF window like a pro
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require('bqf').setup({
        auto_enable = true,
        preview = {
          -- Disable auto-preview, didn't find it helpful
          auto_preview = false,
        },
      })
    end
  },

  'github/copilot.vim',

  -- Support for e.g. `da,`
  'wellle/targets.vim',

  -- Indentation support, e.g. '[i'
  -- The actuall mappings are in options.lua
  'jessekelighine/vindent.vim',

  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  }
})
