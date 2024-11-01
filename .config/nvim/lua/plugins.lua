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
  "mbbill/undotree",
  -- {
  --   "mhanberg/output-panel.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("output_panel").setup()
  --   end
  -- },
  -- {
  --   "elixir-tools/elixir-tools.nvim",
  --   version = "*",
  --   event = { "BufReadPre", "BufNewFile" },
  --   config = function()
  --     local elixir = require("elixir")
  --     local elixirls = require("elixir.elixirls")
  --
  --     elixir.setup {
  --       nextls = { enable = false,
  --         on_attach = function(client, bufnr)
  --           -- vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --           -- vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --           -- vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  --           map_opts = { noremap = true, silent = true }
  --           vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  --           vim.keymap.set('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<cr>', map_opts)
  --           vim.keymap.set('n', '<space>[', '<cmd>lua vim.diagnostic.goto_next()<cr>', map_opts)
  --           vim.keymap.set('n', '<space>]', '<cmd>lua vim.diagnostic.goto_prev()<cr>', map_opts)
  --           vim.keymap.set('n', 'gr', vim.lsp.buf.references, map_opts)
  --           vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]])
  --
  --           vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --           -- vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  --         end,
  --       },
  --       credo = {},
  --       elixirls = {
  --         enable = true,
  --         settings = elixirls.settings {
  --           dialyzerEnabled = false,
  --           enableTestLenses = false,
  --         },
  --         on_attach = function(client, bufnr)
  --           -- vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --           -- vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --           -- vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  --           map_opts = { noremap = true, silent = true }
  --           vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
  --           vim.keymap.set('n', '<space>d', '<cmd>lua vim.diagnostic.open_float()<cr>', map_opts)
  --           vim.keymap.set('n', '<space>[', '<cmd>lua vim.diagnostic.goto_next()<cr>', map_opts)
  --           vim.keymap.set('n', '<space>]', '<cmd>lua vim.diagnostic.goto_prev()<cr>', map_opts)
  --           vim.keymap.set('n', 'gr', vim.lsp.buf.references, map_opts)
  --           vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]])
  --
  --           vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
  --           -- vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
  --           vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
  --         end,
  --       }
  --     }
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },
  -- Favorite color scheme
  -- To see all highlight groups created by Treesitter: https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights
  {
    'catppuccin/nvim',
    config = function()
      require('catppuccin').setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha

        highlight_overrides = {
          all = function(_)
            return {
              -- Don't use italics for module names
              ["@module"] = { style = {} },
            }
          end
        },

        styles = {                 -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { "italic" }, -- Change the style of comments
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = { "italic" },
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
      })
    end
  },

  -- Useful lua functions used by lots of plugins
  "nvim-lua/plenary.nvim",

  -- New-age netrw
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup({
        -- We still need netrw for :GBrowse
        default_file_explorer = false,
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
        },
      })
    end
  },

  -- All sorts of ] and [ goodies
  'tpope/vim-unimpaired',

  -- WIP
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- Read .env; needed by dadbod
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
    -- run = function()
    --   require('nvim-treesitter.install').update({ with_sync = true })
    -- end,
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
  -- Long unmaintained. Check out famiu/bufdelete.nvim at some point, may be a drop-in replacement.
  -- Difference b/w :Bdelete and :Bwipeout: Bwipeout also removes the buffer from the jumplist
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

  -- Enable :GBrowse
  'tpope/vim-rhubarb',

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
    config = function()
      vim.cmd [[
        let g:matchup_matchparen_offscreen = {}
        " If you want the matching line to appear on the top (overriding 'treesitter-context'), do this instead:
        " let g:matchup_matchparen_offscreen = { 'method': 'popup' }

        " Changing opening tag changes closing tag at quitting the insert mode
        let g:matchup_transmute_enabled = 1

        " Only highlight the current match, not what we have under the cursor
        hi MatchParenCur cterm=none gui=none
        hi MatchWordCur cterm=none gui=none
      ]]
    end,
  },

  -- Snippets
  {
    'honza/vim-snippets',
    config = function()
      require('luasnip.loaders.from_snipmate').lazy_load {}
    end
  },

  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
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

  -- 'github/copilot.vim',

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-cr>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
      })
    end,
  },

  -- Support for e.g. `da,`
  'wellle/targets.vim',

  -- Indentation support, e.g. '[i'
  -- The actuall mappings are in options.lua
  'jessekelighine/vindent.vim',

  -- time tracking
  { 'wakatime/vim-wakatime', lazy = false },

  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      -- Only required if using match_algorithm fzf
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  },
  {
    -- Show current window in the middle of the screen, hide everything else.
    -- I have it mapped to <cr>.
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = .8,  -- width of the Zen window
        height = .8, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
    }
  },
})
