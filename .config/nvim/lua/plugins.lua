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
  -- My 2 favorite colorschemes
  'EdenEast/nightfox.nvim',
  'catppuccin/nvim',

  -- Useful lua functions used by lots of plugins
  "nvim-lua/plenary.nvim",

  -- New-age netrw
  {
    'stevearc/oil.nvim',
    config = function()
      require("oil").setup({
        -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
        -- Set to false if you still want to use netrw.
        default_file_explorer = false,
        -- Id is automatically added at the beginning, and name at the end
        -- See :help oil-columns
        columns = {
          "icon",
          -- "permissions",
          -- "size",
          -- "mtime",
        },
        -- Buffer-local options to use for oil buffers
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        -- Window-local options to use for oil buffers
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
        delete_to_trash = false,
        -- Skip the confirmation popup for simple operations
        skip_confirm_for_simple_edits = false,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        prompt_save_on_select_new_entry = true,
        -- Oil will automatically delete hidden buffers after this delay
        -- You can set the delay to false to disable cleanup entirely
        -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
        cleanup_delay_ms = 2000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        lsp_rename_autosave = false,
        -- Constrain the cursor to the editable parts of the oil buffer
        -- Set to `false` to disable, or "name" to keep it on the file names
        constrain_cursor = "editable",
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-h>"] = false,
          ["<C-l>"] = false,
          -- ["<C-s>"] = "actions.select_vsplit",
          -- ["<C-t>"] = "actions.select_tab",
          -- ["<C-p>"] = "actions.preview",
          -- ["<esc>"] = "actions.close",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        -- Set to false to disable all of the above keymaps
        use_default_keymaps = true,
        view_options = {
          -- Show files and directories that start with "."
          show_hidden = false,
          -- This function defines what is considered a "hidden" file
          is_hidden_file = function(name, _)
            return vim.startswith(name, ".")
          end,
          -- This function defines what will never be shown, even when `show_hidden` is set
          is_always_hidden = function(_name, _)
            return false
          end,
          sort = {
            -- sort order can be "asc" or "desc"
            -- see :help oil-columns to see which columns are sortable
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        -- Configuration for the floating window in oil.open_float
        float = {
          -- Padding around the floating window
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          override = function(conf)
            return conf
          end,
        },
        -- Configuration for the actions floating preview window
        preview = {
          -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_width and max_width can be a single value or a list of mixed integer/float types.
          -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
          max_width = 0.9,
          -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
          min_width = { 40, 0.4 },
          -- optionally define an integer/float for the exact width of the preview window
          width = nil,
          -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
          -- min_height and max_height can be a single value or a list of mixed integer/float types.
          -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
          max_height = 0.9,
          -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
          min_height = { 5, 0.1 },
          -- optionally define an integer/float for the exact height of the preview window
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
          -- Whether the preview window is automatically updated when the cursor is moved
          update_on_cursor_moved = true,
        },
        -- Configuration for the floating progress window
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
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
        -- matchup = {
        --   enable = false, -- mandatory, false will disable the whole extension
        --   disable_virtual_text = true,
        --   -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
        --   -- [options]
        -- },
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

  'github/copilot.vim',

  -- Support for e.g. `da,`
  'wellle/targets.vim',

  -- Indentation support, e.g. '[i'
  -- The actuall mappings are in options.lua
  'jessekelighine/vindent.vim',
})
