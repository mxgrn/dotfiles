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
  "romainl/vim-qf",
  "barrettruth/diffs.nvim",

  -- QW ehnancements. I'm missing inline search by file names.
  -- {
  --   'stevearc/quicker.nvim',
  --   event = "FileType qf",
  --   ---@module "quicker"
  --   ---@type quicker.SetupOptions
  --   opts = {},
  -- },
  "mbbill/undotree",

  -- Going back and forth in time (c-j / c-k) through the commit history.
  -- Start with :Tardis. C-m to show the commit message.
  {
    'fredehoey/tardis.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,

  },
  -- Throws an error: https://github.com/aaronhallaert/advanced-git-search.nvim/issues/98
  -- {
  --   "aaronhallaert/advanced-git-search.nvim",
  --   cmd = { "AdvancedGitSearch" },
  --   config = function()
  --     require("advanced_git_search.fzf").setup {
  --       -- Browse command to open commits in browser. Default fugitive GBrowse.
  --       -- {commit_hash} is the placeholder for the commit hash.
  --       browse_command = "GBrowse {commit_hash}",
  --       -- when {commit_hash} is not provided, the commit will be appended to the specified command seperated by a space
  --       -- browse_command = "GBrowse",
  --       -- => both will result in calling `:GBrowse commit`
  --
  --       -- fugitive or diffview
  --       diff_plugin = "fugitive",
  --       -- customize git in previewer
  --       -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
  --       git_flags = {},
  --       -- customize git diff in previewer
  --       -- e.g. flags such as { "--raw" }
  --       git_diff_flags = {},
  --       git_log_flags = {},
  --       -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
  --       show_builtin_git_pickers = false,
  --       entry_default_author_or_date = "author", -- one of "author", "date" or "both"
  --       keymaps = {
  --         -- following keymaps can be overridden
  --         toggle_date_author = "<C-w>",
  --         open_commit_in_browser = "<C-o>",
  --         copy_commit_hash = "<C-y>",
  --         copy_commit_patch = "<C-p>", -- telescope only
  --         show_entire_commit = "<C-e>",
  --       }
  --     }
  --   end,
  --   dependencies = {
  --     -- Insert Dependencies here
  --   },
  -- },
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
    -- event = { "BufReadPost", "BufNewFile" },
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
        -- enable auto indentation while editing (important)
        indent = { enable = true },

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
  'junegunn/gv.vim',

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
    url = "https://codeberg.org/andyg/leap.nvim",
    config = function()
      -- Work-around for the warning, see: https://github.com/ggandor/leap.nvim/issues/279
      vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap-forward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-backward)')
      vim.keymap.set({ 'n', 'x', 'o' }, 'gS', '<Plug>(leap-from-window)')

      -- Un-color the search area
      vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })

      -- Disable "preview" (hihlighting possible targets after first char)
      require('leap').opts.preview = false

      -- Disable autojump to the first match
      require('leap').opts.safe_labels = {}
    end
  },

  -- Language server manager
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      -- pre-configured LSPs, so I don't have to do everything manually
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" }, -- whatever you need
      })

      -- This we do manually, as we have our custom Expert build
      -- vim.lsp.config("expert", {
      --   cmd = { vim.fn.expand("~/.local/bin/start_expert.sh") },
      --   root_markers = { ".git", "mix.exs", "mix.lock" },
      --   filetypes = { 'elixir', 'eelixir', 'heex' },
      -- })

      vim.lsp.enable({ "lua_ls" })
    end,
  },

  -- {
  --   'williamboman/mason.nvim',
  --   config = function()
  --     require("mason").setup()
  --   end
  -- },

  -- {
  --   'williamboman/mason-lspconfig.nvim',
  --   config = function()
  --     require("mason-lspconfig").setup()
  --     -- You can various LSs right here, check out `:h mason-lspconfig.setup_handlers()`
  --     -- Currently those configs are in "core/lsp.lua"
  --   end
  -- },
  --
  -- 'neovim/nvim-lspconfig',

  -- Disabling on 2025-11-29 due to performance issues
  -- {
  --   'andymass/vim-matchup',
  --   config = function()
  --     vim.cmd [[
  --       let g:matchup_matchparen_offscreen = {}
  --       " If you want the matching line to appear on the top (overriding 'treesitter-context'), do this instead:
  --       " let g:matchup_matchparen_offscreen = { 'method': 'popup' }
  --
  --       " Changing opening tag changes closing tag at quitting the insert mode
  --       let g:matchup_transmute_enabled = 1
  --
  --       " Only highlight the current match, not what we have under the cursor
  --       hi MatchParenCur cterm=none gui=none
  --       hi MatchWordCur cterm=none gui=none
  --     ]]
  --   end,
  -- },

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

  {
    "ibhagwan/fzf-lua",
    config = function()
      require('fzf-lua').setup({
        "telescope",
        actions = {
          files = {
            -- toggle searching hidden files and dirs with Ctrl-H
            ["ctrl-h"] = FzfLua.actions.toggle_hidden,
          },
        },
      })
    end
  },

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

  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       keymaps = {
  --         accept_suggestion = "<C-cr>",
  --         clear_suggestion = "<C-]>",
  --         accept_word = "<C-j>",
  --       },
  --     })
  --   end,
  -- },

  -- Support for e.g. `da,`
  'wellle/targets.vim',

  -- Indentation support, e.g. '[i'
  -- The actuall mappings are in options.lua
  'jessekelighine/vindent.vim',

  {
    "olimorris/codecompanion.nvim",
    opts = { ignore_warnings = true },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- time tracking
  { 'wakatime/vim-wakatime', lazy = false },

  "IndianBoy42/tree-sitter-just",

  -- Too little value (for now only clicking files in its output).
  -- DnD'ing of files doesn't work, expectedly.
  -- {
  --   "greggh/claude-code.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim", -- Required for git operations
  --   },
  --   config = function()
  --     require("claude-code").setup()
  --   end
  -- }
  'coder/claudecode.nvim',
  -- TODO: try out 'dmtrKovalenko/fff.nvim'

  -- This breaks the usual autocompletion, at least OOB.
  -- {
  --   'saghen/blink.cmp',
  --   -- optional: provides snippets for the snippet source
  --   dependencies = { 'rafamadriz/friendly-snippets' },
  --
  --   -- use a release tag to download pre-built binaries
  --   version = '1.*',
  --   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --   -- If you use nix, you can build from source using latest nightly rust with:
  --   -- build = 'nix run .#build-plugin',
  --
  --   opts = {
  --     -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  --     -- 'super-tab' for mappings similar to vscode (tab to accept)
  --     -- 'enter' for enter to accept
  --     -- 'none' for no mappings
  --     --
  --     -- All presets have the following mappings:
  --     -- C-space: Open menu or open docs if already open
  --     -- C-n/C-p or Up/Down: Select next/previous item
  --     -- C-e: Hide menu
  --     -- C-k: Toggle signature help (if signature.enabled = true)
  --     --
  --     -- See :h blink-cmp-config-keymap for defining your own keymap
  --     keymap = { preset = 'default' },
  --
  --     appearance = {
  --       -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = 'mono'
  --     },
  --
  --     -- (Default) Only show the documentation popup when manually triggered
  --     completion = { documentation = { auto_show = false } },
  --
  --     -- Default list of enabled providers defined so that you can extend it
  --     -- elsewhere in your config, without redefining it, due to `opts_extend`
  --     sources = {
  --       default = { 'lsp', 'path', 'snippets', 'buffer' },
  --     },
  --
  --     -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  --     -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  --     -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --     --
  --     -- See the fuzzy documentation for more information
  --     fuzzy = { implementation = "prefer_rust_with_warning" }
  --   },
  --   opts_extend = { "sources.default" }
  -- }
})
